class Extisimo::Expertise < ActiveRecord::Base
  belongs_to :metric
  belongs_to :subject, polymorphic: true
  belongs_to :user
end
