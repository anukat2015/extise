# NOTE: counts subsequent user selections during a session,
# i.e. selections that happened on an element more than once

class Extric::Sessions::SubsequentSelections
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_subsequent_interactions inside: session, kind: 'selection' }
  end
end
