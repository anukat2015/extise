class Extisimo::Inferencer < ActiveRecord::Base
  has_many :conceptualities, dependent: :restrict_with_exception
end
