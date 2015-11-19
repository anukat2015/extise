require 'colored'

module Colored
  extend self

  attr_accessor :colorize_defaults

  alias_method :raw_colorize, :colorize

  def colorize(s, options = {})
    raw_colorize s, (Colored.colorize_defaults || {}).merge(options)
  end
end

String.send(:include, Colored)
