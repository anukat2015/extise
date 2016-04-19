# NOTE: divides unique interactions by total interactions of a user during a session

class Extric::Sessions::ExtentOfInteractions
  include Extric::Common
  include Extric::Sessions::ExtentOfInteractions::Counting

  def measure(user, session)
    return unless user_matches? session, user
    { value: count_extent_of_interactions inside: session }
  end

  module Counting
    extends ActiveSupport::Concern

    include Extric::Sessions::Interactions::Counting

    def count_extent_of_interactions(inside: nil, kind: DEFAULT_KIND)
      u = count_unique_interactions inside: inside, kind: kind
      t = count_interactions inside: inside

      u.to_f / t.to_f
    end
  end
end
