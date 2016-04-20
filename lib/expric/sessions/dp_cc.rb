class Expric::Sessions::DP_CC
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user

    # TODO implement!

    { value: nil }
  end
end
