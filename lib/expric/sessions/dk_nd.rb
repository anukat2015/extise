class Expric::Sessions::DK_ND
  include Extric::Common

  def initialize
    @dk = reuse_metric Extric::Sessions::RecentLinesOfCode
    @nd = -> (_, _) { 1.0 }
  end

  def measure(user, session)
    dk = measure_metric @dk, user, session
    nd = @nd.call user, session

    return unless dk

    { value: dk * nd }
  end
end
