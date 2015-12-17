class Extisimo::User < ActiveRecord::Base
  include Extisimo::Reference::User
  include Extisimo::URL::User


end
