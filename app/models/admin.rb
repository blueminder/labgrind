# This class represents an administrator, distinct from a regular user.
class Admin < User
  # Checks whether or not this user is any kind of admin.
  def is_admin?
    true
  end

  # Checks whether or not this user is a site administrator.
  def is_super_admin?
    true
  end

  # Checks whether or not thus user can administer a certain lab.
  def administers_lab? lab
    true
  end
end
