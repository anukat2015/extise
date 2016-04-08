# NOTE: counts statements of an element

class Extric::Elements::TypeCount
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'StatementCount'
  end

  cache_measure on: :element
end
