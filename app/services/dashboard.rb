require "ostruct"

class Dashboard
  def self.report
    raw_players_grouped_by_bagel_ownage = Player.active
    .joins("inner join bagels on bagels.owner_id = players.id")
    .group(:name, :surname)
    .count

    players_grouped_by_bagel_ownage = {}
    raw_players_grouped_by_bagel_ownage.each do |name_pair,num_bagels_received|
      name = name_pair[0]
      surname = name_pair[1]
      display_name = PlayerPresenter.name_for(name, surname)
      players_grouped_by_bagel_ownage[display_name] = num_bagels_received
    end

    bagels_given_over_time = Bagel.group_by_month(:baked_on).count

    ranked_teams = TeamRank.by_plus_minus(Bagel.with_active_players)
    ranked_teams = TeamListPresenter.new(ranked_teams)

    best_team = ranked_teams.best_team
    worst_team = ranked_teams.worst_team

    total_bagel_count = Bagel.count

    players_by_plus_minus = Player.active.ordered_by_plus_minus.to_a
    players_by_plus_minus = PlayerListPresenter.new(players_by_plus_minus)

    current_bagel_owner = PlayerPresenter.new(CurrentBagelOwner.fetch)

    report = DashboardReport.new(
      current_bagel_owner: current_bagel_owner,
      best_team: best_team,
      worst_team: worst_team,
      total_bagel_count: total_bagel_count,
      players_grouped_by_bagel_ownage: players_grouped_by_bagel_ownage,
      bagels_given_over_time: bagels_given_over_time,
      players_by_plus_minus: players_by_plus_minus,
    )

    report
  end

end
