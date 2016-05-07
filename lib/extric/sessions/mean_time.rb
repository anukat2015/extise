# NOTE: measures a session mean time

class Extric::Sessions::MeanTime
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: (session.started_at.to_f + session.finished_at.to_s) / 2 }
  end
end
