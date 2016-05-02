# NOTE: counts relative lines of code of all elements most recently modified by a user during a session

class Extric::Sessions::RelativeRecentLinesOfCode
  include Extric::Common

  def initialize
    @recent_lines_of_code = reuse_metric Extric::Sessions::RecentLinesOfCode
  end

  def measure(user, session)
    r = @recent_lines_of_code.measure user, session

    return unless r

    { value: r[:blame][:final].to_f / r[:blame][:total].to_f }
  end
end
