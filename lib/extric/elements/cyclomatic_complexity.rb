# NOTE: computes cyclomatic complexity of an element

class Extric::Elements::CyclomaticComplexity
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'CyclomaticComplexity'
  end

  cache_measure on: :element
end
