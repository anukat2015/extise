class Extisimo::Conceptuality < ActiveRecord::Base
  SUBJECT_TYPES = Extisimo::Inferencer::TARGETS.map { |t| "Extisimo::#{t.to_s.camelcase}" }.freeze

  belongs_to :inferencer
  belongs_to :subject, polymorphic: true
  belongs_to :concept

  SUBJECT_TYPES.each do |type|
    belongs_to type.demodulize.underscore.to_sym, -> { where subject_type: type }, foreign_key: :subject_id
  end

  scope :by, -> (inferencer) { where inferencer: inferencer }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject.to_s }}
  scope :of, -> (concept) { where concept: concept }
end
