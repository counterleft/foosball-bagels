class PlayersController < ApplicationController

  caches_page :index

  before_filter :require_sign_in

  def index
    @active_nav_link = "players-nav-link"
    @players = Player.active.order("name asc")

    respond_to do |format|
      format.html
    end
  end

  def all
    @players = Player.order("plus_minus desc, name asc")

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @players }
      format.json { render :json => Player.all }
    end
  end

  def show
    player_id = params[:id]
    @player = Player.find(player_id)
    @bagels = Bagel.paginate :page => params[:page],
      :conditions => ["owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
                      player_id, player_id, player_id, player_id],
                      :order => 'baked_on desc, created_at desc'

    respond_to do |format|
      format.html
    end
  end

  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.haml
    end
  end

  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Player was successfully created.'
        format.html { redirect_to(@player) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        flash[:notice] = 'Player was successfully updated.'
        format.html { redirect_to(@player) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end

