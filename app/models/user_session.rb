# Represents one user's session; anything stored per session is related to this
# class.
class UserSession < Authlogic::Session::Base
  
  # Gets the key for this session.
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  # Whether or not this session persists across server restarts.
  def persisted?
    false
  end
end
