# NOTE: sums amount of Gerrit change iterations of tasks associated with a session

class Extric::Sessions::ChangeIterations
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user

    v = fetch_change_messages(of: session).count

    return if v.zero?

    { value: v }
  end
end
