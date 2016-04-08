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
    v = Float read_metric metric: options[:metric], sources: s

    { sources: { total: 1 }, value: v }
  end

  def measure_on_elements(commit, options = {})
    repository = commit.repository

    g = open_repository name: repository.name
    s, v, t = [], 0, 0

    commit.elements.each do |element|
      s << [[element.file, element.path], fetch_source(git: g, commit: commit, element: element)]
    end

    read_metric metric: options[:metric], sources: s do |r|
      v, t = v + r, t + 1
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
    # TODO caching fetched sources on fetch_source method level may increase performance
    # TODO also a global cache for subjects on read_metric may increase performance

    def cache_measure(options = {})
      return cache_method :measure, -> (_, subject) { subject.id } if options[:on]
      cache_method :measure, -> (user, subject) { [user.id, subject.id] }
    end
  end
end
