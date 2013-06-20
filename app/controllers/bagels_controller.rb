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
    end
  end

  def show
    @bagel = Bagel.with_players.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @bagel = Bagel.new

    respond_to do |format|
      format.html { render :new, locals: { player_names: player_names } }
    end
  end

  def create
    @bagel = CreateBagel.save(
      params[:bagel][:baked_on],
      params[:bagel][:owner][:name],
      params[:bagel][:teammate][:name],
      params[:bagel][:opponent_1][:name],
      params[:bagel][:opponent_2][:name],
    )

    respond_to do |format|
      if @bagel.persisted?
        flash[:notice] = 'We got ourselves a new bagel!'
        format.html { redirect_to(@bagel) }
      else
        format.html { render action: "new", locals: { player_names: player_names } }
      end
    end
  end

  private

  def player_names
    players = Player.where("active = true")
    player_names = players.inject([]) { |list, e| list << e.name }.to_json
    player_names
  end
end
