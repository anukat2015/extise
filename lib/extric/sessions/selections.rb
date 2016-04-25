# NOTE: counts user selections during a session

class Extric::Sessions::Selections
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_interactions(inside: session, kind: 'selection') }
  end
end
