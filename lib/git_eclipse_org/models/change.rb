class GitEclipseOrg::Change < ActiveRecord::Base
  belongs_to :project
  belongs_to :owner, class_name: :User

  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews
  has_many :labels, dependent: :destroy
end
