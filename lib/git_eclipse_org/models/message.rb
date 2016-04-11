class GitEclipseOrg::Message < ActiveRecord::Base
  belongs_to :change
  belongs_to :author, class_name: :User
end
