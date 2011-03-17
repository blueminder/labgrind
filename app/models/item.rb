class Item < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :lab
  has_many :annotations
  has_many :transactions
end
