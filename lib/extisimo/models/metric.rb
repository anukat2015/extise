class Extisimo::Metric < ActiveRecord::Base
  TARGETS = %i(concept element session).freeze

  has_many :expertises, dependent: :restrict_with_exception

  scope :on, -> (target) { where target: target.to_s.singularize }
end
