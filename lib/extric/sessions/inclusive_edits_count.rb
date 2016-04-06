# NOTE: counts inclusive user edits during a session,
# i.e. edits that happened on an element more than once

class Extric::Sessions::InclusiveEditsCount
  include Extric::Sessions

  def measure(user, session)
    # TODO refactor to pure SQL

    return unless session_user_matches! user, session
    { value: session.interactions.where(kind: 'edit').group(:file, :path).count('*').values.select { |c| c > 1 }.sum }
  end
end
