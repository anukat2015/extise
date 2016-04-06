# NOTE: counts inclusive user edits during a session,
# i.e. edits that happened on an element more than once

class Extric::Sessions::InclusiveEditsCount
  include Extric::Sessions

  def measure(user, session)
    return unless session_user_matches! user, session
    { value: session.interactions.where(kind: 'edit').group(:file, :path).count('*').select { |_, c| c > 1 }.sum }
  end
end
