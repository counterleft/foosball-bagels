class BagelsController < ApplicationController

  # GET /bagels
  # GET /bagels.xml
  def index
    @bagels = Bagel.find(:all, :limit => 5, :order => 'baked_on desc, created_at desc',
                         :include => [ :owner, :teammate, :opponent_1, :opponent_2 ])
    @current_owner = Bagel.current_owner
    @contributors = Player.bagel_contributors
    @preventers = Player.bagel_preventers
    @special_wager = Player.special_wager_players

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @bagels }
    end
  end

  # GET /bagels/1
  # GET /bagels/1.xml
  def show
    @bagel = Bagel.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @bagel }
    end
  end

  # GET /bagels/new
  # GET /bagels/new.xml
  def new
    @bagel = Bagel.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @bagel }
    end
  end

# there is no update bagel feature 
#  # GET /bagels/1/edit
#  def edit
#    @bagel = Bagel.find(params[:id])
#  end

  # POST /bagels
  # POST /bagels.xml
  def create
    @bagel = Bagel.new(params[:bagel])

    respond_to do |format|
      if @bagel.save
        flash[:notice] = 'Bagel was successfully created.'
        format.html { redirect_to(@bagel) }
        format.xml  { render :xml => @bagel, :status => :created, :location => @bagel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bagel.errors, :status => :unprocessable_entity }
      end
    end
  end

# there is no update bagel feature 
#  # PUT /bagels/1
#  # PUT /bagels/1.xml
#  def update
#    @bagel = Bagel.find(params[:id])
#
#    respond_to do |format|
#      if @bagel.update_attributes(params[:bagel])
#        flash[:notice] = 'Bagel was successfully updated.'
#        format.html { redirect_to(@bagel) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @bagel.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

# there is no delete bagel feature
# # DELETE /bagels/1
#  # DELETE /bagels/1.xml
#  def destroy
#    @bagel = Bagel.find(params[:id])
#    @bagel.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(bagels_url) }
#      format.xml  { head :ok }
#    end
# end
end

