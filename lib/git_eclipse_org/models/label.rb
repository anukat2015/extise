class GitEclipseOrg::Label < ActiveRecord::Base
  belongs_to :change
  belongs_to :user
end
