class Extisimo::Concept < ActiveRecord::Base
  include Extisimo::Measurable

  has_many :conceptualities, dependent: :destroy
end
