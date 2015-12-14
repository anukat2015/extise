class Extisimo::Project < ActiveRecord::Base

  def name
    "#{product} #{component}"
  end
end
