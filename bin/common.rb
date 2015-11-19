#!/usr/bin/env ruby
abort 'common: internals only' if $0 == __FILE__

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

require 'optbind'
require 'fileutils'

require 'auto_color'

trap(:SIGINT) { abort }
