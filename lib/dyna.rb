module Dyna
  extend self

  def resolve_and_create!(file: nil, library: nil, &block)
    name, directory = File.basename(file, '.rb').underscore, File.dirname(file)
    prefix = File.join '.*', library ? File.dirname(library) : 'lib'
    modules = directory.sub(/\A#{prefix}/, '').split(File::SEPARATOR).reject(&:empty?)
    type = (modules << name).map(&:camelize).join('::')
    object = load_and_create!(file: file, type: type, &block).last
    return file, name, type, object
  end

  def load_and_create!(file: nil, type: nil, &block)
    load file unless defined? type
    object = block ? block.call(type.constantize) : type.constantize.new
    return file, object
  rescue LoadError, SyntaxError
    raise "unable to load #{file}"
  rescue
    raise "unable to create #{type}"
  end
end
