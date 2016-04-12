# NOTE: counts statements of all elements modified by a user during a session

class Extric::Sessions::StatementCount
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    measure_on_elements session.commit, metric: 'StatementCount'
  end
end
