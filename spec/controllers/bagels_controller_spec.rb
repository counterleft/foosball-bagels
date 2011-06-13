require 'spec_helper'

describe BagelsController, "when getting index page" do
  before(:each) do
    session[:signed_in] = true
  end

  it "should get all bagels" do
    Bagel.should_receive(:paginate).and_return [Bagel.make_unsaved, Bagel.make_unsaved]

    get :index
    actual = assigns[:bagels]
    actual.size.should == 2
  end
end

describe BagelsController, "when getting home page" do
  before do
    session[:signed_in] = true
    Player.should_receive(:bagel_preventers).and_return([])
    Player.should_receive(:bagel_contributors).and_return([])
  end

  it "should get five latest bagels sorted by baked_on desc, created_on desc, id desc" do
    3.times { Bagel.make }

    get :home
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

    get :home
    assigns[:bagels].size.should == 5
  end

  it "should get the current bagel owner" do
    bagel = Bagel.make
    Bagel.should_receive(:find).and_return([bagel])

    get :home
    assigns[:current_owner].should == bagel.owner
  end

  it "should get bagel preventers" do
    Player.make

    get :home
    assigns[:preventers].should_not be_nil
  end

  it "should get bagel contributors" do
    Player.make

    get :home
    assigns[:contributors].should_not be_nil
  end
end

describe BagelsController do
  before(:each) do
    session[:signed_in] = true
  end

  it "should have new bagel on new page" do
    get :new
    assigns[:bagel].should_not be_nil
    response.should be_success
  end

  it "should create bagel with post params" do
    bagel = mock_model(Bagel)
    Bagel.should_receive(:new).with(bagel.to_param).and_return(bagel)
    bagel.should_receive(:save).and_return(true)

    post :create, :bagel => bagel.to_param
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
