class Checkin < Transaction

  def created
    item.user = nil
    item.save
  end

end
