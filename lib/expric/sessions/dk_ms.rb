class Expric::Sessions::DK_MS
  MEMORY_STRENGTH = 30

  include Extric::Common

  def initialize
    @dk = reuse_metric Extric::Sessions::RecentLinesOfCode
    @ms = -> (_, session) { ((context[:until] - session.finished_at) / 1.week).ceil / MEMORY_STRENGTH }
  end

  def measure(user, session)
    dk = measure_metric @dk, user, session
    ms = @ms.call user, session

    return unless dk

    { value: dk * ms }
  end
end
