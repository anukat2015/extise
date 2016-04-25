# NOTE: selects the highest priority from tasks associated with a session

class Extric::Sessions::TaskPriority

  # NOTE: P1 and P2 priorities represent Highest and High priorities

  PRIORITY_TO_VALUE = { p1: 1.0, p2: 0.75, p3: 0.5, p4: 0.25, p5: 0.0 }.freeze

  include Extric::Common
  include Extric::Shared

  def measure(user, session)
    return unless user_matches? session, user

    p = fetch_tasks(of: session).pluck(:priority).map(&:to_sym).max_by { |p| PRIORITY_TO_VALUE[p] || raise }

    { raw: p, value: PRIORITY_TO_VALUE[p] }
  end
end
