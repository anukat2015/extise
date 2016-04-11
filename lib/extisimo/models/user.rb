class Extisimo::User < ActiveRecord::Base
  include Extisimo::Reference::User
  include Extisimo::URL::User

  has_many :tasks, foreign_key: :assignee_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :attachments, foreign_key: :author_id, dependent: :destroy
  has_many :commits, foreign_key: :author_id, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :expertises, dependent: :destroy

  scope :has_assigned_tasks, -> { joins(:tasks).distinct.merge Extisimo::Task.assigned_to self }
  scope :has_reported_tasks, -> { joins(:tasks).distinct.merge Extisimo::Task.reported_by self }
  scope :has_posts, -> { joins(:posts).distinct }
  scope :has_attachments, -> { joins(:attachments).distinct }

  alias_scope :has_tasks, :has_assigned_tasks

  def self.fetch(n = nil)
    return Extisimo::User unless n
    condition = <<-SQL.gsub(/\n/, ' ').squeeze(' ')
      extisimo_users.name = ? OR
      bugs_eclipse_org_users.login_name = ? OR bugs_eclipse_org_users.realnames @> ? OR
      git_eclipse_org_users.username = ? OR git_eclipse_org_users.name = ?
    SQL
    Extisimo::User.joins(:bugs_eclipse_org_user, :git_eclipse_org_user).where condition, *[n] * 5
  end
end
