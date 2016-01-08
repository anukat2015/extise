module Extisimo::Reference
  module User
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_user, -> { readonly }, class_name: 'BugsEclipseOrg::User'

      scope :has_mylyn_context, -> { has_attachments.merge Extisimo::Attachment.mylyn_context }
    end
  end

  module Task
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_bug, -> { readonly }, class_name: 'BugsEclipseOrg::Bug'

      has_many :mylyn_contexts, -> { mylyn_context }, class_name: :Attachment

      scope :with_mylyn_context, -> { with_attachments.merge Extisimo::Attachment.mylyn_context }
    end
  end

  module Post
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_comment, -> { readonly }, class_name: 'BugsEclipseOrg::Comment'
    end
  end

  module Attachment
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_attachment, -> { readonly }, class_name: 'BugsEclipseOrg::Attachment'

      scope :mylyn_context, -> { where file: BugsEclipseOrg::Attachment::MYLYN_CONTEXT_FILENAME }
    end
  end

  module Interaction
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_interaction, -> { readonly }, class_name: 'BugsEclipseOrg::Interaction'

      has_one :mylyn_context, -> { mylyn_context }, class_name: :Attachment
    end
  end
end
