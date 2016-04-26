# NOTE: counts Gerrit changes reviewed by a user in a project

class Extric::Projects::ReviewedChanges
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    { value: user.reported_tasks.joins(git_eclipse_org_changes: :labels).where(project: project, user: user).count }
  end
end
