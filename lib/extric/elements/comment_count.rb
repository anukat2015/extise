# NOTE: counts comments of an element

class Extric::Elements::CommentCount
  include Extric::Common

  def measure(_, element)
    measure_on_element element, metric: 'CommentCount'
  end

  cache_measure on: :element
end
