# NOTE: counts lines of code of an element

class Extric::Elements::LinesOfCode
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'LinesOfCode'
  end

  cache_measure on: :element
end
