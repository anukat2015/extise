module Extric::Shared
  DEFAULT_KIND = %w(edit selection)

  extend ActiveSupport::Concern

  def fetch_tasks(of: nil)
    through = { attachments: [interactions: :session] }
    Extisimo::Task.left_joins(through).where(Session.table_name => { id: of.id }).distinct
  end

  def fetch_change_messages(of: nil)
    through = { change: [extisimo_tasks: [attachments: [interactions: :session]]] }
    GitEclipseOrg::Message.left_joins(through).where(Session.table_name => { id: of.id }).distinct
  end

  def count_interactions(inside: nil, kind: DEFAULT_KIND)
    inside.interactions.of(kind).count
  end

  def count_unique_interactions(inside: nil, kind: DEFAULT_KIND)
    inside.interactions.of(kind).group(:file, :path).count.values.select { |c| c == 1 }.sum
  end

  def count_subsequent_interactions(inside: nil, kind: DEFAULT_KIND)
    inside.interactions.of(kind).group(:file, :path).count.values.select { |c| c >= 2 }.sum
  end

  def count_extent_interactions(inside: nil, kind: DEFAULT_KIND)
    u = count_unique_interactions inside: inside, kind: kind
    t = count_interactions inside: inside

    u.to_f / t if t != 0
  end
end
