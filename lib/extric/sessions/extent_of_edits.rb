# NOTE: divides unique edits by total interactions of a user during a session

class Extric::Sessions::ExtentOfEdits
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_extent_interactions(inside: session, kind: 'edit') }
  end
end
