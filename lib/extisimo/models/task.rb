class Extisimo::Task < ActiveRecord::Base

  #TODO bug_file_loc -> url to more info

  alias_attribute :text, :description
end
