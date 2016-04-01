# NOTE: computes linear combination of added, deleted,
# and modified lines of code of elements inside a session

class Extric::Sessions::LinesOfCodeCombination
  include Extric::Elements::LinesOfCodeCombination::Helpers
  include Extric::Reporting

  def measure(user, session)
    previous_commit = session.previous_commit
    revision_commit = session.revision_commit

    elements = revision_commit.elements.inject([]) do |elements, revision_element|
      previous_element = previous_commit.elements.find_by file: revision_element.file, path: revision_element.path

      unless previous_element
        warn message user, session, "#{revision_element.file}:#{revision_element.path} not found at #{previous_commit.identifier}"
        next elements
      end

      elements << [previous_element, revision_element]
    end

    return unless elements.any?

    g = Rugged::Repository.new File.join GitEclipseOrg::DIRECTORY, revision_commit.repository.name

    a, d, m, t = 0, 0, 0, 0

    elements.each do |previous_element, revision_element|
      r = compute_source_difference g, previous_element, revision_element
      a, d, m, t = a + r[:additions], d + r[:deletions], m + r[:modifications], t + r[:total]
    end

    g.close

    compute_result_data a, d, m, t
  end
end
