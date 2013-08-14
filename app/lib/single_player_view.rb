class SinglePlayerView
  extend Forwardable

  attr_reader :data_for_bagels_owned_chart,
    :best_team_on_offense,
    :worst_team_on_offense,
    :best_team_on_defense,
    :worst_team_on_defense,
    :bagels

  def_delegators :@player, :name, :plus_minus

  def initialize(player,
                 data_for_bagels_owned_chart,
                 best_team_on_offense,
                 worst_team_on_offense,
                 best_team_on_defense,
                 worst_team_on_defense,
                 bagels)
    @player = player
    @data_for_bagels_owned_chart = data_for_bagels_owned_chart
    @best_team_on_offense = best_team_on_offense
    @worst_team_on_offense = worst_team_on_offense
    @best_team_on_defense = best_team_on_defense
    @worst_team_on_defense = worst_team_on_defense
    @bagels = bagels
  end

end
