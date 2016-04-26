# NOTE: counts tasks assigned to a user in a project

class Extric::Projects::AssignedTasks
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    { value: user.assigned_tasks.joins(:project).where(project: project).count }
  end
end
