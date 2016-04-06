# NOTE: counts user interactions during a session

class Extric::Sessions::InteractionsCount
  include Extric::Sessions

  def measure(user, session)
    return unless session_user_matches! user, session
    { value: session.interactions.count }
  end
end
