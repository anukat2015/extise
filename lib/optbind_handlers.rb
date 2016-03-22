require 'optbind'

require 'optparse/date'
require 'optparse/shellwords'
require 'optparse/time'
require 'optparse/uri'

module OptionBinder::Handlers
  def matches(argument, regexp)
    -> (v) { regexp =~ v.to_s ? v : raise(OptionParser::InvalidArgument.new to_arg(argument)) }
  end

  def included_in(*values)
    -> (v) { values.flatten.map(&:to_s).include?(v.to_s) ? v : raise(OptionParser::InvalidArgument.new to_arg(values)) }
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
