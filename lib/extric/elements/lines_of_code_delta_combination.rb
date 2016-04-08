# NOTE: computes linear combination of added, deleted, and modified
# lines of code of an element by a user during a session

class Extric::Elements::LinesOfCodeDeltaCombination
  include Extric::Common

  attr_accessor :combinator

  def initialize(combinator = nil)
    @combinator = combinator || Extric::Elements::LinesOfCodeDeltaCombination::Combinator.new
  end

  def measure(user, element)
    revision_element = element
    revision_commit = element.commit

    return unless user_matches? revision_commit, author: user, subject: element

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

    combinator.combine_and_return *s.values
  end

  class Combinator
    ADDITIONS_MULTIPLIER = 1.3
    DELETIONS_MULTIPLIER = 0.9
    MODIFICATIONS_MULTIPLIER = 1.2

    attr_accessor :multipliers

    def initialize(multipliers = nil)
      @multipliers = multipliers || { additions: ADDITIONS_MULTIPLIER, deletions: DELETIONS_MULTIPLIER, modifications: MODIFICATIONS_MULTIPLIER }
    end

    def combine_and_return(a, d, m, t)
      v = multipliers[:additions] * a + multipliers[:deletions] * d + multipliers[:modifications] * m

      {
        difference: { additions: a, deletions: d, modifications: m, total: t },
        value: v
      }
    end
  end
end
