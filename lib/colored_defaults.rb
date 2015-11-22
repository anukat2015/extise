require 'colored'

module Colored
  extend self

  attr_accessor :colorize_defaults

  alias_method :raw_colorize, :colorize

  def colorize(s, options = {})
    raw_colorize s, (Colored.colorize_defaults || {}).merge(options)
  end

  alias_method :emphasize, :bold

  def no_foreground
    self.gsub(/\e\[3[0-7]m/, '')
  end

  def no_background
    self.gsub(/\e\[4[0-7]m/, '')
  end

  def no_extras
    self.gsub(/\e\[[147]m/, '')
  end
end

String.send(:include, Colored)
