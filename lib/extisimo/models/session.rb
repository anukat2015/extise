class Extisimo::Session < ActiveRecord::Base
  include Extisimo::Measurable

  belongs_to :user

  has_one :original_commit, class_name: :Commit
  has_one :revision_commit, class_name: :Commit

  alias_association :commit, :revision_commit

  delegate :elements, to: :revision_commit

  has_many :interactions, dependent: :restrict_with_exception
  has_many :attachments, through: :interactions
  has_many :tasks, through: :attachments
end
