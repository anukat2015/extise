# NOTE: counts user edits during a session

class Extric::Sessions::EditsCount
  include Extric::Sessions

  def measure(user, session)
    return unless session_user_matches! user, session
    { value: session.interactions.where(kind: 'edit').count }
  end
end
