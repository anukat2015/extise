module Extric::Reporting
  def self.message(metric, user, subject, content = $!)
    message = "#{metric.class} #{content.respond_to?(:message) ? content.message : (content || '?').to_s}"
    message << " on #{subject.class}:#{subject.id} for #{user.class}:#{user.id}"
  end

  def message(user, subject, content = $!)
    Extric::Reporting.message self, user, subject, content
  end
end
