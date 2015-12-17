module Extisimo::Reference
  module User
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_user, class_name: 'BugsEclipseOrg::User'
    end
  end

  module Task
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_bug, class_name: 'BugsEclipseOrg::Bug'

      def mylyn_contexts
        attachments.mylyn_context
      end
    end
  end

  module Post
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_comment, class_name: 'BugsEclipseOrg::Comment'
    end
  end

  module Attachment
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_attachment, class_name: 'BugsEclipseOrg::Attachment'

      scope :mylyn_context, -> { where name: 'mylyn-context.zip' }
    end
  end

  module Interaction
    extend ActiveSupport::Concern

    included do
      belongs_to :bugs_eclipse_org_interaction, class_name: 'BugsEclipseOrg::Interaction'
    end
  end
end
