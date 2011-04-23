require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "some users are admins" do
    assert_equal Admin.count, 2
    ["matt", "enrique"].each do |name|
      assert_equal User.find_by_username(name).class, Admin
    end
    ["joshua", "tim"].each do |name|
      assert_not_equal User.find_by_username(name).class, Admin
    end
  end
end
