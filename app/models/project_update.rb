class ProjectUpdate < ActiveRecord::Base
  validates :content, :presence => true
  
  belongs_to :project
  belongs_to :user
end
