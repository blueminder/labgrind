class Project < ActiveRecord::Base
  has_many :project_assignments
  has_many :users, :through => :project_assignments
  
  def set_owner(user)
    assignment = ProjectAssignment.find(:first, :conditions => { :project_id => self.id, :user_id => user.id })
    assignment.owner = 1
    assignment.save
  end
  
  def owners
    assignments = ProjectAssignment.find(:all, :conditions => { :project_id => self.id, :owner => 1 })
    assignments.collect{ |a| User.find(a.user_id) }
  end
  
end
