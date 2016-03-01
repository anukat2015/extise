class Extisimo::Project < ActiveRecord::Base
  include Extisimo::URL::Project

  has_many :tasks, dependent: :destroy

  def collaborators
    tasks.flat_map(&:collaborators).distinct
  end

  has_many :repositories, dependent: :destroy
  has_many :commits, through: :repositories

  def name
    "#{product} #{component}"
  end
end
