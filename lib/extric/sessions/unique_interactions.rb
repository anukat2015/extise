# NOTE: counts unique user interactions during a session,
# i.e. interactions that happened on at element only once

class Extric::Sessions::UniqueInteractions
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_unique_interactions(inside: session) }
  end
end
