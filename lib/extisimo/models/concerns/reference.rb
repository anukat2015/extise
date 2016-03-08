module Extisimo::Reference
  module User
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_user, -> { readonly }, class_name: 'BugsEclipseOrg::User'

      scope :has_mylyn_context, -> { has_attachments.merge Extisimo::Attachment.mylyn_context }

      class BugsEclipseOrg::User
        has_one :extisimo_user, class_name: 'Extisimo::User', foreign_key: :bugs_eclipse_org_user_id
      end
    end
  end

  module Task
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_bug, -> { readonly }, class_name: 'BugsEclipseOrg::Bug'

      has_many :mylyn_contexts, -> { mylyn_context }, class_name: :Attachment

      scope :with_mylyn_context, -> { with_attachments.merge Extisimo::Attachment.mylyn_context }

      class BugsEclipseOrg::Bug
        has_one :extisimo_task, class_name: 'Extisimo::Task', foreign_key: :bugs_eclipse_org_bug_id
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
end
