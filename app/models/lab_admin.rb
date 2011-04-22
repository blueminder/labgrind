# A Lab administrator, who administrates one specific lab.
class LabAdmin < User
  belongs_to :lab

  # Checks whether or not this user is any kind of admin.
  def is_admin?
    true
  end

  # Checks whether or not this user is a site administrator.
  def is_super_admin?
    false
  end

  # Checks whether or not thus user can administer a certain lab.
  def administers_lab? lab
    self.lab == lab
  end
end
