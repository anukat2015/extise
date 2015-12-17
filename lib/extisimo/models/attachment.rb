class Extisimo::Attachment < ActiveRecord::Base
  include Extisimo::Reference::Attachment
  include Extisimo::URL::Attachment

  alias_attribute :text, :description
end
