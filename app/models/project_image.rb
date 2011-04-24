class ProjectImage < ActiveRecord::Base
  belongs_to :project
  has_attached_file :image, :styles => { :large => "120x120>", :medium => "48x48>", :thumb => "26x26>" }
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
end
