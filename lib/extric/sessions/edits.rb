# NOTE: counts user edits during a session

class Extric::Sessions::Edits
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'edit').count }
  end
end
