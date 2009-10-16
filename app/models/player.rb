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
    return Player.find(:all, :conditions => ["plus_minus = ?", Player.minimum(:plus_minus)], :order => "name asc")
  end

  def self.bagel_preventers
    return Player.find(:all, :conditions => ["plus_minus = ?", Player.maximum(:plus_minus)], :order => "name asc")
  end

  def self.special_wager_players
    bill = Player.find(:first, :conditions => { :name => 'Bill' })
    bill_pluses_over_timespan = Bagel.count(:conditions => [
            "(baked_on > ? and baked_on < ?) and (opponent_1_id = ? or opponent_2_id = ?)",
            Date.new(2009, 10, 15), Date.new(2009, 12, 26), bill.id, bill.id])
    
    bill_minuses_over_timespan = Bagel.count(:conditions => [
            "(baked_on > ? and baked_on < ?) and (owner_id = ? or teammate_id = ?)",
            Date.new(2009, 10, 15), Date.new(2009, 12, 26), bill.id, bill.id])

    paul = Player.find(:first, :conditions => { :name => 'Paul' })
    paul_pluses_over_timespan = Bagel.count(:conditions => [
            "(baked_on > ? and baked_on < ?) and (opponent_1_id = ? or opponent_2_id = ?)",
            Date.new(2009, 10, 15), Date.new(2009, 12, 26), paul.id, paul.id])

    paul_minuses_over_timespan = Bagel.count(:conditions => [
            "(baked_on > ? and baked_on < ?) and (owner_id = ? or teammate_id = ?)",
            Date.new(2009, 10, 15), Date.new(2009, 12, 26), paul.id, paul.id])


    return { bill => bill_pluses_over_timespan - bill_minuses_over_timespan,
             paul => paul_pluses_over_timespan - paul_minuses_over_timespan }
  end
end

