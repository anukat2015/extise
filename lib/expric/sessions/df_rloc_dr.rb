class Expric::Sessions::DfRlocDr
  include Extric::Common
  include Expric::Shared

  def initialize
    @familiarity = reuse_metric Extric::Sessions::RecentLinesOfCode
  end

  def measure(user, session)
    f = fetch_value via: @familiarity, of: user, on: session
    d = calculate_decay_factor via: :duration_ratio, on: session

    return unless f

    { value: f * d }
  end
end
