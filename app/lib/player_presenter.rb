class PlayerPresenter < Presenter
  extend Forwardable

  attr_reader :data_for_bagels_owned_chart,
    :best_team_on_offense,
    :worst_team_on_offense,
    :best_team_on_defense,
    :worst_team_on_defense,
    :bagels

  def initialize(player,
                 data_for_bagels_owned_chart = nil,
                 best_team_on_offense = TeamPresenter.new,
                 worst_team_on_offense = TeamPresenter.new,
                 best_team_on_defense = TeamPresenter.new,
                 worst_team_on_defense = TeamPresenter.new,
                 bagels = [])
    super(player)
    @data_for_bagels_owned_chart = data_for_bagels_owned_chart
    @best_team_on_offense = best_team_on_offense
    @worst_team_on_offense = worst_team_on_offense
    @best_team_on_defense = best_team_on_defense
    @worst_team_on_defense = worst_team_on_defense
    @bagels = BagelListPresenter.new(bagels)
  end

  def name
    PlayerPresenter.name_for(player.name, player.surname)
  end

  def full_name
    "#{player.name} #{player.surname}"
  end

  def plus_minus_color
    css_class = ""

    if plus_minus > 0
      css_class = "positive"
    elsif plus_minus < 0
      css_class = "negative"
    end

    css_class
  end

  def <=>(other)
    name <=> other.name
  end

  def self.name_for(name, surname)
    if !surname.nil?
      "#{name} #{surname[0]}."
    else
      name
    end
  end
end
