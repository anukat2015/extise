class Extisimo::Conceptuality < ActiveRecord::Base
  TYPES = Extisimo::Inferencer::TARGETS

  belongs_to :inferencer
  belongs_to :subject, polymorphic: true
  belongs_to :concept

  TYPES.each { |type| belongs_to type, -> { where subject_type: type }, foreign_key: :subject_id }

  scope :by, -> (inferencer) { where inferencer: inferencer }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject }}
  scope :of, -> (concept) { where concept: concept }
end
