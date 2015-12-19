class Extisimo::Expertise < ActiveRecord::Base
  belongs_to :metric
  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :by, -> (metric) { where metric: metric }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject }}
  scope :of, -> (user) { where user: user }
end
