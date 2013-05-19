class FindPlayers
  def self.get_players_for(bagel)
    bagel_owner = Player.find_by_id(bagel.owner_id)
    bagel_teammate = Player.find_by_id(bagel.teammate_id)
    winning_offensive_player = Player.find_by_id(bagel.opponent_1_id)
    winning_defensive_player = Player.find_by_id(bagel.opponent_2_id)
    PlayersForBagel.new(bagel_owner, bagel_teammate, winning_offensive_player, winning_defensive_player)
  end

  def self.get_players_by_name(create_bagel)
    bagel_owner = Player.find_by_name(create_bagel.owner_name)
    bagel_teammate = Player.find_by_name(create_bagel.teammate_name)
    winning_offensive_player = Player.find_by_name(create_bagel.winning_offensive_player_name)
    winning_defensive_player = Player.find_by_name(create_bagel.winning_defensive_player_name)
    PlayersForBagel.new(bagel_owner, bagel_teammate, winning_offensive_player, winning_defensive_player)
  end
end
