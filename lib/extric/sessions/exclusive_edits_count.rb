# NOTE: counts exclusive user edits during a session,
# i.e. edits that happened on at element only once

class Extric::Sessions::ExclusiveEditsCount
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'edit').select(:file, :path).distinct.count('path') }
  end
end
