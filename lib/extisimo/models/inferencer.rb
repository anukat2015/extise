class Extisimo::Inferencer < ActiveRecord::Base
  TARGETS = %i(element task).freeze

  has_many :conceptualities, dependent: :restrict_with_exception

  scope :on, -> (target) { where target: target.to_s.singularize }

  def self.inheritance_column
    nil
  end
end
