# This class represents an administrator, distinct from a regular user.
class Admin < User
  # Right now, Admin serves as little more than a field granting permissions.
  # In the future, though, it might be useful to gve admins some kind of
  # polymorphic behavior; that' when code will magically appear here.
end
