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

  def self.single_player(id, page)
    player = Player.find(id)
    return nil if player.nil?

    num_bagels_owned = Bagel.where("owner_id = ?", player.id).count
    total_bagels = Bagel.count

    data_for_bagels_owned_chart = { player.name => num_bagels_owned, "Others" => total_bagels }

    ranked_teams = TeamRank.by_plus_minus(Bagel.with_players.all)
    best_team_on_offense = ranked_teams.find { |team| team.offense_name == player.name }
    worst_team_on_offense = ranked_teams.reverse_each.find { |team| team.offense_name == player.name }
    best_team_on_defense = ranked_teams.find { |team| team.defense_name == player.name }
    worst_team_on_defense = ranked_teams.reverse_each.find { |team| team.defense_name == player.name }

    bagels = Bagel.with_players
    .where("owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
           player.id, player.id, player.id, player.id)
    .paginate(page: page)
    .order_by_baked_on

    SinglePlayerView.new(
      player,
      data_for_bagels_owned_chart,
      best_team_on_offense,
      worst_team_on_offense,
      best_team_on_defense,
      worst_team_on_defense,
      bagels
    )
  end
end
