require 'dyna'

module Extnorm::Resolving
  def resolve_normalization!(target: nil, name: nil, method: nil)
    name = "#{name.underscore}:#{method.underscore}"
    file = File.expand_path "#{method.underscore}.rb", __dir__
    type = "Extnorm::#{method.camelize}"
    _, handle = Dyna.load_and_create! file: file, type: type { |c| c.new Daru::Vector[0] }
    raise "invalid handle at #{file}" unless handle.respond_to? :normalize
    c = handle.class
    return target, name, file, type, -> (v) { c.new v }
  end
end
