class Extisimo::User < ActiveRecord::Base
  include Extisimo::Reference::User
  include Extisimo::URL::User

  has_many :tasks, foreign_key: :assignee_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :attachments, foreign_key: :author_id, dependent: :destroy
  has_many :commits, foreign_key: :author_id, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :expertises, dependent: :destroy
end
