#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

require 'auto_color'
require 'colored_defaults'
require 'fileutils'
require 'io_open_conditional'
require 'open3'
require 'optbind'
require 'optbind_auto_describe'
require 'nokogiri'
require 'parallel'
require 'ruby-progressbar'
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

  def persist(model, attributes = {})
    xml = attributes.delete :xml
    # NOTE: ensures that a record is either created or updated, and initialized with attributes
    # when present, otherwise a record is just created with no attributes, never updated
    (attributes.empty? ? model.new : model.find_or_initialize_by(attributes)).tap do |record|
      yield record if block_given?
      record.save!
    end
  rescue ActiveRecord::RecordNotUnique
    model.find_by(attributes) || raise(ActiveRecord::RecordNotFound)
  rescue => failure
    Open3.popen2e(File.expand_path 'lsxml', __dir__) do |i, o, t|
      i.puts xml
      i.close
      Thread.new {
        STDERR.print "\n--#{'XML-DEBUG'.red}--\n\n"
        o.each { |l| STDERR.print l }
        STDERR.print "\n--#{'XML-DEBUG'.red}--\n\n"
      }.join
      t.join
    end if xml
    failure.is_a?(ActiveRecord::ActiveRecordError) ? abort(failure.message.to_s.red) : raise(failure)
  end

  def process(items, options = {})
    options = {
      "in_#{options[:worker].to_s.pluralize}".to_sym => options[:count],
      progress: options[:count] != 0 ? { format: '%E %B %c/%C %P%%', progress_mark: '-' } : nil
    }

    Parallel.map(items, options) do |item|
      ActiveRecord::Base.connection_pool.with_connection do
        yield item
      end
    end
  end
end
