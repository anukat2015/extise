# NOTE: counts unique user selections during a session,
# i.e. selections that happened on at element only once

class Extric::Sessions::UniqueSelections
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_unique_interactions(inside: session, kind: 'selection') }
  end
end
