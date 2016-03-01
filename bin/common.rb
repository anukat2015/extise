#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

require 'auto_color'
require 'colored_defaults'
require 'fileutils'
require 'io/console'
require 'io_open_conditional'
require 'open3'
require 'optbind'
require 'optbind_auto_describe'
require 'nokogiri'
require 'parallen'
require 'rugged'
require 'shellwords'
require 'yaml'

Colored.colorize_defaults = { extra: :bold }

trap(:SIGINT) { abort }

# TODO move VERSION to each executable file
VERSION = '0.0.0'

def options(source = ARGV)
  unless (options = source.options).respond_to? :binder
    options.define_singleton_method(:binder) { source.binder }
    options.define_singleton_method(:default) { binder.bound_defaults }
    options.define_singleton_method(:default?) { |v| binder.default? v }
    options.define_singleton_method(:bound) { binder.bound_variables }
    options.define_singleton_method(:bound?) { |v| binder.bound? v }
    options.define_singleton_method(:assigned) { binder.bound_variables }
    options.define_singleton_method(:assigned?) { |v| binder.assigned? v }
  end
  options
end

def load_extise!
  require 'active_record'
  require 'active_support/all'

  load File.expand_path '../../Extisefile', __FILE__

  $LOAD_PATH.uniq!

  # TODO mv methods below, load them only for extise import scripts
  def dump_attribute(k, v = nil, i = 0, o = options.bound)
    return if o[:q]
    puts "#{'  ' * i}#{k.to_s.blue}: #{v == nil ? 'nil'.black : v.to_s.yellow}"
  end

  def dump_record(r, n = nil, i = 0, o = options.bound)
    return if o[:q]
    puts "#{'  ' * i}#{"#{n.to_s.blue}: " if n}#{r.class.name.green}#{":#{r.id.to_s.yellow}" unless o[:v]}"
    r.attributes.to_a.tap { |a| a.sort_by! { |p| p[0] } if o[:s] }.each do |k, v|
      v = v.to_s.strip.gsub(/\r|\r?\n/, '↵').truncate [o[:t] - (2 * i + k.to_s.size + 1), 1].max, omission: '…'
      dump_attribute k, v, i + 1
    end if o[:v]
  end

  # NOTE: massive insert or insert with update of a records batch can not be performed for object hierarchies
  # in a simple way, therefore we use classic ActiveRecord methods here to avoid excessive code and keeping
  # it simple, but thus sacrificing performance

  def persist(model, keys = {})
    xml = keys.delete :xml
    # NOTE: ensures that a record is either created or updated on present
    # keys, otherwise a record is just created and never updated
    (keys.empty? ? model.new : model.find_or_initialize_by(keys)).tap do |record|
      yield record if block_given?
      record.save!
    end
  rescue ActiveRecord::RecordNotUnique
    retry
  rescue => failure
    Open3.popen2e(File.expand_path 'lsxml', __dir__) do |i, o, t|
      i.puts xml
      i.close
      Thread.new {
        warn "\n--#{'XML-DEBUG'.red}--\n\n"
        o.each { |l| warn l }
        warn "\n--#{'XML-DEBUG'.red}--\n\n"
      }.join
      t.join
    end if xml
    failure.is_a?(ActiveRecord::ActiveRecordError) ? abort(failure.message.to_s.red) : raise(failure)
  end

  def process(items, options = {}, &block)
    # NOTE: internal progress bar of parallel utility can not be updated
    # on batch processing, therefore a custom solution is required here
    options[:total] = items.count
    progress = Progresso.build options
    if progress
      after_each = options[:before_each]
      options[:after_each] = lambda do |item, index, result|
        after_each.call item, index, result if after_each
        progress.increment
      end
    end
    Butcher.process(items, options) do |batch|
      results = Parallen.process(batch, options) do |item|
        ActiveRecord::Base.connection_pool.with_connection { block.call item }
      end
      ActiveRecord::Base.connection.reconnect!
      results
    end
  end
end
