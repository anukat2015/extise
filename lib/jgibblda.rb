require 'jarun'

module JGibbLDA
  VERSION = '1.0.0'

  extend Jarun

  self.binary = File.expand_path "jgibblda-#{VERSION}.jar", __dir__

  self.max_heap_size = '512m'

  # TODO add some helpers as in extise.rb
end
