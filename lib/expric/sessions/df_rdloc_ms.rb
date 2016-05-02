class Expric::Sessions::DfRdlocMs
  include Extric::Common
  include Expric::Shared

  def initialize
    @f = reuse_metric Extric::Sessions::RelativeDefaultLinesOfCode
  end

  def measure(user, session)
    f = fetch_value via: @f, of: user, on: session
    d = calculate_decay_factor via: :memory_strength, on: session

    return unless f

    { value: f * d }
  end
end
