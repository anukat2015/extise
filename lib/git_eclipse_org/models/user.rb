class GitEclipseOrg::User < ActiveRecord::Base
  has_many :changes, foreign_key: :owner_id, dependent: :destroy
  has_many :reviews, foreign_key: :reviewer_id, dependent: :destroy
end
