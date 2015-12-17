class Extisimo::Project < ActiveRecord::Base
  include Extisimo::URL::Project

  def name
    "#{product} #{component}"
  end

end
