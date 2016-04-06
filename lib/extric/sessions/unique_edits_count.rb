# NOTE: counts unique user edits during a session,
# i.e. edits that happened on at element only once

class Extric::Sessions::UniqueEditsCount
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'edit').group(:file, :path).count.values.select { |c| c == 1 }.sum }
  end
end
