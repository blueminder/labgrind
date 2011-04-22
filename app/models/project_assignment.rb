# An assignment of a project to a person.
class ProjectAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end
