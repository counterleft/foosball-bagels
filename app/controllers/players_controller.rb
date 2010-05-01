class PlayersController < ApplicationController

  caches_page :index

  # GET /players
  # GET /players.xml
  def index
    @players = Player.all :order => "plus_minus desc, name asc"

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    player_id = params[:id]
    @player = Player.find(player_id)
    @bagels = Bagel.paginate :page => params[:page],
                   :conditions => ["owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
                   player_id, player_id, player_id, player_id],
                   :order => 'baked_on desc, created_at desc'
    
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @player }
    end
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Player was successfully created.'
        format.html { redirect_to(@player) }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # For auto completing player names in forms
  def names
  	@players = Player.find(:all, :limit => 15, :order => 'name ASC', :conditions => [ 'lower(name) like lower(?)', "%#{params[:name]}%" ])
  	render :inline => "<%= auto_complete_result(@players, 'name') %>"
  end

#  # GET /players/1/edit
#  def edit
#    @player = Player.find(params[:id])
#  end
#
#  # PUT /players/1
#  # PUT /players/1.xml
#  def update
#    @player = Player.find(params[:id])
#
#    respond_to do |format|
#      if @player.update_attributes(params[:player])
#        flash[:notice] = 'Player was successfully updated.'
#        format.html { redirect_to(@player) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /players/1
#  # DELETE /players/1.xml
#  def destroy
#    @player = Player.find(params[:id])
#    @player.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(players_url) }
#      format.xml  { head :ok }
#    end
#  end
end

