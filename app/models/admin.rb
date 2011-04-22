# This class represents an administrator, distinct from a regular user.
class Admin < User
  def is_admin?
    true
  end

  def administers_lab? lab
    true
  end
end
