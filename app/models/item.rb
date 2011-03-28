class Item < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :lab
  belongs_to :user
  has_many :annotations
  has_many :transactions

  def last_transaction
    transactions.reverse.find{|t| not t.created_at.nil?}
  end

  def checked_out?
    not user.nil?
  end

  def checkout_requested?
    not last_transaction.nil? \
    and last_transaction.is_a? Checkout \
    and not last_transaction.complete?
  end
end
