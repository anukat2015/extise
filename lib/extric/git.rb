module Extric::Git

  # NOTE: possible options include:
  # track_copies_same_file
  # track_copies_same_commit_moves
  # track_copies_same_commit_copies
  # track_copies_any_commit_copies

  COPIES_TRACKING = { track_copies_any_commit_copies: true }.freeze

  def open_repository(name: nil)
    Rugged::Repository.new(File.join GitEclipseOrg::DIRECTORY, name)
  end

  def blame_recent(repository: nil, commit: nil, element: nil, git: nil, identifier: nil, file: nil)
    raise if (repository && git) || (commit && identifier) || (element && file)
    g = git || open_repository(name: repository.name)
    f = element.try(:file) || file
    o = COPIES_TRACKING.merge(oldest_commit: commit.try(:identifier) || identifier)
    Rugged::Blame.new g, f, o
  end

  def count_recent(blame: nil, names: nil)
    blame.select { |l| names.include? l[:final_signature][:name] }.count
  end

  def fetch_source(repository: nil, commit: nil, element: nil, git: nil, identifier: nil, file: nil, offset: nil, length: nil)
    raise if (repository && git) || (commit && identifier) || (element && (file || offset || length))
    g = git || open_repository(name: repository.name)
    c = g.lookup commit.try(:identifier) || identifier || raise
    p = element.try(:file) || file || raise
    f = c.parents.first.diff(c).deltas.map(&:new_file).find { |f| f[:path] == p }
    o = element.try(:offset) || offset || 0
    l = element.try(:length) || length || nil
    g.lookup(f[:oid]).text[o..(l ? o + l : -1)] if f
  end
end
