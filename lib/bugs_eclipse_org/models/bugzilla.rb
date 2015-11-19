class BugsEclipseOrg::Bugzilla < ActiveRecord::Base
  has_many :bugs, dependent: :destroy
end
