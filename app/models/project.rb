# Represents a project of users
class Project < ActiveRecord::Base
  has_many :project_assignments
  has_many :users, :through => :project_assignments
  has_many :project_updates
  has_many :events
 
  has_many :project_images, :dependent => :destroy
  accepts_nested_attributes_for :project_images, :allow_destroy => true
  
  # Makes the user of a project an owner
  def add_owner(user)
    assignment = ProjectAssignment.find(:first, :conditions => { :project_id => self.id, :user_id => user.id })
    assignment.owner = 1
    assignment.save
  end

  # Removes the owner of the project from the list.
  def remove_owner(user)
    to_own = ProjectAssignment.find(:first, :conditions => { :project_id => @project.id, :user_id => user.id })
    to_own.owner = 0
    to_own.save
  end
  
  # Gets a list of all owners of the project
  def owners
    assignments = ProjectAssignment.find(:all, :conditions => { :project_id => self.id, :owner => 1 })
    assignments.collect{ |a| User.find(a.user_id) }
  end
  
end
