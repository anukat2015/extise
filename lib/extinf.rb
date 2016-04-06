require 'active_support'

require 'extisimo'
require 'extinf/version'

module Extinf
  extend ActiveSupport::Autoload

  autoload :Resolving

  module Elements
    extend ActiveSupport::Autoload
  end

  module Tasks
    extend ActiveSupport::Autoload
  end

  extend Resolving
end
