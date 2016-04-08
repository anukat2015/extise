module Extric::Common
  extend ActiveSupport::Concern

  include Extric::Extise
  include Extric::Git

  include Extric::Caching
  include Extric::Reporting

  def measure_on_element(element, options = {})
    commit = element.commit
    repository = commit.repository

    s = fetch_source repository: repository, commit: commit, element: element
    v = Float read_metric metric: options[:metric], source: s

    { value: v }
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
    def cache_measure(options = {})
      return cache_method :measure, -> (_, subject) { subject.id } if options[:on]
      cache_method :measure, -> (user, subject) { [user.id, subject.id] }
    end
  end
end
