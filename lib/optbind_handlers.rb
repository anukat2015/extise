require 'optbind'

module OptionBinder::Handlers
  def matches(argument, regexp)
    -> (v) { regexp =~ v ? v : raise(OptionParser::InvalidArgument.new to_arg(argument)) }
  end

  def included_in(*values)
    -> (v) { values.flatten.include?(v) ? v : raise(OptionParser::InvalidArgument.new to_arg(values)) }
  end

  def to_arg(v)
    case v
    when Array
      "(#{v.flatten * '|'})"
    when Time
      '<time>'
    else
      v
    end
  end
end

OptionBinder.prepend OptionBinder::Handlers
