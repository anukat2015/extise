require 'optbind'

require 'optparse/date'
require 'optparse/shellwords'
require 'optparse/time'
require 'optparse/uri'

module OptionBinder::Handlers
  def matches(regexp)
    -> (v) { regexp =~ v.to_s ? v : raise(OptionParser::InvalidArgument, v) }
  end

  def included_in(*values)
    -> (v) { values.flatten.map(&:to_s).include?(v.to_s) ? v : raise(OptionParser::InvalidArgument, v) }
  end

  def as_time_with(special = {})
    lambda do |v|
      return unless v
      s = special[v.to_s.to_sym]
      return s.arity == 1 ? s.call(v) : s.call if s
      Time.httpdate(v) rescue Time.parse(v)
    end
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
