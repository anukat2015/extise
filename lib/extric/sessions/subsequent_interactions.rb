# NOTE: counts subsequent user interactions during a session,
# i.e. interactions that happened on an element more than once

class Extric::Sessions::SubsequentInteractions
  include Extric::Common
  include Extric::Sessions::Interactions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_subsequent_interactions inside: session }
  end
end
