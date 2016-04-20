# NOTE: computes cyclomatic complexity of all modified elements over
# unique edits divided by total interactions of a user during a session

class Extric::Sessions::CyclomaticComplexityOverExtentOfEdits
  include Extric::Common

  def initialize
    @cyclomatic_complexity = reuse_metric Extric::Sessions::CyclomaticComplexity
    @extent_of_edits = reuse_metric Extric::Sessions::ExtentOfEdits
  end

  def measure(user, session)
    c = @cyclomatic_complexity.measure user, session
    e = @extent_of_edits.measure user, session

    return unless c && e

    { value: Float(c) / Float(e) }
  end
end
