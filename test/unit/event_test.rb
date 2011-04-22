require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "overlapping event" do
    lecture = Event.find_by_name("Lecture")
    lecture2 = Event.find_by_name("Other Lecture")
    workshop = Event.find_by_name("Work")
    test = Event.find_by_name("Event")
    assert not(lecture.overlaps? workshop)
    assert(lecture.overlaps? test)
    assert(test.overlaps? workshop)
    assert(lecture.overlaps? lecture2)
    assert(test.overlaps? lecture2)
  end

  test "non-overlapping events don't conflict" do
    lecture = Event.find_by_name("Lecture")
    workshop = Event.find_by_name("Work")
    assert not(lecture.conflicts_with? workshop)
  end

  test "non-exclusive events don't conflict" do
    workshop = Event.find_by_name("Work")
    test = Event.find_by_name("Event")    
    assert not(test.conflicts_with? workshop)
  end

  test "overlapping events in different labs don't conflict" do
    lecture = Event.find_by_name("Lecture")
    lecture2 = Event.find_by_name("Other Lecture")
    test = Event.find_by_name("Event")
    assert not(lecture.conflicts_with? lecture2)
    assert not(lecture2.conflicts_with? test)
  end

  test "exclusive events do conflict" do
    lecture = Event.find_by_name("Lecture")
    test = Event.find_by_name("Event")
    assert(lecture.conflicts_with? test)
  end
end
