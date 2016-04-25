# NOTE: selects the highest severity from tasks associated with a session

class Extric::Sessions::TaskSeverity
  names = %i(blocker critical major normal minor trivial enhancement)
  factor = names.count - 1

  SEVERITY_TO_VALUE = Hash[names.each_with_index.map { |s, i| [s, 1.0 / factor * (factor - i)] }].freeze

  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user

    s = fetch_tasks(of: session).pluck(:severity).map(&:to_sym).max_by { |s| SEVERITY_TO_VALUE[s] || raise }

    return unless s

    { raw: s, value: SEVERITY_TO_VALUE[s] }
  end
end
