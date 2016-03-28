require 'git_eclipse_org/version'

module GitEclipseOrg
  DIRECTORY = File.expand_path '../../../data/git.eclipse.org', __FILE__

  extend ActiveSupport::Autoload
end
