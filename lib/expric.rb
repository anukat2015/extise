require 'active_support'

require 'extisimo'
require 'extric'
require 'expric/version'

module Expric
  extend ActiveSupport::Autoload

  autoload :Shared

  module Sessions
    extend ActiveSupport::Autoload

    autoload :DfDloc
    autoload :DfDlocDr
    autoload :DfDlocMs

    autoload :DfRloc
    autoload :DfRlocDr
    autoload :DfRlocMs

    autoload :DpCcC
    autoload :DpCcT

    autoload :DpLocdcC
    autoload :DpLocdcT
  end

  module Projects
    extend ActiveSupport::Autoload
  end

  extend Extric::Resolving
end
