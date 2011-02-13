class Lab < ActiveRecord::Base
  validates :name, :presence => true
  has_many :items
end
