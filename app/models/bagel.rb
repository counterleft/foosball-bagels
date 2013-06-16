class Bagel < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Player'
  belongs_to :teammate, :class_name => 'Player'
  belongs_to :opponent_1, :class_name => 'Player'
  belongs_to :opponent_2, :class_name => 'Player'

  cattr_reader :per_page
  @@per_page = 10

  scope :with_players, includes(:owner, :teammate, :opponent_1, :opponent_2)

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

  def baked_on_display
    return self[:baked_on].strftime("%Y-%m-%d")
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

  EXISTING_PLAYER_NEEDED_MSG = "must correspond to an existing player"

  def players_must_exist
    errors.add(:bagel_owner, EXISTING_PLAYER_NEEDED_MSG) if owner_id.nil?
    errors.add(:bagel_teammate, EXISTING_PLAYER_NEEDED_MSG) if teammate_id.nil?
    errors.add(:winning_offensive_player, EXISTING_PLAYER_NEEDED_MSG) if opponent_1_id.nil?
    errors.add(:winning_defensive_player, EXISTING_PLAYER_NEEDED_MSG) if opponent_2_id.nil?
  end

  def players_distinct
    players = [owner_id, teammate_id, opponent_1_id, opponent_2_id]
    possible_teams = players.collect { |p1| players.collect { |p2| [p1, p2] if p1 != p2 } }.inject {|sum, n| sum + n}.compact
    if possible_teams.size != 12
      errors.add(:base, "All players involved can only play one position (i.e. the same person cannot be the teammate and the owner)")
    end
  end
end

