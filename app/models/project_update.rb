# Represents an update to a project.
# In other words, this is an analogue to transactions, but for projects instead
# of for items.
class ProjectUpdate < ActiveRecord::Base
  validates :content, :presence => true
  
  belongs_to :project
  belongs_to :user
end
