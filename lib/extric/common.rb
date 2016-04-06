module Extric::Common
  include Extric::Reporting

  def user_matches?(record, various)
    subject = (various.delete :subject if various.is_a? Hash) || record
    association, user = *(various.is_a?(Hash) ? various.shift : [:user, various])

    unless record.public_send(association) == user
      warn message user, subject, "#{record.class.name.downcase.split('::').last} #{association} does not match expertise user"
      return false
    end

    true
  end
end
