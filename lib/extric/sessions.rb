module Extric::Sessions
  include Extric::Reporting

  def session_user_matches!(user, session)
    unless session.user == user
      warn message user, session, 'session user does not match expertise user'
      return false
    end

    true
  end
end
