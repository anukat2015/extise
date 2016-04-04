class GitEclipseOrg::Project < ActiveRecord::Base
  has_many :change_list, class_name: :Change, dependent: :destroy
end
