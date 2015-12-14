class Extisimo::Attachment < ActiveRecord::Base

  alias_attribute :text, :description
end
