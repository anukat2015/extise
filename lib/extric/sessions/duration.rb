# NOTE: measures a session duration

class Extric::Sessions::Duration
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.duration }
  end
end
