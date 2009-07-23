require 'set'

class Bagel < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Player'
  belongs_to :teammate, :class_name => 'Player'
  belongs_to :opponent_1, :class_name => 'Player'
  belongs_to :opponent_2, :class_name => 'Player'

  def owner_name
    owner.name if owner
  end

  def owner_name=(name)
    self.owner = Player.find_by_name(name)
  end

  def teammate_name
    teammate.name if teammate
  end

  def teammate_name=(name)
    self.teammate = Player.find_by_name(name)
  end

  def opponent_1_name
    opponent_1.name if opponent_1
  end

  def opponent_1_name=(name)
    self.opponent_1 = Player.find_by_name(name)
  end

  def opponent_2_name
    opponent_2.name if opponent_2
  end

  def opponent_2_name=(name)
    self.opponent_2 = Player.find_by_name(name)
  end

  def <=>(o)
    return o.baked_on <=> self.baked_on
  end

  def self.current_owner
    latest_bagel = Bagel.find(:last, :order => 'baked_on, created_at')
    return latest_bagel.owner if latest_bagel
  end

  after_create :adjust_players_plus_minus

  validate :players_must_exist, :players_distinct
  validates_presence_of :baked_on
  
  private
  def adjust_players_plus_minus
    owner.decr_plus_minus
    owner.save

    teammate.decr_plus_minus
    teammate.save

    opponent_1.decr_plus_minus
    opponent_1.save

    opponent_2.decr_plus_minus
    opponent_2.save
  end

  def players_must_exist
    errors.add(:owner_name, "must exist correspond to an exist player") if owner.nil?
    errors.add(:teammate_name, "must exist correspond to an exist player") if teammate.nil?
    errors.add(:opponent_1_name, "must exist correspond to an exist player") if opponent_1.nil?
    errors.add(:opponent_2_name, "must exist correspond to an exist player") if opponent_2.nil?
  end

  def players_distinct
    players_involved = [self.owner_name, self.teammate_name, self.opponent_1_name, self.opponent_2_name]
    possible_teams =  players_involved.collect { |p1| players_involved.collect { |p2| [p1, p2] if p1 != p2 } }.reduce(:+).compact
    if possible_teams.size != 12
      errors.add_to_base("All players involved can only play one position (i.e. the same person cannot be the teammate and the owner)")
    end
  end
end

