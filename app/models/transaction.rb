class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

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
end
