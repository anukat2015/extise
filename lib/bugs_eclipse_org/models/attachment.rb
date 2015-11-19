class BugsEclipseOrg::Attachment < ActiveRecord::Base
  belongs_to :bug
  belongs_to :submitter, class_name: :User
  has_many :interactions, dependent: :destroy
end
