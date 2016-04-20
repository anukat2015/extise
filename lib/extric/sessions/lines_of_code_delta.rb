# NOTE: counts added, deleted, and modified lines of code of all elements by a user during a session

class Extric::Sessions::LinesOfCodeDelta
  include Extric::Common

  def initialize
    multipliers = { additions: 1, deletions: 1, modifications: 1 }
    combinator = Extric::Elements::LinesOfCodeDeltaCombination::Combinator.new multipliers
    @combination = reuse_metric Extric::Sessions::LinesOfCodeDeltaCombination.new combinator
  end

  def measure(user, session)
    @combination.measure user, session
  end
end
