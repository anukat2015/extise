module Extisimo::Inferencible
  extend ActiveSupport::Concern

  included do
    has_many :conceptualities, as: :subject, dependent: :destroy
    has_many :concepts, through: :conceptualities
  end
end
