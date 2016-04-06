require 'active_support'

require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload :Extise
  autoload :Git
  autoload :Common
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

    autoload :Duration
    autoload :EditsCount
    autoload :ExclusiveEditsCount
    autoload :InteractionsCount
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :RecentLinesOfCode
    autoload :SelectionsCount
    autoload :SubsequentEditsCount
  end

  extend Resolving
end
