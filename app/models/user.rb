class User < ActiveRecord::Base
  acts_as_authentic
  has_many :skills
  has_many :labs
  has_many :annotations

  def self.factory(type,params)
    type ||= 'User'
    class_name = type

    if defined? class_name.constantize
      return class_name.constantize.new(params)
    else
      User.new(params)
    end

  end

  def class_type=(value)
    self[:type] = value
  end

  def class_type
    return self[:type]
  end

end
