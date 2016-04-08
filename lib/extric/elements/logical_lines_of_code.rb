# NOTE: counts logical lines of code of an element

class Extric::Elements::LogicalLinesOfCode
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'LogicalLinesOfCode'
  end

  cache_measure on: :element
end
