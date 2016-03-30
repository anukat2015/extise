# NOTE:

class Extric::Sessions::LinesOfCodeCombination
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

    elements.each do |previous_element, revision_element|
      previous_source = fetch_source g, previous_commit, previous_element
      revision_source = fetch_source g, revision_commit, revision_element

      a, d, m = nil #TODO

    end

    g.close

    {
      value: 0
    }
  end

  private

  def fetch_source(git, commit, element)
    c = git.lookup commit.identifier
    f = c.parents.first.diff(c).deltas.map(&:new_file).find { |f| f[:path] == element.file }
    git.lookup(f[:oid]).text[element.offset..(element.offset + element.length)] if f
  end
end
