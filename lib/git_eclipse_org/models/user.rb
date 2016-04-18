class GitEclipseOrg::User < ActiveRecord::Base
  has_many :change_list, class_name: :Change, foreign_key: :owner_id, dependent: :destroy
  has_many :messages, foreign_key: :author_id, dependent: :destroy
  has_many :labels, dependent: :destroy

  def self.fetch(*n)
    return GitEclipseOrg::User if n.blank?
    GitEclipseOrg::User.where 'ARRAY[username,name] && ?', "{#{n * ','}}"
  end
end
