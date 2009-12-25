require 'spec_helper'

describe BagelsController, "when getting index page" do
  it "should get five latest bagels sorted by baked_on desc, created_on desc, id desc" do
    3.times { Bagel.make }
    Player.should_receive(:special_wager_players).and_return({})
    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:bagel_contributors).and_return([])

    get :index
    actual = assigns[:bagels]
    actual.should_not be_nil
    actual.empty?.should be_false
    actual.size.should == 3

    actual[0].baked_on > actual[1].baked_on
    actual[1].baked_on > actual[2].baked_on

    actual[0].created_at > actual[1].created_at
    actual[1].created_at > actual[2].created_at

    actual[0].id > actual[1].id
    actual[1].id > actual[2].id
  end

  it "should get 5 bagels max" do
    6.times { Bagel.make }

    Player.should_receive(:special_wager_players).and_return({})
    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:bagel_contributors).and_return([])

    get :index
    assigns[:bagels].size.should == 5
  end

  it "should get the current bagel owner" do
    bagel = Bagel.make
    Bagel.should_receive(:find).and_return([bagel])

    Player.should_receive(:special_wager_players).and_return({})
    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:bagel_contributors).and_return([])
    
    get :index
    assigns[:current_owner].should == bagel.owner
  end

  it "should get bagel preventers" do
    Player.make
    Player.should_receive(:bagel_contributors).and_return([])    
    Player.should_receive(:special_wager_players).and_return({})
    get :index
    assigns[:preventers].should_not be_nil
  end

  it "should get bagel contributors" do
    Player.make
    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:special_wager_players).and_return({})
    get :index
    assigns[:contributors].should_not be_nil
  end
end

describe BagelsController do
  it "should have new bagel on new page" do
    get :new
    assigns[:bagel].should_not be_nil
    response.should be_success
  end

  it "should create bagel with post params" do
    bagel = mock_model(Bagel)
    params = { "owner" => 1, "teammate" => 2, "opponent_1" => 3, "opponent_2" => 2 }
    Bagel.should_receive(:new).with(params).and_return(bagel)
    bagel.should_receive(:save).and_return(true)

    post :create, :bagel => params
    flash[:notice].should_not be_nil
    response.should redirect_to(bagel_path(bagel))
  end

  it "should show bagel" do
    bagel = mock_model(Bagel)
    Bagel.should_receive(:find).and_return(bagel)
    get :show, :id => bagel.id
    assigns[:bagel].should == bagel
  end
end

describe BagelsController, "when getting special wagers" do
  it "should get wagers with bill and paul" do
    Player.make(:name => 'Bill')
    Player.make(:name => 'Paul')

    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:bagel_contributors).and_return([])

    get :index
    assigns[:special_wager].should_not be_nil
    assigns[:special_wager].size.should == 2
  end
end
