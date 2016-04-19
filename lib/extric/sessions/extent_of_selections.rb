# NOTE: divides unique selections by total interactions of a user during a session

class Extric::Sessions::ExtentOfSelections
  include Extric::Common
  include Extric::Sessions::ExtentOfInteractions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_extent_of_interactions inside: session, kind: 'selection' }
  end
end
