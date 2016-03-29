class GitEclipseOrg::Review < ActiveRecord::Base
  belongs_to :change
  belongs_to :reviewer, class_name: :User
end
