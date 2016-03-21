class Extisimo::Metric < ActiveRecord::Base
  TARGETS = %w(concept element session).freeze

  has_many :expertises, dependent: :restrict_with_exception
end
