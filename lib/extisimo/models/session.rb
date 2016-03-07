class Extisimo::Session < ActiveRecord::Base
  include Extisimo::Measurable

  belongs_to :user

  has_one :commit

  delegate :elements, to: :commit

  has_many :interactions, dependent: :restrict_with_exception
  has_many :attachments, through: :interactions
  has_many :tasks, through: :attachments
end
