# Represents one user's session; this is what manages logins and such. I think.
# Enrique would probably know, but he's doing machine learning so you get
# stuck with this unhelpful comment.
class UserSession < Authlogic::Session::Base
  
  # Converts this user session to a key. I don't know what that means, but I'm
  # assuming it has something to do with authentication. I dunno. Ask Enrique.
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  # Whether or not this session persists across whatever it could possibly
  # persist across.
  def persisted?
    false
  end
end
