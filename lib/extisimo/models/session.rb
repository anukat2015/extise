class Extisimo::Session < ActiveRecord::Base
  include Extisimo::Measurable

  belongs_to :user

  belongs_to :previous_commit, class_name: :Commit
  belongs_to :revision_commit, class_name: :Commit

  alias_association :commit, :revision_commit

  delegate :elements, to: :revision_commit

  has_many :interactions, dependent: :restrict_with_exception

  def duration
    finished_at - started_at
  end
end
