require 'colored'
require 'statsample'

class Statsample::Bivariate::Pearson
  def p
    !r.nan? ? probability : Float::NAN
  rescue Math::DomainError
    Float::NAN
  end
end

module Statsample::Colored
  extend self

  def colorize_samples(x, t = nil, &b)
    colorize x, t && Integer(x) >= t ? :white : :black, &b
  end

  alias_method :colorize_x, :colorize_samples
  alias_method :colorize_y, :colorize_samples

  def colorize_method(x, t = %w(pearson spearman), &b)
    colorize x, t.include?(x.to_s) ? :blue : :black, &b
  end

  alias_method :colorize_m, :colorize_method

  # NOTE: colorize correlation coefficient according to its sign

  def colorize_coefficient(x, t = 0.0, &b)
    f = Float x
    colorize x, f.nan? ? :black : (f == t ? :yellow : (f > t ? :green : :red)), &b
  end

  alias_method :colorize_r, :colorize_coefficient

  # NOTE: colorize significant difference between population means greater or equal to 2.0

  def colorize_t_test(x, t = 2.0, &b)
    colorize x, Float(x) >= t ? :cyan : :black, &b
  end

  alias_method :colorize_t, :colorize_t_test

  # NOTE: colorize statistical significance lower or equal to 0.05

  def colorize_p_value(x, t = 0.05, &b)
    colorize x, Float(x) <= t ? :cyan : :black, &b
  end

  alias_method :colorize_p, :colorize_p_value

  private

  def colorize(x, c, &b)
    (b ? (b.call x).to_s : x.to_s).public_send c
  end
end
