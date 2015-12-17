class Extisimo::Post < ActiveRecord::Base
  include Extisimo::Reference::Post
  include Extisimo::URL::Post

  alias_attribute :text, :description
end
