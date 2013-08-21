class Bagel < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Player'
  belongs_to :teammate, :class_name => 'Player'
  belongs_to :opponent_1, :class_name => 'Player'
  belongs_to :opponent_2, :class_name => 'Player'

  self.per_page = 10

  def self.with_players
    includes(:owner, :teammate, :opponent_1, :opponent_2)
  end

  def self.with_active_players
    with_players.select do |b|
      if b.missing_players?
        b.owner.active?
      else
        b.owner.active? && b.teammate.active? && b.opponent_1.active? && b.opponent_2.active?
      end
    end
  end

  def self.order_by_baked_on
    order("baked_on desc, created_at desc")
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

  def missing_players?
    owner_id.nil? || teammate_id.nil? || opponent_1_id.nil? || opponent_2_id.nil?
  end

  def players=(players_for_bagel)
    self[:owner_id] = players_for_bagel.bagel_owner_id
    self[:teammate_id] = players_for_bagel.bagel_teammate_id
    self[:opponent_1_id] = players_for_bagel.winning_offensive_player_id
    self[:opponent_2_id] = players_for_bagel.winning_defensive_player_id
  end

  validate :players_must_exist, :players_distinct
  validates_presence_of :baked_on

  private

  EXISTING_PLAYER_NEEDED_MSG = "must be an existing player"

  def players_must_exist
    errors.add(:bagel_owner_name, "^Owner #{EXISTING_PLAYER_NEEDED_MSG}") if owner_id.nil?
    errors.add(:bagel_teammate_name, "^Teammate #{EXISTING_PLAYER_NEEDED_MSG}") if teammate_id.nil?
    errors.add(:bagel_opponent_1_name, "^Winning Offensive Player #{EXISTING_PLAYER_NEEDED_MSG}") if opponent_1_id.nil?
    errors.add(:bagel_opponent_2_name, "^Winning Defensive Player #{EXISTING_PLAYER_NEEDED_MSG}") if opponent_2_id.nil?
  end

  def players_distinct
    players = [owner_id, teammate_id, opponent_1_id, opponent_2_id]
    possible_teams = players.collect { |p1| players.collect { |p2| [p1, p2] if p1 != p2 } }.inject {|sum, n| sum + n}.compact
    if possible_teams.size != 12
      errors.add(:base, "All players involved can only play one position (i.e. the same person cannot be the teammate and the owner)")
    end
  end
end

