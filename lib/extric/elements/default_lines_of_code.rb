# NOTE: counts lines of code of an element authored by a user before a session

class Extric::Elements::DefaultLinesOfCode
  include Extric::Common

  def measure(user, element)
    session = element.commit.session

    unless session
      warn message user, element, "session bound by revision #{element.commit.identifier} not found"
      return
    end

    commit = session.previous_commit
    repository = commit.repository

    begin
      b = blame_recent repository: repository, commit: commit, element: element
    rescue Rugged::TreeError
      warn message user, element, "#{element.file} not found at #{commit.identifier} (#{$!})"
      return
    end

    c = count_recent blame: b, names: user.eclipse_org_user_names
    t = b.count

    {
      blame: { final: c, total: t },
      value: c
    }
  end
end
