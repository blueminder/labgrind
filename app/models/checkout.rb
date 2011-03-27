class Checkout < Transaction
  validates_presence_of :due_date

  def approve
    item.user = user
    item.save
  end

end
