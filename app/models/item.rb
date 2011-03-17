require "checkout.rb"

class Item < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :lab
  has_many :annotations
  has_many :transactions

  def checked_out?
    not transactions.empty? \
    and transactions[-1].is_a? CheckOut \
    and transactions[-1].complete?
  end

  def checkout_requested?
    not transactions.empty? \
    and transactions[-1].is_a? CheckOut \
    and not transactions[-1].complete?
  end
end
