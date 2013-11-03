require "ostruct"

class Statistics
  def self.index_report
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
    ranked_teams.map! { |t| TeamPresenter.new_from(t) }
    ranked_teams = [ NullObjects::NullObjectPresenter.new ] if ranked_teams.empty?

    best_team = ranked_teams.first
    worst_team = ranked_teams.last

    total_bagel_count = Bagel.count

    players_by_plus_minus = Player.active.ordered_by_plus_minus.to_a
    players_by_plus_minus.map! { |p| PlayerPresenter.new_from(p) }

    current_bagel_owner = PlayerPresenter.new_from(CurrentBagelOwner.fetch)

    report = IndexReport.new(
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

  class IndexReport
    extend Forwardable
    include ActionView::Helpers
    include ActionDispatch::Routing
    include Rails.application.routes.url_helpers

    INSTANCE_METHODS = [:current_bagel_owner, :best_team, :worst_team, 
                        :total_bagel_count, :players_grouped_by_bagel_ownage, 
                        :bagels_given_over_time, :players_by_plus_minus]

    INSTANCE_METHODS.each do |name|
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}
          @#{name}
        end
      CODE
    end

    def_delegator :@current_bagel_owner, :name, :current_bagel_owner_name

    def_delegator :@best_team, :offense_name, :best_team_offensive_player_name
    def_delegator :@best_team, :defense_name, :best_team_defensive_player_name
    def_delegator :@worst_team, :offense_name, :worst_team_offensive_player_name
    def_delegator :@worst_team, :defense_name, :worst_team_defensive_player_name

    def initialize(hash)
      hash.each do |k, v|
        send("#{k}=", v)
      end
    end

    def each_player_by_plus_minus(&block)
      @players_by_plus_minus.each do |player|
        block.call(player)
      end
    end

    private

    INSTANCE_METHODS.each do |name|
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}=(name)
          @#{name} = name
        end
      CODE
    end

    attr_writer  :current_bagel_owner, :best_team, :worst_team, :total_bagel_count, :players_grouped_by_bagel_ownage, :bagels_given_over_time, :players_by_plus_minus
  end
end
