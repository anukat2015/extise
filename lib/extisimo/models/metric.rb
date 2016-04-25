class Extisimo::Metric < ActiveRecord::Base
  TARGETS = %w(concept element session project).freeze

  has_many :expertises, dependent: :restrict_with_exception

  scope :on, -> (target) { where target: target.to_s.singularize }

  def self.inheritance_column
    nil
  end
end
