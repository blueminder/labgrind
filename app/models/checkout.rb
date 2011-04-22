# A class that represents someone checking out equipment for use. The intended
# use is for a user to request a checkout, and then for an admin to go in, set
# a due date for its return, and then approve or deny the checkout request.
class Checkout < Transaction
  validates_presence_of :due_date

  # This should be called when the transaction is approved.
  # In this case, it assigns the item to the user who just checked it out.
  def approve
    item.user = user
    item.save
  end

end
