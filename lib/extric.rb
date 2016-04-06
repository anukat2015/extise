require 'active_support'

require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload :Extise
  autoload :Git
  autoload :Reporting
  autoload :Resolving
  autoload :Sessions

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

    autoload :EditsCount
    autoload :ExclusiveEditsCount
    autoload :InclusiveEditsCount
    autoload :InteractionsCount
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :RecentLinesOfCode
    autoload :SelectionsCount
  end

  extend Resolving
end
