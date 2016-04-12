# NOTE: counts method declarations of all elements modified by a user during a session

class Extric::Sessions::MethodCount
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    measure_on_elements session.commit, metric: 'MethodCount'
  end
end
