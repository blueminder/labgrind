class Item < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :lab
  has_many :annotations
  has_many :transactions

  def last_transaction
    transactions.reverse.find{|t| not t.created_at.nil?}
  end

  def checked_out?
    not last_transaction.nil? \
    and last_transaction.is_a? Checkout \
    and last_transaction.complete?
  end

  def checkout_requested?
    not last_transaction.nil? \
    and last_transaction.is_a? Checkout \
    and not last_transaction.complete?
  end

  def checked_out_by
    checked_out? and last_transaction.user
  end
end
