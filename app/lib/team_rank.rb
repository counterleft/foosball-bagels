class TeamRank
  def self.by_plus_minus(bagels)
    ranked_teams = {}

    bagels.each do |bagel|
      if (bagel.missing_players?)
        # Some bagels don't have all the players in production
        # due to us only tracking the bagel_owner initially
        next
      end

      winning_team = Team.new(bagel.opponent_1, bagel.opponent_2)
      losing_team = Team.new(bagel.teammate, bagel.owner)

      winning_team = ranked_teams.fetch(winning_team, winning_team)
      winning_team.increment_plus_minus
      ranked_teams[winning_team] = winning_team

      losing_team = ranked_teams.fetch(losing_team, losing_team)
      losing_team.decrement_plus_minus
      ranked_teams[losing_team] = losing_team
    end

    ranked_teams.values.sort! { |t1, t2| t2.plus_minus <=> t1.plus_minus }
  end
end

