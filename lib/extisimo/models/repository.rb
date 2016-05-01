class Extisimo::Repository < ActiveRecord::Base
  include Extisimo::Reference::Repository
  include Extisimo::URL::Repository

  belongs_to :project

  has_many :tasks, through: :project

  has_many :commits, dependent: :destroy

  def collaborators
    Extisimo::User.find commits.pluck :author_id
  end
end
