require 'active_record'
require 'active_support'

require 'bugs_eclipse_org/version'

module BugsEclipseOrg
  extend ActiveSupport::Autoload

  autoload_under 'models' do
    autoload :Attachment
    autoload :Bug
    autoload :Bugzilla
    autoload :Comment
    autoload :Interaction
    autoload :User
  end

  def self.table_name_prefix
    'bugs_eclipse_org_'
  end
end
