class Extisimo::Post < ActiveRecord::Base

  alias_attribute :text, :content
end
