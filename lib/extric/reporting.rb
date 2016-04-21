module Extric::Reporting
  extend ActiveSupport::Concern

  def self.message(object, user, subject, content = $!)
    message = "#{object.class} #{content.respond_to?(:message) ? content.message : (content || '?').to_s}"
    message << " on #{subject.class}:#{subject.id} for #{user.class}:#{user.id}"
  end

  attr_accessor :reporting_object

  def message(user, subject, content = $!)
    Extric::Reporting.message reporting_object, user, subject, content
  end

  def reporting_object=(object)
    @reporting_object = object || raise
  end

  def reporting_object
    @reporting_object || self
  end
end
