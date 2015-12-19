class Extisimo::Task < ActiveRecord::Base
  include Extisimo::Inferencible
  include Extisimo::Reference::Task
  include Extisimo::URL::Task

  alias_attribute :text, :description

  belongs_to :reporter, class_name: :User
  belongs_to :assignee, class_name: :User

  belongs_to :project

  has_many :posts, dependent: :destroy
  has_many :attachments, dependent: :destroy

  has_many :interactions, through: :attachments
  has_many :sessions, through: :interactions

  def collaborators
    Extisimo::User.find [reporter, assignee] + posts.pluck(:author_id) + attachments.pluck(:author_id)
  end

  scope :reported_by, -> (user) { where reporter: user }
  scope :assigned_to, -> (user) { where assignee: user }

  alias_scope :by, :reported_by
  alias_scope :for, :assigned_to

  scope :with_posts, -> { joins(:posts).uniq }
  scope :with_attachments, -> { joins(:attachments).uniq }
end
