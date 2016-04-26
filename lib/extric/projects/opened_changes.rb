# NOTE: counts Gerrit changes opened by a user in a project

class Extric::Projects::OpenedChanges
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    c = { project: project, GitEclipseOrg::Change.table_name => { owner_id: user.git_eclipse_org_users }}
    v = Extisimo::Task.joins(:git_eclipse_org_changes).where(c).count

    { value: v }
  end
end
