class BugsEclipseOrg::Comment < ActiveRecord::Base
  belongs_to :bug
  belongs_to :author, class_name: :User
end
