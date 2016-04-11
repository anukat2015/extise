class GitEclipseOrg::Change < ActiveRecord::Base
  belongs_to :project
  belongs_to :owner, class_name: :User

  has_many :messages, dependent: :destroy
  has_many :labels, dependent: :destroy
end
