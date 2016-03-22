require 'git_eclipse_org/version'

module GitEclipseOrg
  extend ActiveSupport::Autoload

  DIRECTORY = File.expand_path '../../../data/git.eclipse.org', __FILE__
end
