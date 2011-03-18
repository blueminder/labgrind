class Checkout < Transaction
  validates_presence_of :due_date
end
