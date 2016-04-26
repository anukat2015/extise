# NOTE: counts Gerrit changes reviewed by a user in a project

class Extric::Projects::ReviewedChanges
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    c = { project: project, GitEclipseOrg::Label.table_name => { user_id: user.git_eclipse_org_users }}
    v = Extisimo::Task.joins(git_eclipse_org_changes: :labels).where(c).count

    { value: v }
  end
end
