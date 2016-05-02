# NOTE: counts relative lines of code of all elements authored by a user before a session

class Extric::Sessions::RelativeDefaultLinesOfCode
  include Extric::Common

  def initialize
    @default_lines_of_code = reuse_metric Extric::Sessions::DefaultLinesOfCode
  end

  def measure(user, session)
    r = @default_lines_of_code.measure user, session

    return unless r

    { value: r[:blame][:final].to_f / r[:blame][:total].to_f }
  end
end
