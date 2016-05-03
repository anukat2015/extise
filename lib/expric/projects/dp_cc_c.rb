class Expric::Projects::DpCcC
  include Extric::Common
  include Expric::Shared

  def initialize
    @p = reuse_metric Expric::Sessions::DpCcC
  end

  def measure(user, project)
    t = { interactions: [attachment: :task] }
    r = user.sessions.joins(t).where(Extisimo::Task.table_name => { project_id: project.id }).distinct.to_a
    r = r.map { |session| fetch_value via: @p, of: user, on: session }.compact

    return if r.empty?

    v = Daru::Vector[*r].mean

    { value: v }
  end
end
