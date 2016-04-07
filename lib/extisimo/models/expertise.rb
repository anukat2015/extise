class Extisimo::Expertise < ActiveRecord::Base
  SUBJECT_TYPES = Extisimo::Metric::TARGETS.map { |t| "Extisimo::#{t.to_s.camelcase}" }.freeze

  belongs_to :metric
  belongs_to :subject, polymorphic: true
  belongs_to :user

  SUBJECT_TYPES.each do |type|
    belongs_to type.demodulize.underscore.to_sym, -> { where subject_type: type }, foreign_key: :subject_id
  end

  scope :by, -> (metric) { where metric: metric }
  scope :on, -> (subject) { where subject.respond_to?(:id) ? { subject: subject } : { subject_type: subject.to_s }}
  scope :of, -> (user) { where user: user }

  def self.fetch(by: nil, on: nil, of: nil)
    metric, subject, user = *[by, on, of].map { |o| o.respond_to?(:id) ? o : nil }

    if !subject && on
      index = Extisimo::Metric::TARGETS.index on.to_s
      subject = (SUBJECT_TYPES[index] if index) || on.to_s
    end

    if !metric && by && on
      type = (subject.respond_to?(:id) ? subject.try(:class).to_s : subject) || on.to_s
      target = Extisimo::Metric::TARGETS[SUBJECT_TYPES.index type]
      metric = Extisimo::Metric.find_by! target: target, name: by.to_s
    end

    subject = SUBJECT_TYPES[Extisimo::Metric::TARGETS.index metric.target] if !subject && metric
    user = Extisimo::User.find_by! name: of.to_s if !user && of

    relation = Extisimo::Expertise
    relation = relation.by(metric) if metric
    relation = relation.on(subject) if subject
    relation = relation.of(user) if user
    relation
  end
end
