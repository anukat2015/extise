require 'git_eclipse_org/version'

module GitEclipseOrg
  DIRECTORY = File.expand_path '../../../data/git.eclipse.org', __FILE__

  extend ActiveSupport::Autoload

  autoload_under 'models' do
    autoload :Change
    autoload :Label
    autoload :Message
    autoload :Project
    autoload :User
  end

  def self.table_name_prefix
    'git_eclipse_org_'
  end
end
