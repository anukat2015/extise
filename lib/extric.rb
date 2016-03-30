require 'active_support'

require 'dyna'
require 'extisimo'
require 'extric/version'

module Extric
  module Concepts
    extend ActiveSupport::Autoload
  end

  module Elements
    extend ActiveSupport::Autoload

    autoload :CommonLinesOfCode
    autoload :RecentLinesOfCode
  end

  module Sessions
    extend ActiveSupport::Autoload

    autoload :CommonLinesOfCode
  end

  def self.resolve_metric!(file: nil, library: nil)
    _, name, type, handle = Dyna.resolve_and_create! file: file, library: library
    target = File.basename(File.dirname file).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Metric::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :measure
    return target, name, file, type, handle
  end
end
