class BagelsController < ApplicationController
  before_filter :require_sign_in

  def home
    @report = Dashboard.report

    respond_to do |format|
      format.html
    end
  end

  def index
    @active_nav_link = "bagels-nav-link"
    raw_bagels = Bagel.with_players.order_by_baked_on.paginate(page: params[:page])
    @bagels = BagelListPresenter.new(raw_bagels)

    respond_to do |format|
      format.html
    end
  end

  def new
    @active_nav_link = "new-bagel-nav-link"
    @bagel = Bagel.new

    respond_to do |format|
      format.html { render :new, locals: { player_selection: player_selection } }
    end
  end

  def create
    @bagel = CreateBagel.save(
      params[:bagel][:baked_on],
      params[:bagel][:owner][:id],
      params[:bagel][:teammate][:id],
      params[:bagel][:opponent_1][:id],
      params[:bagel][:opponent_2][:id],
    )

    respond_to do |format|
      if @bagel.persisted?
        flash[:notice] = "We got ourselves a new bagel!"
        format.html { redirect_to(bagels_path) }
      else
        format.html { render :new, locals: { player_selection: player_selection } }
      end
    end
  end

  private

  def player_selection
    FindPlayers.active_players_as_json
  end
end
