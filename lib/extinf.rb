require 'active_support'

require 'dyna'
require 'extisimo'
require 'extinf/version'

module Extinf
  module Elements
    extend ActiveSupport::Autoload
  end

  module Tasks
    extend ActiveSupport::Autoload
  end

  def self.resolve_inferencer!(file: nil, library: nil)
    _, name, type, handle = Dyna.resolve_and_create! file: file, library: library
    target = File.basename(File.dirname file).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Inferencer::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :inference
    return target, name, file, type, handle
  end
end
