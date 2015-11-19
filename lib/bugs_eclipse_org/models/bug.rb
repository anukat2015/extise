class BugsEclipseOrg::Bug < ActiveRecord::Base
  belongs_to :bugzilla
  belongs_to :author, class_name: :User
  belongs_to :assignee, class_name: :User
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments
  has_many :attachments, dependent: :destroy
  has_many :submitters, through: :attachments
  has_many :interactions, through: :attachments
end
