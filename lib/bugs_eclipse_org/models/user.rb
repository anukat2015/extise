class BugsEclipseOrg::User < ActiveRecord::Base
  alias_attribute :user_name, :login_name
  alias_attribute :real_name, :realname

  has_many :bugzillas, through: :bugs
  has_many :bugs, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :attachments, foreign_key: :submitter_id, dependent: :destroy
  has_many :interactions, through: :attachments
end
