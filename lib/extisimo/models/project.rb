class Extisimo::Project < ActiveRecord::Base
  include Extisimo::Reference::Project
  include Extisimo::URL::Project

  has_many :tasks, dependent: :destroy
  has_many :posts, through: :tasks
  has_many :attachments, through: :tasks
  has_many :interactions, through: :attachments
  has_many :sessions, -> { distinct }, through: :interactions

  def collaborators
    (tasks.flat_map(&:collaborators) + repositories.flat_map(&:collaborators)).uniq
  end

  has_many :repositories, dependent: :destroy
  has_many :commits, through: :repositories
  has_many :elements, through: :commits

  def name
    "#{product} #{component}"
  end
end
