# A calendar event.
# This simply respresents some kind of event that people want to make note
# of, that runs for a specific period of time. It can be marked as exclusive,
# meaning the lab can be reserved for that period of time, and (TODO) it can
# also be tied to a specific project.
class Event < ActiveRecord::Base
  belongs_to :lab
end
