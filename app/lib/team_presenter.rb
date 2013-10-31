class TeamPresenter
  extend Forwardable

  def_delegator :@team, :plus_minus
  def_delegator :@offense, :offense
  def_delegator :@offense, :name, :offense_name
  def_delegator :@defense, :defense
  def_delegator :@defense, :name, :defense_name

  def initialize(team)
    @offense = PlayerPresenter.new_from(team.offense)
    @defense = PlayerPresenter.new_from(team.defense)
    @team = team
  end

  def self.new_from(team)
    if team
      TeamPresenter.new(team)
    else
      NullPresenter.new
    end
  end
end
