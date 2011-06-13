require 'spec_helper'

describe PlayersController do
  before do
    session[:signed_in] = true
    @player = mock_model(Player)
  end

  it "should get success when getting new page" do
    get :new

    # suppose to return true in rspec isolation mode, but seems to break appropriately
    # when the controller is broken, so not sure if rspec docs are wrong or not
    response.should be_success
  end

  it "should create player with post params" do
    params = { "name" => 'Ben' }
    Player.should_receive(:new).with(params).and_return(@player)
    @player.should_receive(:save).and_return(true)

    post :create, :player => params
    flash[:notice].should_not be_nil
    response.should redirect_to(player_path(@player))
  end

  it "should render to new player page on create fail" do
    params = { "name" => 'Ben' }
    Player.should_receive(:new).with(params).and_return(@player)
    @player.should_receive(:save).and_return(false)

    post :create, :player => params
    response.should render_template('new')
  end
end

describe PlayersController, "when getting index page" do
  before(:each) do
    session[:signed_in] = true
  end

  it "should get players sorted by plus minus desc, name asc" do
    first_player = Player.make(:plus_minus => 10, :name => 'A')
    second_player = Player.make(:plus_minus => 10, :name => 'B')
    third_player = Player.make(:plus_minus => 20, :name => 'C')

    get :index
    assigns[:players].should_not be_nil
    assigns[:players].size.should == 3
    assigns[:players][0] == third_player
    assigns[:players][1] == first_player
    assigns[:players][2] == second_player
  end
end

describe PlayersController, "when getting show page" do
  before(:each) do
    session[:signed_in] = true
  end

  it "should show valid player" do
    id = "1"
    Player.should_receive(:find).with(id).and_return(@player)

    get :show, :id => id
    assigns[:player].should == @player
    response.should be_success
  end

  it "should get all bagels that player is involved with" do
    id = "1"
    Player.should_receive(:find).with(id).and_return(@player)

    bagels = [mock_model(Bagel), mock_model(Bagel)]
    Bagel.should_receive(:paginate).with(
            {:page => nil,
             :conditions => ["owner_id = ? or teammate_id = ? or opponent_1_id = ? or opponent_2_id = ?",
                             id, id, id, id],
             :order => 'baked_on desc, created_at desc'}).and_return(bagels)

    get :show, :id => id
    assigns[:bagels].should == bagels
  end
end