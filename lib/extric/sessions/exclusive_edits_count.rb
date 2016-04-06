# NOTE: counts exclusive user edits during a session,
# i.e. edits that happened on at element only once

class Extric::Sessions::ExclusiveEditsCount
  include Extric::Sessions

  def measure(user, session)
    return unless session_user_matches! user, session
    { value: session.interactions.where(kind: 'edit').select(:file, :path).distinct.count('path') }
  end
end
