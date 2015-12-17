module Extisimo::Reference
  module User
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_user, -> { readonly }, class_name: 'BugsEclipseOrg::User'
    end
  end

  module Task
    extend ActiveSupport::Concern

    included do
      has_one :bugs_eclipse_org_bug, -> { readonly }, class_name: 'BugsEclipseOrg::Bug'

      has_many :mylyn_contexts, -> { mylyn_context }, class_name: :Attachment
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

      scope :mylyn_context, -> { where name: 'mylyn-context.zip' }
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
