class BagelsController < ApplicationController

  caches_page :home, :index

  before_filter :require_sign_in

  def home
    @report = Statistics.index_report

    respond_to do |format|
      format.html
    end
  end

  def index
    @bagels = Bagel.paginate :page => params[:page], :order => 'baked_on desc, created_at desc',
                             :include => [ :owner, :teammate, :opponent_1, :opponent_2 ]

    respond_to do |format|
      format.html
      format.xml { render :xml => @bagels }
      format.json { render :json => Bagel.all({:order => "baked_on desc, created_at desc"}) }
    end
  end

  def show
    @bagel = Bagel.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @bagel }
      format.json { render :json => @bagel }
    end
  end

  def new
  	players = Player.where("active = true")
    @player_names = players.inject([]) { |list, e| list << e.name }.to_json

    respond_to do |format|
      format.html # new.html.haml
    end
  end

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
end
