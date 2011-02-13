class Annotation < ActiveRecord::Base
  validates :text, :presence => true
  belongs_to :item
end
