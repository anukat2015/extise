class Extisimo::Conceptuality < ActiveRecord::Base
  belongs_to :inferencer
  belongs_to :subject, polymorphic: true
  belongs_to :concept

  scope :by, -> (inferencer) { where inferencer: inferencer }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject }}
  scope :of, -> (concept) { where concept: concept }
end
