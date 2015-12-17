module Extisimo::Measurable
  extend ActiveSupport::Concern

  included do
    has_many :experties, as: :subject, dependent: :destroy
    has_many :metrics, through: :expertises
  end
end
