# NOTE: sums amount of change uploads of tasks associated with a session

class Extric::Sessions::ChangeUploads
  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user

    # NOTE: actually finds a patch set upload with the highest number since some uploads may be missing

    v = fetch_change_messages(of: session).pluck(:message).map { |m|
      Integer(m.match(/\A\s*uploade?d?\s+patch\s+set\s+(\d+)/i).to_a[1]) rescue 0
    }.max

    return unless v

    { value: v }
  end
end
