class Expric::Sessions::DpLocdcC
  include Extric::Common
  include Expric::Shared

  def measure(user, session)
    return unless user_matches? session, user

    # TODO implement!

    { value: nil }
  end
end
