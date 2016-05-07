# NOTE: counts relative lines of code of an element authored by a user

class Extric::Elements::RelativeDefaultLinesOfCode
  include Extric::Common

  def initialize
    @default_lines_of_code = reuse_metric Extric::Elements::DefaultLinesOfCode
  end

  def measure(user, element)
    r = @default_lines_of_code.measure user, element

    return unless r

    { value: r[:blame][:final].to_f / r[:blame][:total].to_f }
  end
end
