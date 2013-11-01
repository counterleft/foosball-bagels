class Player < ActiveRecord::Base
  has_many :bagels

  validates_presence_of :name

  def self.active
    where("active = true")
  end

  def self.ordered_by_plus_minus
    order("plus_minus desc, name asc")
  end

  def name=(name)
    self[:name] = name.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
  end

  def incr_plus_minus
    increment :plus_minus
  end

  def decr_plus_minus
    decrement :plus_minus
  end

  def to_s
    self.name
  end
end

