#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

# standard library

require 'csv'
require 'fileutils'
require 'io/console'
require 'open3'
require 'set'
require 'shellwords'
require 'yaml'

# custom utilities

require 'butcher'
require 'colored_ext'
require 'core_ext'
require 'hashugar'
require 'parallen'
require 'progresso'
require 'safe_eval'
require 'text-table'

# command line

require 'optbind'
require 'optbind_auto_describe'
require 'optbind_handlers'

# internal fixes

require 'auto_color'
require 'kernel_colors'
require 'kernel_sync'

Colored.colorize_defaults = { extra: :bold }

trap(:SIGINT) { abort }

VERSION = '0.0.0'

def options(source = ARGV)
  unless (options = source.options).respond_to? :binder
    options.define_singleton_method(:binder) { source.binder }
    options.define_singleton_method(:default) { binder.bound_defaults }
    options.define_singleton_method(:default?) { |v| binder.default? v }
    options.define_singleton_method(:bound) { binder.bound_variables }
    options.define_singleton_method(:bound?) { |v| binder.bound? v }
    options.define_singleton_method(:assigned) { binder.assigned_variables }
    options.define_singleton_method(:assigned?) { |v| binder.assigned? v }
  end
  options
end

def process(items, options = {}, &block)
  # NOTE: internal progress bar of parallel utility can not be updated
  # on batch processing, therefore a custom solution is required here
  unless options[:progress] === false
    options[:total] ||= items.count
    progress = Progresso.build options
    after_each = options[:before_each]
    options[:after_each] = -> (item, index, result) do
      after_each.call item, index, result if after_each
      progress.increment
    end
  end
  Butcher.process(items, options) do |batch|
    Parallen.process(batch, options) do |item|
      block.call item
    end
  end
end

def load_extise!
  require 'active_record'
  require 'active_support/all'

  load File.expand_path '../../Extisefile', __FILE__

  $LOAD_PATH.uniq!

  # NOTE: ensure that models are eagerly loaded since otherwise in a multi-threaded environment they may be observed
  # as only partially loaded and hence may miss some method definitions, also ensure that references from original-data
  # to custom models are present without explicit custom model requirement

  Dir[File.expand_path '../../lib/extisimo/models/*.rb', __FILE__].each { |f| require_relative f }

  def dump_attribute(k, v = nil, i = 0, o = options.bound)
    return if o[:q]
    puts "#{'  ' * i}#{k.to_s.blue}: #{v.blank? ? ('blank'.black unless o[:blank] === false) : v.to_s.yellow}"
  end

  def dump_record(r, n = nil, i = 0, o = options.bound)
    return if o[:q]
    attributes = r.is_a?(Hash) ? r.symbolize_keys : r.attributes.symbolize_keys.merge(class: r.class.name, id: r.id)
    print "#{'  ' * i}#{"#{n.to_s.blue}: " if n}"
    puts "#{attributes.delete(:class).green}#{":#{attributes[:id].to_s.yellow}" unless o[:v]}"
    attributes.to_a.tap { |a| a.sort_by! { |p| p[0] } if o[:s] }.each do |k, v|
      v = v.to_s.strip.gsub(/\r|\r?\n/, '↵')
      v = v.truncate [o[:t] - (2 * i + k.to_s.size + 1), 1].max, omission: '…' unless o[:t].zero?
      dump_attribute k, v, i + 1
    end if o[:v]
  end

  # NOTE: massive insert or insert with update of a records batch can not be performed for object hierarchies
  # in a simple way, therefore we use classic ActiveRecord methods here to avoid excessive code and keeping
  # it simple, but thus sacrificing performance

  def persist(model, keys = {})
    retries ||= 8
    # NOTE: ensures that a record is either created or updated on present
    # keys, otherwise a record is just created and never updated
    (keys.empty? ? model.new : model.find_or_initialize_by(keys)).tap do |record|
      yield record if block_given?
      record.save!
    end
  rescue ActiveRecord::RecordNotUnique => failure
    (retries -= 1) > 0 ? retry : raise(failure)
  end

  alias process_without_active_record process

  def process(items, options = {}, &block)
    after_batch = options[:after_batch]
    options[:after_batch] = -> (batch, index, results) do
      after_batch.call batch, index, results if after_batch
      ActiveRecord::Base.connection.reconnect!
    end
    process_without_active_record items, options do |item|
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        begin
          # NOTE: speeds up item persistence and ensures that on failure
          # all or none records are actually inserted or updated by the item
          connection.transaction { block.call item }
        rescue ActiveRecord::ActiveRecordError => failure
          # NOTE: retry again on transaction failure or deadlock detected since once a transaction
          # is failed it can not ever succeed again and deadlock freezes must be avoided somehow too
          [PG::InFailedSqlTransaction, PG::TRDeadlockDetected].include?(failure.cause.class) ? retry : raise(failure)
        end
      end
    end
  end

  yield if block_given?
end
