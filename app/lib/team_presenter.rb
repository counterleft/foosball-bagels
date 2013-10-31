class TeamPresenter < Presenter
  extend Forwardable

  def_delegator :@offense, :offense
  def_delegator :@offense, :name, :offense_name
  def_delegator :@defense, :defense
  def_delegator :@defense, :name, :defense_name

  def initialize(team)
    super(team)
    @offense = PlayerPresenter.new_from(team.offense)
    @defense = PlayerPresenter.new_from(team.defense)
  end
end
