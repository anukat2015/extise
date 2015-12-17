class Extisimo::Commit < ActiveRecord::Base
  include Extisimo::URL::Commit

  belongs_to :session, foreign_key: :revision_commit_id
  belongs_to :author, class_name: :User

  has_many :elements, dependent: :destroy
end
