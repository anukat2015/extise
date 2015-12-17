class Extisimo::Task < ActiveRecord::Base
  include Extisimo::Reference::Task
  include Extisimo::URL::Task

  #TODO mylyn context scope on attachments

  alias_attribute :text, :description
end
