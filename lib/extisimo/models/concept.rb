class Extisimo::Concept < ActiveRecord::Base
  has_many :conceptualities, dependent: :destroy
end
