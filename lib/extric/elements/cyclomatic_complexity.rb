# NOTE: computes cyclomatic complexity of an element

class Extric::Elements::CyclomaticComplexity
  include Extric::Caching
  include Extric::Extise
  include Extric::Git
  include Extric::Reporting

  def measure(_, element)
    commit = element.commit
    repository = commit.repository

    s = fetch_source repository: repository, commit: commit, element: element
    v = read_metric metric: 'CyclomaticComplexity', source: s

    { value: v }
  end

  cache_method :measure, -> (_, element) { element.id }
end
