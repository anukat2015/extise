class Extric::RecentLinesOfCode
  BASE = File.expand_path '../../../../../data/git.eclipse.org', __FILE__

  def measure(user, element)
    names = user.bugs_eclipse_org_user.realnames.unshift user.name
    commit = element.commit
    repository = commit.repository

    g = Rugged::Repository.new File.join BASE, repository.name

    g.checkout 'master'

    # NOTE: tracking options include:
    # track_copies_same_file
    # track_copies_same_commit_moves
    # track_copies_same_commit_copies
    # track_copies_any_commit_copies

    o = { track_copies_any_commit_copies: true }
    b = Rugged::Blame.new g, element.file, o.merge(newest_commit: commit.identifier)
    c = b.select { |l| names.include? l[:final_signature][:name] }.count

    { value: c != 0 ? b.count.to_f / c.to_f : 0 }
  end
end
