require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "handles statuses" do
    # HA! NO FIXTURE FOR YOU!
    t = Transaction.new
    t.status = "Pending"
    assert t.pending?
    assert not(t.cancelled?)
    assert not(t.complete?)

    t.status = "Cancelled"
    assert not(t.pending?)
    assert t.cancelled?
    assert not(t.complete?)

    t.status = "Complete"
    assert not(t.pending?)
    assert not(t.cancelled?)
    assert t.complete?

    t.status = "Lost in an existential crisis"
    assert not(t.pending?)
    assert not(t.cancelled?)
    assert not(t.complete?)
  end

  test "checkout sets user on approval" do
    t = Transaction.find(1)
    assert_equal Checkout, t.class

    tim = User.find_by_username("tim")
    assert_equal tim, t.user

    lasercutter = Item.find_by_name("Laser Cutter")
    assert_equal lasercutter, t.item

    assert lasercutter.checkout_requested?
    assert_nil lasercutter.user

    t.approve
    lasercutter = Item.find_by_name("Laser Cutter")
    assert_equal tim, lasercutter.user
  end

  test "checkin unsets user" do
    accel = Item.find_by_name("High-Energy Particle Accelerator")
    joshua = User.find_by_username("joshua")
    assert_equal joshua, accel.user
    t = Checkin.new
    t.item = accel
    t.user = User.find_by_username("enrique")
    t.status = "Complete"
    t.created
    accel = Item.find_by_name("High-Energy Particle Accelerator")
    assert_nil accel.user
  end
end
