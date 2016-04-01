# NOTE: computes linear combination of added, deleted,
# and modified lines of code of an element inside a session

class Extric::Elements::LinesOfCodeCombination
  ADDITIONS_MULTIPLIER = 1.3
  DELETIONS_MULTIPLIER = 0.9
  MODIFICATIONS_MULTIPLIER = 1.2

  include Extric::Reporting

  def measure(user, element)
    revision_element = element
    revision_commit = element.commit

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

    g = Rugged::Repository.new File.join GitEclipseOrg::DIRECTORY, revision_commit.repository.name
    r = compute_source_difference g, previous_element, revision_element

    g.close

    compute_result_data *r.values
  end

  module Helpers
    def fetch_source(git, commit, element)
      c = git.lookup commit.identifier
      f = c.parents.first.diff(c).deltas.map(&:new_file).find { |f| f[:path] == element.file }
      git.lookup(f[:oid]).text[element.offset..(element.offset + element.length)] if f
    end

    def compute_source_difference(git, original_element, revision_element)
      original_source = fetch_source git, original_element.commit, original_element
      revision_source = fetch_source git, revision_element.commit, original_element

      a, d, m, t = 0, 0, 0, [original_source.length, revision_source.length].max

      sources = Extise::Data.pack_files(original: original_source, revision: revision_source)

      Extise.stream(function: 'MyersTextDifferencer', input: sources) do |o|
        o.each_line do |l|
          case l[0]
            when '+' then a += 1
            when '-' then d += 1
            when '±' then m += 1
            else
          end
        end
      end

      { additions: a, deletions: d, modifications: m, total: t }
    end

    def compute_result_data(a, d, m, t)
      v = (ADDITIONS_MULTIPLIER * a + DELETIONS_MULTIPLIER * d + MODIFICATIONS_MULTIPLIER * m).to_f / t

      {
        difference: { additions: a, deletions: d, modifications: m, total: t },
        value: v
      }
    end
  end

  include Extric::Elements::LinesOfCodeCombination::Helpers
end
