# NOTE: counts comment lines of code of an element

class Extric::Elements::CommentLinesOfCode
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'CommentLinesOfCode'
  end

  cache_measure on: :element
end
