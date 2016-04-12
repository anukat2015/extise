# NOTE: counts added, deleted, and modified lines of code of all elements by a user during a session

class Extric::Sessions::LinesOfCodeDelta
  def initialize
    multipliers = { additions: 1, deletions: 1, modifications: 1 }
    combinator = Extric::Elements::LinesOfCodeDeltaCombination::Combinator.new multipliers
    @combination = Extric::Sessions::LinesOfCodeDeltaCombination.new combinator
    @combination.reporting_object = self
  end

  def measure(user, session)
    @combination.measure user, session
  end
end
