module Extric::Reusing
  extend ActiveSupport::Concern

  included do
    def self.propagate_to_reused_metrics(attribute: nil)
      writer = "#{attribute}=".to_sym
      define_method writer do |value|
        (@reused_metrics || []).each { |metric| metric.public_send(writer, value) if metric.respond_to? writer }
        super value
      end
    end
  end

  def reuse_metric(metric)
    metric = metric.is_a?(Class) ? metric.new : metric
    (@reused_metrics ||= []) << metric
    metric.reporting_object = self
    metric
  end
end
