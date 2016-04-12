# NOTE: counts source lines of code of all elements modified by a user during a session

class Extric::Sessions::SourceLinesOfCode
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    measure_on_elements session.commit, metric: 'SourceLinesOfCode'
  end
end
