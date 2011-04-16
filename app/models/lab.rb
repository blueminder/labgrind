# A laboratory which is "managed" by our software.
# Currently, this class acts as little more than a data container.
class Lab < ActiveRecord::Base
  validates :name, :presence => true
  has_many :items
  has_many :events
end
