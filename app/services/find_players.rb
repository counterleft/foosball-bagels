class FindPlayers
  def self.get_players_for(bagel)
    bagel_owner = Player.find_by_id(bagel.owner_id)
    bagel_teammate = Player.find_by_id(bagel.teammate_id)
    winning_offensive_player = Player.find_by_id(bagel.opponent_1_id)
    winning_defensive_player = Player.find_by_id(bagel.opponent_2_id)
    PlayersForBagel.new(bagel_owner, bagel_teammate, winning_offensive_player, winning_defensive_player)
  end

  def self.active_players_as_json
    players = Player.active.map { |p| PlayerPresenter.new(p) }.sort
    Jbuilder.encode do |json|
      json.array!(players, :id, :name)
    end
  end

  def self.single_player(id, page = nil)
    player = Player.find(id)
    return nil if player.nil?

    num_bagels_owned = Bagel.where("owner_id = ?", player.id).count
    num_rest_of_bagels = Bagel.count - num_bagels_owned

    data_for_bagels_owned_chart = { player.name => num_bagels_owned, "Others" => num_rest_of_bagels }

    raw_bagels = Bagel.with_players
    .where("owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
           player.id, player.id, player.id, player.id)
    .paginate(page: page)
    .order_by_baked_on

    ranked_teams = TeamRank.by_plus_minus(raw_bagels)
    best_team_on_offense = TeamPresenter.new(ranked_teams.find { |team| team.offense_name == player.name })
    worst_team_on_offense = TeamPresenter.new(ranked_teams.reverse_each.find { |team| team.offense_name == player.name })
    best_team_on_defense = TeamPresenter.new(ranked_teams.find { |team| team.defense_name == player.name })
    worst_team_on_defense = TeamPresenter.new(ranked_teams.reverse_each.find { |team| team.defense_name == player.name })

    bagels = BagelListPresenter.new(raw_bagels)

    PlayerPresenter.new(
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
