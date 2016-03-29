module Dyna
  extend self

  def resolve_and_create!(file: nil, prefix: nil, &block)
    name, directory = File.basename(file, '.rb').underscore, File.dirname(file)
    type = [prefix, name].compact.map(&:camelize).join('::')
    object = load_and_create!(file: file, type: type, &block).last
    return file, directory, name, type, object
  end

  def load_and_create!(file: nil, type: nil, &block)
    load file
    object = block ? block.call(type.constantize) : type.constantize.new
    return file, object
  rescue LoadError
    raise "unable to load #{file}"
  rescue
    raise "unable to create #{type}"
  end
end
