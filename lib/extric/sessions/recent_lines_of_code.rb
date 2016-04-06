# NOTE: counts lines of code of all elements most recently modified by a user during a session

class Extric::Sessions::RecentLinesOfCode
  include Extric::Git
  include Extric::Reporting

  def measure(user, session)
    commit = session.revision_commit
    repository = commit.repository

    g = open_repository name: repository.name
    i = commit.identifier
    n = user.eclipse_org_user_names

    c, t = 0, nil

    commit.elements.each do |element|
      begin
        f = element.file
        b = blame_recent git: g, identifier: i, file: f
      rescue Rugged::TreeError
        warn message user, session, "#{element.file} not found at #{commit.identifier} (#{$!})"
        next
      end

      c += count_recent blame: b, names: n
      t = (t || 0) + b.count
    end

    return unless t

    {
      blame: { final: c, total: t },
      value: c
    }
  end
end
