#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

require 'auto_color'
require 'colored_defaults'
require 'fileutils'
require 'io_open_extension'
require 'open3'
require 'optbind'
require 'nokogiri'
require 'yaml'

Colored.colorize_defaults = { extra: :bold }

trap(:SIGINT) { abort }

def load_extise!
  require 'active_record'
  require 'active_support/all'

  load File.expand_path '../../Extisefile', __FILE__

  $LOAD_PATH.uniq!

  # TODO mv methods below, load them only for extise import scripts

  def dump(r, n = nil, i = 0, o = options.bound)
    return if o[:q]
    puts "#{'  ' * i}#{"#{n.to_s.blue}: " if n}#{r.class.name.green}#{":#{r.id.to_s.yellow}" unless o[:v]}"
    r.attributes.to_a.tap { |a| a.sort_by! { |p| p[0] } if o[:s] }.each do |k, v|
      prop k, v.to_s.strip.gsub(/\r|\r?\n/, '↵').truncate([o[:t] - (2 * i + k.to_s.size + 1), 1].max, omission: '…'), i + 1
    end if o[:v]
  end

  def prop(k, v, i = 0)
    puts "#{'  ' * i}#{k.to_s.blue}: #{v == nil ? 'nil'.black : v.to_s.yellow}"
  end

  def persist(c, k)
    x = k.delete :xml
    c.find_or_initialize_by(k).tap do |r|
      yield r
      r.save!
    end
  rescue => e
    Open3.popen2(File.expand_path 'lsxml', __dir__) do |i, o|
      i.puts x
      i.close
      puts "\nXML-DEBUG:\n\n#{o.read}\n"
    end if x
    e.is_a?(ActiveRecord::ActiveRecordError) ? abort(e.message) : raise(e)
  end

  def persist_user(l, r = [])
    persist(User, login_name: l) do |u|
      u.realnames = (u.realnames.to_a + [r]).flat_map(&:presence).compact.uniq
    end
  end
end
