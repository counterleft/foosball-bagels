class PlayerListPresenter < Presenter
  def each_player(&block)
    wrapped_enum(PlayerPresenter, player_list, &block)
  end
end
