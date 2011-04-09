class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  def pending?
    status.downcase === "pending"
  end

  def cancelled?
    status.downcase === "cancelled"
  end

  def complete?
    status.downcase === "complete"
  end

  def self.factory(type,params)
    if defined? type.constantize
      return type.constantize.new(params)
    else
      # We shouldn't ever give back just a generic Transaction --
      # it should always be one of its subclasses.
      nil
    end
  end

  def class_type=(value)
    self[:type] = value
  end

  def class_type
    return self[:type]
  end

  def created
    puts "created generic transaction?"
  end

  def approve
  end
  
  def cancel
  end
end
