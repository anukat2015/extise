require 'active_support'

require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload :Extise
  autoload :Git
  autoload :Reporting
  autoload :Resolving

  module Concepts
    extend ActiveSupport::Autoload
  end

  module Elements
    extend ActiveSupport::Autoload

    autoload :CyclomaticComplexity
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :RecentLinesOfCode
  end

  module Sessions
    extend ActiveSupport::Autoload

    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :RecentLinesOfCode
  end

  extend Resolving
end
