class PlayersController < ApplicationController
  before_filter :require_sign_in

  def index
    @active_nav_link = "players-nav-link"

    raw_players = Player.active.order("name, surname asc")
    @players = raw_players.map { |p| PlayerPresenter.new(p) }
  end

  def show
    @player = FindPlayers.single_player(params[:id], params[:page])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.active = true

    respond_to do |format|
      if @player.save
        flash[:notice] = "We got ourselves a new player!"
        format.html { redirect_to(players_path) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @player = FindPlayers.single_player(params[:id])
  end

  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes!(player_params)
        flash[:notice] = "Player was successfully updated."
        format.html { redirect_to(@player) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :active)
  end
end

