require 'active_record'
require 'active_support'

require 'database'
require 'extisimo/version'

module Extisimo
  extend ActiveSupport::Autoload

  autoload_under 'models' do
    autoload :Attachment
    autoload :Commit
    autoload :Concept
    autoload :Conceptuality
    autoload :Element
    autoload :Expertise
    autoload :Interaction
    autoload :Metric
    autoload :Post
    autoload :Project
    autoload :Session
    autoload :Task
    autoload :User
  end

  def self.table_name_prefix
    'extisimo_'
  end
end
