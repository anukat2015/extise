# NOTE: counts relative lines of code of an element most recently modified by a user

class Extric::Elements::RelativeRecentLinesOfCode
  include Extric::Common

  def initialize
    @recent_lines_of_code = reuse_metric Extric::Elements::RecentLinesOfCode
  end

  def measure(user, element)
    r = @recent_lines_of_code.measure user, element

    return unless r

    { value: r[:blame][:final].to_f / r[:blame][:total].to_f }
  end
end
