# NOTE: counts user selections during a session

class Extric::Sessions::SelectionsCount
  include Extric::Sessions

  def measure(user, session)
    return unless session_user_matches! user, session
    { value: session.interactions.where(kind: 'selection').count }
  end
end
