module Extric::Common
  extend ActiveSupport::Concern

  include Extric::Extise
  include Extric::Git

  include Extric::Caching
  include Extric::Reporting

  attr_accessor :context

  def fetch_value(via: nil, of: nil, on: nil)
    via.measure(of, on).try! :[], :value
  end

  def reuse_metric(metric)
    metric = metric.is_a?(Class) ? metric.new : metric
    (@reused_metrics ||= []) << metric
    metric.reporting_object = self
    metric
  end

  def measure_on_element(element, options = {})
    commit = element.commit
    repository = commit.repository

    s = fetch_source repository: repository, commit: commit, element: element
    v = Float read_metric metric: options[:metric], sources: s

    { sources: { total: 1 }, value: v }
  end

  def measure_on_elements(commit, options = {})
    elements = commit.elements
    repository = commit.repository

    return unless elements.any?

    g = open_repository name: repository.name
    s, v, t = [], 0, 0

    elements.each do |element|
      s << [[element.file, element.path], fetch_source(git: g, commit: commit, element: element)]
    end

    read_metric metric: options[:metric], sources: s do |r|
      v, t = v + Float(r), t + 1
    end

    raise if s.size != t

    { sources: { total: t }, value: v }
  end

  def user_matches?(record, various)
    subject = (various.delete :subject if various.is_a? Hash) || record
    association, user = *(various.is_a?(Hash) ? various.shift : [:user, various])

    unless record.public_send(association) == user
      warn message user, subject, "#{record.class.name.downcase.split('::').last} #{association} does not match expertise user"
      return false
    end

    true
  end

  class_methods do
    def alias_metric(metric)
      metric = metric.is_a?(Class) ? metric.new : metric

      define_method :initialize do
        @aliased_metric = reuse_metric metric
      end

      define_method :measure do |user, subject|
        @aliased_metric.metric.measure user, subject
      end
    end

    # TODO caching fetched sources on fetch_source method level may increase performance
    # TODO also a global cache for subjects on read_metric may increase performance

    def cache_measure(options = {})
      return cache_method :measure, -> (_, subject) { subject.id } if options[:on]
      cache_method :measure, -> (user, subject) { [user.id, subject.id] }
    end
  end

  def self.propagate_to_reused_metrics(attribute: nil)
    writer = "#{attribute}=".to_sym
    define_method writer do |value|
      (@reused_metrics || []).each { |metric| metric.public_send(writer, value) if metric.respond_to? writer }
      super value
    end
  end

  propagate_to_reused_metrics attribute: :context
  propagate_to_reused_metrics attribute: :reporting_object
end
