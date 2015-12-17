class Extisimo::Post < ActiveRecord::Base
  include Extisimo::Reference::Post
  include Extisimo::URL::Post

  alias_attribute :text, :description

  belongs_to :task
  belongs_to :author, class_name: :User
end
