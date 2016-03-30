# NOTE: counts lines of code of an element recently modified
# by a user relative to total lines of code of the element

class Extric::Elements::RecentLinesOfCode
  include Extric::Reporting

  def measure(user, element)
    names = user.bugs_eclipse_org_user.realnames.unshift user.name
    commit = element.commit
    repository = commit.repository

    g = Rugged::Repository.new File.join GitEclipseOrg::DIRECTORY, repository.name

    g.checkout 'master'

    # NOTE: tracking options include:
    # track_copies_same_file
    # track_copies_same_commit_moves
    # track_copies_same_commit_copies
    # track_copies_any_commit_copies

    begin
      o = { track_copies_any_commit_copies: true }
      b = Rugged::Blame.new g, element.file, o.merge(oldest_commit: commit.identifier)
    rescue Rugged::TreeError
      warn message user, element, "#{element.file} not found at #{commit.identifier} (#{$!})"
      return
    end

    c = b.select { |l| names.include? l[:final_signature][:name] }.count
    t = b.count

    {
      blame: { final: c, total: t },
      value: c != 0 ? c.to_f / t : 0
    }
  end
end
