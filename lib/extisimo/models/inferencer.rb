class Extisimo::Inferencer < ActiveRecord::Base
  has_many :conceptualities, dependent: :destroy
end
