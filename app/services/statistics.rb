require "ostruct"

class Statistics
  def self.index_report
    best_team = TeamRank.by_plus_minus(Bagel.with_players.all).first
    report = IndexReport.new(CurrentBagelOwner.fetch, best_team)
    report
  end


  class IndexReport
    extend Forwardable

    attr_reader :current_bagel_owner, :best_team

    def_delegator :@current_bagel_owner, :name, :current_bagel_owner_name

    def initialize(current_bagel_owner, best_team)
      @current_bagel_owner = current_bagel_owner
      @best_team = best_team
    end

    def best_team_player_names
      "#{best_team.offense.name} & #{best_team.defense.name}"
    end
  end
end
