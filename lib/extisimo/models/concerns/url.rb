module Extisimo::URL
  def self.included(base)
    base.extend ActiveSupport::Concern
  end

  module Templates
    module Eclipse
      BUGZILLA_BUG = 'https://bugs.eclipse.org/bugs/show_bug.cgi?id=%bug'
      BUGZILLA_COMMENT = 'https://bugs.eclipse.org/bugs/show_bug.cgi?id=%bug#c%description'
      BUGZILLA_ATTACHMENT = 'https://bugs.eclipse.org/bugs/attachment.cgi?id=%attachment'

      GERRIT_PROJECT = 'https://git.eclipse.org/c/%product/%component'
      GERRIT_COMMIT = 'https://git.eclipse.org/c/%product/%component/commit/?id=%commit'
      GERRIT_GIT = 'https://git.eclipse.org/gitroot/%product/%component.git'

      GITHUB_USER = 'https://github.com/%user'
      GITHUB_REPOSITORY = 'https://github.com/eclipse/%repository'
      GITHUB_COMMIT = 'https://github.com/eclipse/%repository/commit/%commit'
      GITHUB_LINE = 'https://github.com/eclipse/%repository/blob/%commit/%file#L%line'
      GITHUB_GIT = 'https://github.com/eclipse/%repository.git'
    end
  end

  include Templates::Eclipse

  module User
    include Extisimo::URL

    def github_url
      GITHUB_USER.sub(/%(user)/, 'user' => name)
    end
  end

  module Task
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_BUG.sub(/%(bug)/, 'bug' => bugs_bugzilla_org_bug.bugid)
    end
  end

  module Post
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_COMMENT.sub(/%(bug|comment)/, 'bug' => bugs_bugzilla_org_comment.bugs_bugzilla_org_bug.bugid, 'comment' => bugs_bugzilla_org_comment.commentid)
    end
  end

  module Attachment
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_ATTACHMENT.sub(/%(attachment)/, 'attachment' => bugs_bugzilla_org_attachment.attachid)
    end
  end

  module Project
    include Extisimo::URL

    def gerrit_url
      GERRIT_PROJECT.sub(/%(product|component)/, 'product' => product, 'component' => component)
    end

    def github_urls
      repositories.pluck(:name).map { |name| GITHUB_REPOSITORY.sub(/%(repository)/, 'repository' => name) }
    end
  end

  module Repository
    include Extisimo::URL

    def gerrit_url
      GERRIT_GIT.sub(/%(product|component)/, 'product' => project.product, 'component' => project.component)
    end

    def github_url
      GITHUB_GIT.sub(/%(repository)/, 'repository' => name)
    end
  end

  module Commit
    include Extisimo::URL

    def gerrit_url
      GERRIT_COMMIT.sub(/%(repository|commit)/, 'product' => repository.project.product, 'component' => repository.project.component, 'commit' => name)
    end

    def github_url
      GITHUB_COMMIT.sub(/%(repository|commit)/, 'repository' => repository.name, 'commit' => name)
    end
  end

  module Element
    include Extisimo::URL

    def github_url
      GITHUB_COMMIT.sub(/%(repository|commit|file|line)/, 'repository' => commit.repository.name, 'commit' => commit.name, 'file' => file, 'line' => line)
    end
  end
end
