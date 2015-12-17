class Extisimo::Task < ActiveRecord::Base
  include Extisimo::Reference::Task
  include Extisimo::URL::Task

  alias_attribute :text, :description

  belongs_to :reporter, class_name: :User
  belongs_to :assignee, class_name: :User

  belongs_to :project

  has_many :posts, dependent: :destroy
  has_many :attachments, dependent: :destroy
end
