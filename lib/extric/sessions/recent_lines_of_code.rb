# NOTE: counts lines of code of all elements recently modified during
# a session by a user relative to total lines of code of these elements

class Extric::Sessions::RecentLinesOfCode
  include Extric::Reporting

  def measure(user, session)
    names = user.bugs_eclipse_org_user.realnames.unshift user.name
    commit = session.revision_commit
    repository = commit.repository

    g = Rugged::Repository.new File.join GitEclipseOrg::DIRECTORY, repository.name

    g.checkout 'master'

    # NOTE: tracking options include:
    # track_copies_same_file
    # track_copies_same_commit_moves
    # track_copies_same_commit_copies
    # track_copies_any_commit_copies

    c, t = 0, nil

    commit.elements.each do |element|
      begin
        o = { track_copies_any_commit_copies: true }
        b = Rugged::Blame.new g, element.file, o.merge(oldest_commit: commit.identifier)
      rescue Rugged::TreeError
        warn message user, element, "#{element.file} not found at #{commit.identifier} (#{$!})"
        next
      end

      c += b.select { |l| names.include? l[:final_signature][:name] }.count
      t = (t || 0) + b.count
    end

    return unless t

    {
      blame: { final: c, total: t },
      value: c != 0 ? c.to_f / t : 0
    }
  end
end
