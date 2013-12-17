class TeamListPresenter < Presenter
  def best_team
    TeamPresenter.new(team_list.first)
  end
  
  def worst_team
    TeamPresenter.new(team_list.last)
  end
end
