# NOTE: counts user edits during a session

class Extric::Sessions::Edits
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_interactions(inside: session, kind: 'edit') }
  end
end
