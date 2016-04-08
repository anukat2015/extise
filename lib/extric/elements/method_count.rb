# NOTE: counts method declarations of an element

class Extric::Elements::MethodCount
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'MethodCount'
  end

  cache_measure on: :element
end
