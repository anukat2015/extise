require 'active_support'

require 'extisimo'
require 'extric'
require 'expric/version'

module Expric
  extend ActiveSupport::Autoload

  module Sessions
    extend ActiveSupport::Autoload

    autoload :DP_CC

    autoload :DK_ND
    autoload :DK_WD
    autoload :DK_MS
  end

  extend Extric::Resolving
end
