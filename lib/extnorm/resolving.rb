require 'dyna'

module Extnorm::Resolving
  def resolve_normalization!(target: nil, name: nil, method: nil)
    name = "#{name.to_s.underscore}:#{method.to_s.underscore}"
    file = File.expand_path "#{method.to_s.underscore}.rb", __dir__
    type = "Extnorm::#{method.to_s.camelize}"
    _, handle = Dyna.load_and_create!(file: file, type: type) { |c| c.new Daru::Vector[0] }
    raise "invalid handle at #{file}" unless handle.respond_to? :normalize
    c = handle.class
    return target, name, file, type, -> (v) { c.new v }
  end
end
