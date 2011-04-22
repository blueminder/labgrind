class Project < ActiveRecord::Base
  has_many :project_assignments
  has_many :users, :through => :project_assignments
  has_many :events
  
  def set_owner(user)
    assignment = ProjectAssignment.find(:first, :conditions => { :project_id => self.id, :user_id => user.id })
    assignment.owner = 1
    assignment.save
  end
  
end
