class Extisimo::Conceptuality < ActiveRecord::Base
  belongs_to :inferencer
  belongs_to :subject, polymorphic: true
  belongs_to :concept
end
