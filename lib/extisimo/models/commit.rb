class Extisimo::Commit < ActiveRecord::Base
  include Extisimo::URL::Commit

  belongs_to :repository
  belongs_to :author, class_name: :User

  has_one :session, foreign_key: :revision_commit_id

  has_many :elements, dependent: :destroy
  has_many :conceptualities, through: :elements
  has_many :concepts, through: :conceptualities
end
