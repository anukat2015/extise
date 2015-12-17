class Extisimo::Session < ActiveRecord::Base
  include Extisimo::Measurable

  belongs_to :user

  has_one :original_commit, class_name: :Commit
  has_one :revision_commit, class_name: :Commit
end
