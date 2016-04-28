# NOTE: counts tasks reported by a user in a project

class Extric::Projects::ReportedTasks
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    { value: user.reported_tasks.where(project_id: project.id).count }
  end
end
