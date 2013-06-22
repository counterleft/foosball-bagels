require "ostruct"

class Statistics
  def self.index_report
    players_grouped_by_bagel_ownage = Player.where('active = true')
    .joins('left outer join bagels on bagels.owner_id = players.id')
    .group(:name)
    .count

    bagels_given_over_time = Bagel.group_by_month(:baked_on).count
    best_team = TeamRank.by_plus_minus(Bagel.with_players.all).first
    worst_team = TeamRank.by_plus_minus(Bagel.with_players.all).last

    total_bagel_count = Bagel.count

    players_by_plus_minus = Player.active.ordered_by_plus_minus.all

    report = IndexReport.new(
      current_bagel_owner: CurrentBagelOwner.fetch,
      best_team: best_team,
      worst_team: worst_team,
      total_bagel_count: total_bagel_count,
      players_grouped_by_bagel_ownage: players_grouped_by_bagel_ownage,
      bagels_given_over_time: bagels_given_over_time,
      players_by_plus_minus: players_by_plus_minus
    )

    report
  end


  class IndexReport
    extend Forwardable
    include ActionView::Helpers
    include ActionDispatch::Routing
    include Rails.application.routes.url_helpers

    INSTANCE_METHODS = [:current_bagel_owner, :best_team, :worst_team, :total_bagel_count, :players_grouped_by_bagel_ownage, :bagels_given_over_time]

    INSTANCE_METHODS.each do |name|
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}
          @#{name}
        end
      CODE
    end

    def_delegator :@current_bagel_owner, :name, :current_bagel_owner_name

    def_delegator :@best_team, :offense, :best_team_offensive_player
    def_delegator :@best_team, :defense, :best_team_defensive_player
    def_delegator :@worst_team, :offense, :worst_team_offensive_player
    def_delegator :@worst_team, :defense, :worst_team_defensive_player

    def initialize(hash)
      hash.each do |k, v|
        send("#{k}=", v)
      end
    end

    def players_by_plus_minus
      list = @players_by_plus_minus.inject([]) do |acc, player|
        acc << "<td>#{link_to(player.name, player)}</td><td>#{colored(player.plus_minus)}</td>".html_safe
        acc
      end

      list
    end

    private

    INSTANCE_METHODS.each do |name|
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}=(name)
          @#{name} = name
        end
      CODE
    end

    def colored(plus_minus)
      if plus_minus > 0
        css_class = "positive"
      elsif plus_minus < 0
        css_class = "negative"
      end
      %(<span class="#{css_class}">#{plus_minus}</span>).html_safe
    end

    attr_writer  :current_bagel_owner, :best_team, :worst_team, :total_bagel_count, :players_grouped_by_bagel_ownage, :bagels_given_over_time, :players_by_plus_minus
  end
end
