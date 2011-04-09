# A piece of equipment which belongs to a laboratory.
class Item < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :lab
  belongs_to :user
  has_many :annotations
  has_many :transactions

  # Finds the last transaction on this object.
  def last_transaction
    # For mysterious reasons, Rails seems to like to insert "phantom" elements
    # into our transactions list (but only under specific routes
    # configurations?), so just getting the last element of the transaction
    # array won't work. We use this approach because the "phantom" elements
    # seem to have every field nil, so using created_at is a reliable test of
    # whether or not someone actually created the annotation.
    transactions.reverse.find{|t| not t.created_at.nil?}
  end

  # Tests whether or not the item's currently checked out.
  def checked_out?
    not user.nil?
  end

  # Tests whether or not someone's requested this item for checkout. Ideally,
  # two people shouldn't be able to request a checkout for the same item at the
  # same time. This method doesn't give back which user requested the checkout,
  # just that someone did. If you want the user, you should use
  # last_transaction.user.
  def checkout_requested?
    not last_transaction.nil? \
    and last_transaction.is_a? Checkout \
    and not last_transaction.complete?
  end

end
