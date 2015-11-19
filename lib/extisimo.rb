require 'active_record'
require 'active_support'

require 'extisimo/version'

module Extisimo
  extend ActiveSupport::Autoload

  autoload_under 'models' do
    autoload :Developer
    autoload :Expertise
    autoload :Topic
  end

  def self.table_name_prefix
    'extisimo_'
  end
end
