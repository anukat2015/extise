# NOTE: counts user interactions during a session

class Extric::Sessions::Interactions
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_interactions(inside: session) }
  end
end
