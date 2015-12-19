class Extisimo::Repository < ActiveRecord::Base
  include Extisimo::URL::Repository

  belongs_to :project

  has_many :tasks, through: :project

  has_many :commits, dependent: :destroy
end
