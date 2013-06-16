require "ostruct"

class Statistics
  def self.index_report
    players_grouped_by_bagel_ownage = Player.where('active = true')
      .joins('left outer join bagels on bagels.owner_id = players.id')
      .group(:name)
      .count

    bagels_given_over_time = Bagel.group_by_month(:baked_on).count
    best_team = TeamRank.by_plus_minus(Bagel.with_players.all).first

    report = IndexReport.new(
      CurrentBagelOwner.fetch,
      best_team,
      players_grouped_by_bagel_ownage,
      bagels_given_over_time)
    report
  end


  class IndexReport
    extend Forwardable

    attr_reader :current_bagel_owner, :best_team, :players_grouped_by_bagel_ownage, :bagels_given_over_time

    def_delegator :@current_bagel_owner, :name, :current_bagel_owner_name

    def initialize(current_bagel_owner, best_team, players_grouped_by_bagel_ownage, bagels_given_over_time)
      @current_bagel_owner = current_bagel_owner
      @best_team = best_team
      @players_grouped_by_bagel_ownage = players_grouped_by_bagel_ownage
      @bagels_given_over_time = bagels_given_over_time
    end

    def best_team_player_names
      "#{best_team.offense.name} & #{best_team.defense.name}"
    end
  end
end
