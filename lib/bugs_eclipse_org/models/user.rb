class BugsEclipseOrg::User < ActiveRecord::Base
  has_many :bugzillas, through: :bugs
  has_many :bugs, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :attachments, foreign_key: :submitter_id, dependent: :destroy
  has_many :interactions, through: :attachments

  def self.fetch(*n)
    return BugsEclipseOrg::User if n.blank?
    BugsEclipseOrg::User.where '(login_name || realnames) && ?', "{#{n * ','}}"
  end
end
