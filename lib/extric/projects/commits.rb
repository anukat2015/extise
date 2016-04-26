# NOTE: counts commits authored by a user in a project

class Extric::Projects::Commits
  include Extric::Common
  include Extric::Shared

  def measure(user, project)
    { value: user.commits.joins(:repository).where(Repository.table_name => { project_id: project.id }).count }
  end
end
