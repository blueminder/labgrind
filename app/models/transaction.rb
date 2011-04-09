# A transaction, such as someone checking equipment out, or checking it back in,
# or sending it off for repair, or what have you.
class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  # Checks whether or not this transaction is pending, meaning it needs some
  # further administrative action.
  def pending?
    status.downcase === "pending"
  end

  # Checks whether or not this transaction has been cancelled, as in the case
  # of a checkout request that was denied.
  def cancelled?
    status.downcase === "cancelled"
  end

  # Checks whether or not the transaction was completed successfully.
  def complete?
    status.downcase === "complete"
  end

  # A factory method which creates Transactions of appropriate types.
  # The type parameter should always be some subtype of transaction, such as
  # Checkin or Checkout; if you try to just create a Transaction, you'll just
  # get nil, because, seriously, what does that even mean, semantically I mean.
  def self.factory(type,params)
    if defined? type.constantize
      return type.constantize.new(params)
    else
      # We shouldn't ever give back just a generic Transaction --
      # it should always be one of its subclasses.
      nil
    end
  end

  # Changes the type of this class. This seems like a stupid method to have,
  # so I'm assuming there's a good reason why this is still here.
  def class_type=(value)
    self[:type] = value
  end

  # Gets the type of this transaction.
  def class_type
    return self[:type]
  end

  # This should be called when the transaction is created.
  # This has no useful behavior, but is useful for subclasses which need to do
  # things upon creation.
  def created
    puts "created generic transaction?"
  end

  # This should be called when the transaction is approved.
  # This has no actual functionality, but can be overridden by subclasses.
  def approve
  end

  # Cancels the current pending transaction.  
  def cancel
  end
end
