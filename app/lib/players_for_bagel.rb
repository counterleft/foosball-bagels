class PlayersForBagel
  attr_reader :bagel_owner, :bagel_teammate, :winning_offensive_player, :winning_defensive_player

  def initialize(bagel_owner, bagel_teammate, winning_offensive_player, winning_defensive_player)
    @bagel_owner = bagel_owner
    @bagel_teammate = bagel_teammate
    @winning_offensive_player = winning_offensive_player
    @winning_defensive_player = winning_defensive_player
  end

  def bagel_owner_id
    bagel_owner.nil? ? nil : bagel_owner.id
  end

  def bagel_teammate_id
    bagel_teammate.nil? ? nil : bagel_teammate.id
  end

  def winning_offensive_player_id
    winning_offensive_player.nil? ? nil : winning_offensive_player.id
  end

  def winning_defensive_player_id
    winning_defensive_player.nil? ? nil : winning_defensive_player.id
  end

  private
  def players
    [bagel_owner, bagel_teammate, winning_offensive_player, winning_defensive_player]
  end
end
