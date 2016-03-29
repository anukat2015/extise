class GitEclipseOrg::Project < ActiveRecord::Base
  has_many :changes, dependent: :destroy
end
