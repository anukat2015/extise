# NOTE: counts inclusive user edits during a session,
# i.e. edits that happened on an element more than once

class Extric::Sessions::InclusiveEditsCount
  include Extric::Common

  def measure(user, session)
    # TODO refactor to pure SQL

    return unless user_matches? session, user
    { value: session.interactions.where(kind: 'edit').group(:file, :path).count('*').values.select { |c| c > 1 }.sum }
  end
end
