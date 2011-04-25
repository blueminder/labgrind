# A skill that users can have and must be granted by administrators.
class Skill < ActiveRecord::Base
  has_and_belongs_to_many :users
end
