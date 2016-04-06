# NOTE: computes linear combination of added, deleted, and modified
# lines of code of an element by a user during a session

class Extric::Elements::LinesOfCodeDeltaCombination
  module Computing
    ADDITIONS_MULTIPLIER = 1.3
    DELETIONS_MULTIPLIER = 0.9
    MODIFICATIONS_MULTIPLIER = 1.2

    def combine_and_return(a, d, m, t)
      v = ADDITIONS_MULTIPLIER * a + DELETIONS_MULTIPLIER * d + MODIFICATIONS_MULTIPLIER * m

      {
        difference: { additions: a, deletions: d, modifications: m, total: t },
        value: v
      }
    end
  end

  include Extric::Elements::LinesOfCodeDeltaCombination::Computing
  include Extric::Extise
  include Extric::Git
  include Extric::Reporting

  def measure(user, element)
    revision_element = element
    revision_commit = element.commit

    unless revision_commit.author == user
      warn message user, element, "revision #{revision_commit.identifier} not authored by user"
      return
    end

    session = revision_commit.session

    unless session
      warn message user, element, "session bound by revision #{revision_commit.identifier} not found"
      return
    end

    previous_commit = session.previous_commit
    previous_element = previous_commit.elements.find_by file: revision_element.file, path: revision_element.path

    unless previous_element
      warn message user, element, "#{revision_element.file}:#{revision_element.path} not found at #{previous_commit.identifier}"
      return
    end

    g = open_repository name: revision_commit.repository.name
    o = fetch_source git: g, commit: previous_commit, element: previous_element
    r = fetch_source git: g, commit: revision_commit, element: revision_element
    s = compute_source_difference original: o, revision: r

    combine_and_return *s.values
  end
end
