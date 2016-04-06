# NOTE: counts subsequent user edits during a session,
# i.e. edits that happened on an element more than once

class Extric::Sessions::SubsequentEditsCount
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'edit').group(:file, :path).count.values.select { |c| c >= 2 }.sum }
  end
end
