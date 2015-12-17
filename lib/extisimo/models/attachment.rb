class Extisimo::Attachment < ActiveRecord::Base
  include Extisimo::Reference::Attachment
  include Extisimo::URL::Attachment

  alias_attribute :text, :description

  belongs_to :task
  belongs_to :author, class_name: :User

  has_many :interactions, dependent: :destroy
end
