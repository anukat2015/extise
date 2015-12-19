class Extisimo::Metric < ActiveRecord::Base
  has_many :expertises, dependent: :restrict_with_exception
end
