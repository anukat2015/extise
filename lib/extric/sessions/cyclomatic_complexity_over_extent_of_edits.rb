# NOTE: computes cyclomatic complexity of all modified elements over
# unique edits divided by total interactions of a user during a session

class Extric::Sessions::CyclomaticComplexityOverExtentOfEdits
  include Extric::Common

  def initialize
    @cyclomatic_complexity = reuse_metric Extric::Sessions::CyclomaticComplexity
    @extent_of_edits = reuse_metric Extric::Sessions::ExtentOfEdits
  end

  def measure(user, session)
    c = fetch_value via: @cyclomatic_complexity, of: user, on: session
    e = fetch_value via: @extent_of_edits, of: user, on: session

    return unless c && e

    { value: Float(c) / Float(e) }
  end
end
