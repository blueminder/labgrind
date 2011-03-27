class Checkin < Transaction

  def approve
    item.user = nil
    item.save
  end

end
