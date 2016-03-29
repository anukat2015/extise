require 'active_support'

require 'dyna'
require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload_under 'concepts' do
  end

  autoload_under 'elements' do
    autoload :RecentLinesOfCode
  end

  autoload_under 'sessions' do
  end

  def self.resolve_metric!(file: nil, prefix: nil)
    _, directory, name, type, handle = Dyna.resolve_and_create! file: file, prefix: prefix
    target = File.basename(directory).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Metric::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :measure
    return target, name, file, type, handle
  end
end
