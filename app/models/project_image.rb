# An object that represents the image of a project
class ProjectImage < ActiveRecord::Base
  belongs_to :project
  has_attached_file :image, :styles => { :full => "640x480>", :large => "120x120>", :large_thumb => "100x100#" }
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
end
