# NOTE: computes normalized cyclomatic complexity of an element

class Extric::Elements::CyclomaticComplexity
  LIMIT = 1000

  include Extric::Reporting

  def measure(_, element)
    commit = element.commit
    repository = commit.repository

    g = Rugged::Repository.new File.join GitEclipseOrg::DIRECTORY, repository.name
    c = g.lookup commit.identifier

    file = c.parents.first.diff(c).deltas.map(&:new_file).find { |f| f[:path] == element.file }
    content = g.lookup(file[:oid]).text
    source = content[element.offset..(element.offset + element.length)]

    r = Extise.stream(function: 'CyclomaticComplexity', input: source) { |o| o.read }
    l = LIMIT
    v = [r.to_f / l, 1.0].min

    {
      complexity: { raw: r, limit: l },
      value: v
    }
  end
end
