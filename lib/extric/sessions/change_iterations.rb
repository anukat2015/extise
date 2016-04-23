# NOTE: sums amounts of iterations in corresponding Gerrit changes

class Extric::Sessions::ChangeIterations
  include Extric::Common

  def measure(user, session)
    return unless user_matches? session, user

    r = { change: [extisimo_tasks: [attachments: [interactions: :session]]] }
    v = GitEclipseOrg::Message.joins(r).where(Session.table_name => { id: session.id }).distinct.count

    { value: v }
  end
end
