require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "items belong to labs" do
    assert_equal(Item.find_by_name("Laser Cutter").lab,
                 Lab.find_by_name("CoC 332"))
  end

  test "items have annotations" do
    laser = Item.find_by_name("Laser Cutter")
    assert_equal laser.annotations.size, 2
  end

  test "items have transactions" do
    rover = Item.find_by_name("Moon Rover")
    assert_equal rover.transactions.size, 4
    laser = Item.find_by_name("Laser Cutter")
    assert_equal laser.transactions.size, 1
  end

  test "items last transaction" do
    trans = Item.find_by_name("Moon Rover").last_transaction
    assert_not_nil trans
    assert_equal trans.user, User.find_by_username("matt")
    assert_equal trans.class, Checkin

    trans = Item.find_by_name("Laser Cutter").last_transaction
    assert_not_nil trans
    assert_equal trans.user, User.find_by_username("tim")
    assert_equal trans.class, Checkout

    trans = Item.find_by_name("Moon Laser").last_transaction
    assert_nil trans
  end

  test "item knows whether or not it's checked out" do
    assert(Item
             .find_by_name("High-Energy Particle Accelerator")
             .checked_out?)
    assert(not(Item.find_by_name("Moon Laser").checked_out?))
  end

  test "item knows whether or not a checkout's requested" do
    assert(Item.find_by_name("Laser Cutter").checkout_requested?)
    assert(not(Item
                 .find_by_name("High-Energy Particle Accelerator")
                 .checkout_requested?))
  end

  test "item knows when it's due" do
    assert_in_delta(3.days.from_now,
                    Item
                      .find_by_name("High-Energy Particle Accelerator")
                      .due_date,
                    10.seconds)
    assert_nil(Item.find_by_name("Moon Rover").due_date)
    assert_nil(Item.find_by_name("Moon Laser").due_date)
  end

  test "item knows when it's overdue" do
    assert Item.find_by_name("Apollo 13 Video Set").overdue?
    assert not(Item.find_by_name("Moon Rover").overdue?)
  end
end
