require 'dyna'

module Extric::Resolving
  def resolve_metric!(file: nil, library: nil)
    _, name, type, handle = Dyna.resolve_and_create! file: file, library: library
    target = File.basename(File.dirname file).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Metric::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :measure
    return target, name, file, type, handle
  end
end
