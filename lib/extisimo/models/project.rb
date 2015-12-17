class Extisimo::Project < ActiveRecord::Base
  include Extisimo::URL::Project

  has_many :tasks, dependent: :destroy
  has_many :repositories, dependent: :destroy

  def name
    "#{product} #{component}"
  end
end
