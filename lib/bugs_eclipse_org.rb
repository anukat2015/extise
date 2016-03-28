require 'active_record'
require 'active_support'

require 'database'
require 'bugs_eclipse_org/version'

module BugsEclipseOrg
  DIRECTORY = File.expand_path '../../../data/bugs.eclipse.org'

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
