# NOTE: counts user selections during a session

class Extric::Sessions::Selections
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'selection').count }
  end
end
