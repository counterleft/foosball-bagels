require 'set'

class Bagel < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Player'
  belongs_to :teammate, :class_name => 'Player'
  belongs_to :opponent_1, :class_name => 'Player'
  belongs_to :opponent_2, :class_name => 'Player'

  cattr_reader :per_page
  @@per_page = 10

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
    if self.baked_on < o.baked_on
      return 1
    elsif self.baked_on > o.baked_on
      return -1
    else
      return self.id <=> o.id
    end
  end

  def baked_on_display
    return self[:baked_on].strftime("%Y-%m-%d")
  end

  def self.current_owner(recent_bagels_desc=[])
    if !recent_bagels_desc.empty?
      return recent_bagels_desc.first.owner
    end
    latest_bagel = Bagel.find(:first, :order => 'baked_on desc, created_at desc, id desc')
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

    opponent_1.incr_plus_minus
    opponent_1.save

    opponent_2.incr_plus_minus
    opponent_2.save
  end

  EXISTING_PLAYER_NEEDED_MSG = "must correspond to an existing player"

  def players_must_exist
    errors.add(:owner_name, EXISTING_PLAYER_NEEDED_MSG) if owner.nil?
    errors.add(:teammate_name, EXISTING_PLAYER_NEEDED_MSG) if teammate.nil?
    errors.add(:opponent_1_name, EXISTING_PLAYER_NEEDED_MSG) if opponent_1.nil?
    errors.add(:opponent_2_name, EXISTING_PLAYER_NEEDED_MSG) if opponent_2.nil?
  end

  def players_distinct
    players_involved = [self.owner_name, self.teammate_name, self.opponent_1_name, self.opponent_2_name]
    possible_teams = players_involved.collect { |p1| players_involved.collect { |p2| [p1, p2] if p1 != p2 } }.inject {|sum, n| sum + n}.compact
    if possible_teams.size != 12
      errors.add(:base, "All players involved can only play one position (i.e. the same person cannot be the teammate and the owner)")
    end
  end
end

