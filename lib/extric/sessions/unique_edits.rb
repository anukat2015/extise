# NOTE: counts unique user edits during a session,
# i.e. edits that happened on at element only once

class Extric::Sessions::UniqueEdits
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_unique_interactions inside: session, kind: 'edit' }
  end
end
