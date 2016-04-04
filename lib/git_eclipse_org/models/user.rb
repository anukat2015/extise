class GitEclipseOrg::User < ActiveRecord::Base
  has_many :change_list, class_name: :Change, foreign_key: :owner_id, dependent: :destroy
  has_many :reviews, foreign_key: :reviewer_id, dependent: :destroy
end
