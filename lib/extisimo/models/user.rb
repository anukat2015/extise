class Extisimo::User < ActiveRecord::Base
  include Extisimo::Reference::User
  include Extisimo::URL::User

  has_many :reported_tasks, class_name: :Task, foreign_key: :reporter_id, dependent: :destroy
  has_many :assigned_tasks, class_name: :Task, foreign_key: :assignee_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :attachments, foreign_key: :author_id, dependent: :destroy
  has_many :interactions, through: :attachments
  has_many :commits, foreign_key: :author_id, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :expertises, dependent: :destroy

  alias_association :tasks, :assigned_tasks

  scope :has_reported_tasks, -> { joins(:tasks).distinct.merge Extisimo::Task.reported_by self }
  scope :has_assigned_tasks, -> { joins(:tasks).distinct.merge Extisimo::Task.assigned_to self }
  scope :has_posts, -> { joins(:posts).distinct }
  scope :has_attachments, -> { joins(:attachments).distinct }

  alias_scope :has_tasks, :has_assigned_tasks

  scope :ambiguous, -> { where 'name LIKE ?', "%#{Extisimo::Naming::UNKNOWN_NAME}%" }
  scope :unambiguous, -> { where 'name NOT LIKE ?', "%#{Extisimo::Naming::UNKNOWN_NAME}%" }

  def self.fetch(*args)
    args = args.flatten.compact

    return Extisimo::User.all if args.empty?
    return Extisimo::User.where id: args if findable? args
    Extisimo::User.where 'name IN (?) OR eclipse_org_user_names && ?', args, "{#{args * ','}}"
  end
end
