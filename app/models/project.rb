class Project < ActiveRecord::Base
  has_many :project_assignments
  has_many :users, :through => :project_assignments
  has_many :project_updates
  has_many :events
  
  def add_owner(user)
    assignment = ProjectAssignment.find(:first, :conditions => { :project_id => self.id, :user_id => user.id })
    assignment.owner = 1
    assignment.save
  end
  
  def remove_owner(user)
    to_own = ProjectAssignment.find(:first, :conditions => { :project_id => @project.id, :user_id => user.id })
    to_own.owner = 0
    to_own.save
  end
  
  def owners
    assignments = ProjectAssignment.find(:all, :conditions => { :project_id => self.id, :owner => 1 })
    assignments.collect{ |a| User.find(a.user_id) }
  end
  
end
