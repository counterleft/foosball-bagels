class DashboardReport
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

