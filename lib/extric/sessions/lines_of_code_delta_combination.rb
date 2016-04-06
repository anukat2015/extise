# NOTE: computes linear combination of added, deleted, and modified
# lines of code of all elements by a user during a session

class Extric::Sessions::LinesOfCodeDeltaCombination
  include Extric::Elements::LinesOfCodeDeltaCombination::Computing
  include Extric::Extise
  include Extric::Git
  include Extric::Reporting

  def measure(user, session)
    previous_commit = session.previous_commit
    revision_commit = session.revision_commit

    unless revision_commit.author == user
      warn message user, session, "revision #{revision_commit.identifier} not authored by user"
      return
    end

    elements = revision_commit.elements.inject([]) do |elements, revision_element|
      previous_element = previous_commit.elements.find_by file: revision_element.file, path: revision_element.path

      unless previous_element
        warn message user, session, "#{revision_element.file}:#{revision_element.path} not found at #{previous_commit.identifier}"
        next elements
      end

      elements << [previous_element, revision_element]
    end

    return unless elements.any?

    g = open_repository name: revision_commit.repository.name
    a, d, m, t = 0, 0, 0, 0

    elements.each do |previous_element, revision_element|
      o = fetch_source git: g, commit: previous_commit, element: previous_element
      r = fetch_source git: g, commit: revision_commit, element: revision_element
      s = compute_source_difference original: o, revision: r
      a, d, m, t = a + s[:additions], d + s[:deletions], m + s[:modifications], t + s[:total]
    end

    combine_and_return a, d, m, t
  end
end
