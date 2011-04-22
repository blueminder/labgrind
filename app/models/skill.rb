# A skill that users can have, such as laser cutter training or what have you.
# I hear from very reliable sources that "chicks dig skills".
class Skill < ActiveRecord::Base
  has_and_belongs_to_many :users
end
