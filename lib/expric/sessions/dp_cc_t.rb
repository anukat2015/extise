class Expric::Sessions::DpCcT
  include Extric::Common
  include Expric::Shared

  def initialize
    @p = reuse_metric Extric::Sessions::CyclomaticComplexity
    @i = reuse_metric Extric::Sessions::ExtentOfEdits
  end

  def measure(user, session)
    p = fetch_value via: @p, of: user, on: session
    i = fetch_value via: @i, of: user, on: session
    t = session.duration

    return unless p && i

    { value: (p * i) / t }
  end
end
