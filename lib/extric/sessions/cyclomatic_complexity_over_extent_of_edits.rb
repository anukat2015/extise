# NOTE: computes cyclomatic complexity of all modified elements over
# unique edits divided by total interactions of a user during a session

class Extric::Sessions::CyclomaticComplexityOverExtentOfEdits
  include Extric::Common

  def measure(user, session)
    c = Extric::Sessions::CyclomaticComplexity.new.measure user, session
    e = Extric::Sessions::ExtentOfEdits.new.measure user, session

    return unless c && e

    { value: Float(c) / Float(e) }
  end
end
