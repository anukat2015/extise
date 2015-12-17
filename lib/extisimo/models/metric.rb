class Extisimo::Metric < ActiveRecord::Base
  has_many :expertises, dependent: :destroy
end
