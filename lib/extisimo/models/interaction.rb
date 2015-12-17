class Extisimo::Interaction < ActiveRecord::Base
  include Extisimo::Reference::Interaction

  belongs_to :attachment
  belongs_to :element
  belongs_to :session
end
