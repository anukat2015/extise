module Extisimo::Reference
  module User
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :bugs_eclipse_org_users, -> { readonly }, class_name: 'BugsEclipseOrg::User', association_foreign_key: :bugs_eclipse_org_user_id, foreign_key: :extisimo_user_id, join_table: :extisimo_users_bugs_eclipse_org_users

      scope :has_mylyn_context, -> { has_attachments.merge Extisimo::Attachment.mylyn_context }

      class BugsEclipseOrg::User
        has_and_belongs_to_many :extisimo_users, -> { readonly }, class_name: 'Extisimo::User', association_foreign_key: :extisimo_user_id, foreign_key: :bugs_eclipse_org_user_id, join_table: :extisimo_users_bugs_eclipse_org_users

        def extisimo_user
          self.extisimo_users.first
        end
      end

      has_and_belongs_to_many :git_eclipse_org_users, -> { readonly }, class_name: 'GitEclipseOrg::User', association_foreign_key: :git_eclipse_org_user_id, foreign_key: :extisimo_user_id

      class GitEclipseOrg::User
        has_and_belongs_to_many :extisimo_users, -> { readonly }, class_name: 'Extisimo::User', association_foreign_key: :extisimo_user_id, foreign_key: :git_eclipse_org_user_id

        def extisimo_user
          self.extisimo_users.first
        end
      end
    end
  end

  module Project
    extend ActiveSupport::Concern

    included do
      has_many :git_eclipse_org_projects, -> { readonly }, through: :repositories
    end
  end

  module Task
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :bugs_eclipse_org_bugs, -> { readonly }, class_name: 'BugsEclipseOrg::Bug', association_foreign_key: :bugs_eclipse_org_bug_id, foreign_key: :extisimo_task_id, join_table: :extisimo_tasks_bugs_eclipse_org_bugs

      has_many :mylyn_contexts, -> { mylyn_context }, class_name: :Attachment

      scope :with_mylyn_context, -> { with_attachments.merge Extisimo::Attachment.mylyn_context }

      class BugsEclipseOrg::Bug
        has_and_belongs_to_many :extisimo_tasks, -> { readonly }, class_name: 'Extisimo::Task', association_foreign_key: :extisimo_task_id, foreign_key: :bugs_eclipse_org_bug_id, join_table: :extisimo_tasks_bugs_eclipse_org_bugs

        def extisimo_task
          self.extisimo_tasks.first
        end
      end

      has_and_belongs_to_many :git_eclipse_org_changes, -> { readonly }, class_name: 'GitEclipseOrg::Change', association_foreign_key: :git_eclipse_org_change_id, foreign_key: :extisimo_task_id

      class GitEclipseOrg::Change
        has_and_belongs_to_many :extisimo_tasks, -> { readonly }, class_name: 'Extisimo::Task', association_foreign_key: :extisimo_task_id, foreign_key: :git_eclipse_org_change_id

        def extisimo_task
          self.extisimo_tasks.first
        end
      end
    end
  end

  module Post
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_comment, -> { readonly }, class_name: 'BugsEclipseOrg::Comment'

      class BugsEclipseOrg::Comment
        has_one :extisimo_post, class_name: 'Extisimo::Post', foreign_key: :bugs_eclipse_org_comment_id
      end
    end
  end

  module Attachment
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_attachment, -> { readonly }, class_name: 'BugsEclipseOrg::Attachment'

      scope :mylyn_context, -> { where file: BugsEclipseOrg::Attachment::MYLYN_CONTEXT_FILENAME }

      class BugsEclipseOrg::Attachment
        has_one :extisimo_attachment, class_name: 'Extisimo::Attachment', foreign_key: :bugs_eclipse_org_attachment_id
      end
    end
  end

  module Interaction
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_interaction, -> { readonly }, class_name: 'BugsEclipseOrg::Interaction'

      belongs_to :mylyn_context, -> { mylyn_context }, class_name: :Attachment

      class BugsEclipseOrg::Interaction
        has_one :extisimo_interaction, class_name: 'Extisimo::Interaction', foreign_key: :bugs_eclipse_org_interaction_id
      end
    end
  end

  module Repository
    extend ActiveSupport::Concern

    included do
      belongs_to :git_eclipse_org_project, -> { readonly }, class_name: 'GitEclipseOrg::Project'

      class GitEclipseOrg::Project
        has_one :extisimo_repository, class_name: 'Extisimo::Repository', foreign_key: :git_eclipse_org_project_id
      end
    end
  end
end
