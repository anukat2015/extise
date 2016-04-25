# NOTE: sums amount of change iterations of tasks associated with a session

class Extric::Sessions::ChangeIterations
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user
    { value: fetch_change_messages(of: session).count }
  end
end
