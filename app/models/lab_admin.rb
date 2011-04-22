# A Lab administrator, who administrates one specific lab.
class LabAdmin < User
  belongs_to :lab

  def is_admin?
    true
  end

  def administers_lab? lab
    self.lab == lab
  end
end
