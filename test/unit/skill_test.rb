require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  test "users have skills" do
    matt = User.find_by_username("matt")
    joshua = User.find_by_username("joshua")
    assert_equal 2, matt.skills.size
    assert_equal 2, joshua.skills.size
    assert matt.skills.include?(Skill.find_by_name "Procrastination")
    assert joshua.skills.include?(Skill.find_by_name "Welding")
  end
end
