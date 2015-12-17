class Extisimo::Element < ActiveRecord::Base
  include Extisimo::URL::Element

  belongs_to :commit

  has_many :interactions, dependent: :destroy
  has_many :conceptualities, as: :subject, dependent: :destroy
end
