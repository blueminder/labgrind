require "transaction.rb"

class CheckOut < Transaction
  validates_presence_of :due_date
end
