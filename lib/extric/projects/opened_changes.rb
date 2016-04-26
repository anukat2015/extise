# NOTE: counts Gerrit changes opened by a user in a project

class Extric::Projects::OpenedChanges
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    { value: user.reported_tasks.joins(:git_eclipse_org_changes).where(project: project, owner: user).count }
  end
end
