class Extisimo::Attachment < ActiveRecord::Base
  include Extisimo::Reference::Attachment
  include Extisimo::URL::Attachment

  alias_attribute :text, :description

  belongs_to :task
  belongs_to :author, class_name: :User

  has_many :interactions, dependent: :destroy
  has_many :sessions, -> { distinct }, through: :interactions

  scope :submitted_by, -> (user) { where author: user }

  alias_scope :by, :submitted_by

  scope :with_interactions, -> { joins(:interactions).distinct }

  def self.inheritance_column
    nil
  end
end
