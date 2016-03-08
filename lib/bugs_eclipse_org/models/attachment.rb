class BugsEclipseOrg::Attachment < ActiveRecord::Base
  MYLYN_CONTEXT_FILENAME = 'mylyn-context.zip'

  belongs_to :bug
  belongs_to :submitter, class_name: :User

  has_many :interactions, dependent: :destroy

  def self.inheritance_column
    nil
  end
end
