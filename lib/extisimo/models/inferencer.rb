class Extisimo::Inferencer < ActiveRecord::Base
  TARGETS = %w(element task).freeze

  has_many :conceptualities, dependent: :restrict_with_exception
end
