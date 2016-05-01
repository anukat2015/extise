class Extisimo::Expertise < ActiveRecord::Base
  SUBJECT_TYPES = Extisimo::Metric::TARGETS.map { |t| "Extisimo::#{t.to_s.camelcase}" }.freeze

  belongs_to :metric
  belongs_to :subject, polymorphic: true
  belongs_to :user

  SUBJECT_TYPES.each do |type|
    belongs_to type.demodulize.underscore.to_sym, -> { where subject_type: type }, foreign_key: :subject_id
  end

  scope :by, -> (metric) { where metric: metric }
  scope :on, -> (subject) { where findable?(subject, polymorphic: true) ? { subject: subject } : { subject_type: subject.to_s }}
  scope :of, -> (user) { where user: user }
end
