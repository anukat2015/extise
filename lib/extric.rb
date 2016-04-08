require 'active_support'

require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload :Caching
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

    autoload :CommentCount
    autoload :CommentLinesOfCode
    autoload :CyclomaticComplexity
    autoload :LinesOfCode
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :MethodCount
    autoload :RecentLinesOfCode
    autoload :SourceLinesOfCode
    autoload :StatementCount
    autoload :TypeCount
  end

  module Sessions
    extend ActiveSupport::Autoload

    autoload :Duration
    autoload :Edits
    autoload :Interactions
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :RecentLinesOfCode
    autoload :Selections
    autoload :SubsequentEdits
    autoload :UniqueEdits
  end

  extend Resolving
end
