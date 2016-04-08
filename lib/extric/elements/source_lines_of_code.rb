# NOTE: counts source lines of code of an element

class Extric::Elements::SourceLinesOfCode
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'SourceLinesOfCode'
  end

  cache_measure on: :element
end
