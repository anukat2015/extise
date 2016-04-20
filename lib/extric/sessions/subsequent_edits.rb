# NOTE: counts subsequent user edits during a session,
# i.e. edits that happened on an element more than once

class Extric::Sessions::SubsequentEdits
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_subsequent_interactions(inside: session, kind: 'edit') }
  end
end
