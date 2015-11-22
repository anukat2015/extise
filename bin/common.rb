#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

require 'auto_color'
require 'colored_defaults'
require 'fileutils'
require 'open3'
require 'optbind'
require 'nokogiri'
require 'yaml'

Colored.colorize_defaults = { extra: :bold }

trap(:SIGINT) { abort }

def load_extise!
  require 'active_support/all'

  load File.expand_path '../../Extisefile', __FILE__

  $LOAD_PATH.uniq!
end
