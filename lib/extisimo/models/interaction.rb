class Extisimo::Interaction < ActiveRecord::Base
  include Extisimo::Reference::Interaction

  belongs_to :attachment
  belongs_to :session

  scope :of_kind, -> (kind) { where kind: kind }

  alias_scope :of, :of_kind
end
