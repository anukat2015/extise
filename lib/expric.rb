require 'active_support'
require 'daru'

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

    autoload :DfRdloc
    autoload :DfRdlocDr
    autoload :DfRdlocMs

    autoload :DfRloc
    autoload :DfRlocDr
    autoload :DfRlocMs

    autoload :DfRrloc
    autoload :DfRrlocDr
    autoload :DfRrlocMs

    autoload :DpCcC
    autoload :DpCcT

    autoload :DpLocdcC
    autoload :DpLocdcT
  end

  module Projects
    extend ActiveSupport::Autoload

    autoload :DpCcC

    autoload :DpLocdcC
  end

  extend Extric::Resolving
end
