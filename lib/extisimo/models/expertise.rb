class Extisimo::Expertise < ActiveRecord::Base
  TYPES = Extisimo::Metric::TARGETS

  belongs_to :metric
  belongs_to :subject, polymorphic: true
  belongs_to :user

  TYPES.each { |type| belongs_to type, -> { where subject_type: type }, foreign_key: :subject_id }

  scope :by, -> (metric) { where metric: metric }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject }}
  scope :of, -> (user) { where user: user }
end
