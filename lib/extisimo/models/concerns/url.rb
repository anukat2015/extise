module Extisimo::URL
  def self.included(base)
    base.extend ActiveSupport::Concern
  end

  module Templates
    module Eclipse
      BUGZILLA_BUG = 'https://bugs.eclipse.org/bugs/show_bug.cgi?id=%bug'
      BUGZILLA_DESCRIPTION = 'https://bugs.eclipse.org/bugs/show_bug.cgi?id=%bug#c%description'
      BUGZILLA_ATTACHMENT = 'https://bugs.eclipse.org/bugs/attachment.cgi?id=%attachment'

      EGIT_PROJECT = 'https://git.eclipse.org/c/%product/%repository.git'
      EGIT_COMMIT = 'https://git.eclipse.org/c/%product/%repository.git/commit/?id=%commit'
      EGIT_GIT = 'https://git.eclipse.org/gitroot/%product/%repository.git'

      GERRIT_USER = 'https://git.eclipse.org/r/#/q/owner:%user'
      GERRIT_PROJECT = 'https://git.eclipse.org/r/#/q/project:%product/%repository'

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

    def gerrit_url
      GERRIT_USER.gsub(/%(user)/, '%user' => bugs_eclipse_org_user.realnames.first.gsub(/\s/, '+'))
    end

    def github_url
      GITHUB_USER.gsub(/%(user)/, '%user' => name)
    end
  end

  module Task
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_BUG.gsub(/%(bug)/, '%bug' => bugs_eclipse_org_bug.bugid)
    end
  end

  module Post
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_DESCRIPTION.gsub(/%(bug|description)/, '%bug' => bugs_eclipse_org_comment.bug.bugid, '%description' => bugs_eclipse_org_comment.comment_count)
    end
  end

  module Attachment
    include Extisimo::URL

    def bugzilla_url
      BUGZILLA_ATTACHMENT.gsub(/%(attachment)/, '%attachment' => bugs_eclipse_org_attachment.attachid)
    end
  end

  module Project
    include Extisimo::URL

    def egit_urls
      repositories.pluck(:git_eclipse_org_product, :name).map { |product, name| EGIT_PROJECT.gsub(/%(product|repository)/, '%product' => product, '%repository' => name) }
    end

    def gerrit_urls
      repositories.pluck(:git_eclipse_org_product, :name).map { |product, name| GERRIT_PROJECT.gsub(/%(product|repository)/, '%product' => product, '%repository' => name) }
    end

    def github_urls
      repositories.pluck(:name).map { |name| GITHUB_REPOSITORY.gsub(/%(repository)/, '%repository' => name) }
    end
  end

  module Repository
    include Extisimo::URL

    def egit_url
      EGIT_GIT.gsub(/%(product|repository)/, '%product' => git_eclipse_org_product, '%repository' => name)
    end

    def github_url
      GITHUB_GIT.gsub(/%(repository)/, '%repository' => name)
    end
  end

  module Commit
    include Extisimo::URL

    def egit_url
      EGIT_COMMIT.gsub(/%(product|repository|commit)/, '%product' => repository.git_eclipse_org_product, '%repository' => repository.name, '%commit' => identifier)
    end

    def github_url
      GITHUB_COMMIT.gsub(/%(repository|commit)/, '%repository' => repository.name, '%commit' => identifier)
    end
  end

  module Element
    include Extisimo::URL

    def github_url
      GITHUB_LINE.gsub(/%(repository|commit|file|line)/, '%repository' => commit.repository.name, '%commit' => commit.identifier, '%file' => file, '%line' => line)
    end
  end
end
