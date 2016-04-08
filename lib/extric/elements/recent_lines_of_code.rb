# NOTE: counts lines of code of an element most recently modified by a user

class Extric::Elements::RecentLinesOfCode
  include Extric::Common

  def measure(user, element)
    commit = element.commit
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
