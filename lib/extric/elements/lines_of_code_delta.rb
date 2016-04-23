# NOTE: counts added, deleted, and modified lines of code of an element by a user during a session

class Extric::Elements::LinesOfCodeDelta
  include Extric::Common

  def initialize
    coefficients = { additions: 1, deletions: 1, modifications: 1 }
    combinator = Extric::Elements::LinesOfCodeDeltaCombination::Combinator.new coefficients
    @combination = reuse_metric Extric::Elements::LinesOfCodeDeltaCombination.new combinator
  end

  def measure(user, element)
    @combination.measure user, element
  end
end
