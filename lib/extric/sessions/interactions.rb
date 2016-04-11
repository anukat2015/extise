# NOTE: counts user interactions during a session

class Extric::Sessions::Interactions
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.count }
  end
end