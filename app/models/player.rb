class Player < ActiveRecord::Base

  has_many :bagels

  validates_presence_of :name
  validates_uniqueness_of :name

  def name=(name)
    self[:name] = name.gsub(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
  end

  def incr_plus_minus
    increment :plus_minus
  end

  def decr_plus_minus
    decrement :plus_minus
  end

  def self.bagel_contributors
    return Player.find(:all, :conditions => ["plus_minus = ?", Player.minimum(:plus_minus)])
  end

  def self.bagel_preventers
    return Player.find(:all, :conditions => ["plus_minus = ?", Player.maximum(:plus_minus)])
  end
end

