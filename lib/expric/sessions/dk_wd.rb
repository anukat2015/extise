class Expric::Sessions::DK_WD
  include Extric::Common

  def initialize
    @dk = reuse_metric Extric::Sessions::RecentLinesOfCode
    @wd = -> (_, session) { 1.0 / ((context[:until] - session.finished_at) / 1.day).ceil }
  end

  def measure(user, session)
    dk = measure_metric @dk, user, session
    wd = @ms.call user, session

    return unless dk

    { value: dk * wd }
  end
end
