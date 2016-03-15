class Extisimo::Element < ActiveRecord::Base
  include Extisimo::Inferencible
  include Extisimo::Measurable
  include Extisimo::URL::Element

  belongs_to :commit
end
