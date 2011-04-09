# A transaction that represents an item being checked back in. It's intended
# use is that only Admins can check items back in, so there's no wait-for-
# approval cycle here.
class Checkin < Transaction

  # This should be called when the transaction is created.
  # In this case, it simply removes the item we just checked in from the
  # user's possession.
  def created
    item.user = nil
    item.save
  end

end
