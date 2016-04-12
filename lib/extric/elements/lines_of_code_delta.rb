# NOTE: counts added, deleted, and modified lines of code of an element by a user during a session

class Extric::Elements::LinesOfCodeDelta
  def initialize
    multipliers = { additions: 1, deletions: 1, modifications: 1 }
    combinator = Extric::Elements::LinesOfCodeDeltaCombination::Combinator.new multipliers
    @combination = Extric::Elements::LinesOfCodeDeltaCombination.new combinator
    @combination.reporting_object = self
  end

  def measure(user, element)
    @combination.measure user, element
  end
end
