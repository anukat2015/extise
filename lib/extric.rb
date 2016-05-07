require 'active_support'

require 'bugs_eclipse_org'
require 'git_eclipse_org'

require 'extisimo'
require 'extric/version'

module Extric
  extend ActiveSupport::Autoload

  autoload :Aliasing
  autoload :Caching
  autoload :Common
  autoload :Extise
  autoload :Git
  autoload :Reporting
  autoload :Resolving
  autoload :Reusing
  autoload :Shared

  module Elements
    extend ActiveSupport::Autoload

    autoload :CommentCount
    autoload :CommentLinesOfCode
    autoload :CyclomaticComplexity
    autoload :DefaultLinesOfCode
    autoload :LinesOfCode
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :LogicalLinesOfCode
    autoload :MethodCount
    autoload :RecentLinesOfCode
    autoload :SourceLinesOfCode
    autoload :StatementCount
    autoload :TypeCount
  end

  module Sessions
    extend ActiveSupport::Autoload

    autoload :ChangeIterations
    autoload :ChangeUploads
    autoload :CommentCount
    autoload :CommentLinesOfCode
    autoload :CyclomaticComplexity
    autoload :CyclomaticComplexityOverExtentOfEdits
    autoload :DefaultLinesOfCode
    autoload :LinesOfCode
    autoload :Duration
    autoload :Edits
    autoload :ExtentOfEdits
    autoload :ExtentOfInteractions
    autoload :ExtentOfSelections
    autoload :Interactions
    autoload :LinesOfCodeDelta
    autoload :LinesOfCodeDeltaCombination
    autoload :LogicalLinesOfCode
    autoload :MethodCount
    autoload :RecentLinesOfCode
    autoload :RelativeDefaultLinesOfCode
    autoload :RelativeRecentLinesOfCode
    autoload :Selections
    autoload :SourceLinesOfCode
    autoload :SubsequentEdits
    autoload :SubsequentInteractions
    autoload :SubsequentSelections
    autoload :StatementCount
    autoload :TaskPriority
    autoload :TaskSeverity
    autoload :TypeCount
    autoload :UniqueEdits
    autoload :UniqueInteractions
    autoload :UniqueSelections
  end

  module Projects
    extend ActiveSupport::Autoload

    autoload :AssignedTasks
    autoload :Commits
    autoload :OpenedChanges
    autoload :ReportedTasks
    autoload :ReviewedChanges
  end

  module Concepts
    extend ActiveSupport::Autoload
  end

  extend Resolving
end

Module.send(:include, Extric::Aliasing)
