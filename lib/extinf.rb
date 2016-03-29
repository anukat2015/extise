require 'active_support'

require 'dyna'
require 'extisimo'
require 'extinf/version'

module Extinf
  extend ActiveSupport::Autoload

  autoload_under 'elements' do
  end

  autoload_under 'tasks' do
  end

  def self.resolve_inferencer!(file: nil, prefix: nil)
    _, directory, name, type, handle = Dyna.resolve_and_create! file: file, prefix: prefix
    target = File.basename(directory).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Inferencer::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :inference
    return target, name, file, type, handle
  end
end
