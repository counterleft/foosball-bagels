require 'spec_helper'

describe Player do
  before(:each) do
    @valid_attributes = {
      :name => "Ben"
    }

    @new_player = Player.new
  end

  it "should create a new player given valid attributes" do
    Player.create!(@valid_attributes)
  end

  it "should save players as active by default" do
    @new_player.active?.should == true
  end

  it "should have capitalized name" do
    Player.make(:name => 'ben').name.should == 'Ben'
    Player.make(:name => 'foo bar').name.should == 'Foo Bar'
  end

  it "should increment plus minus only by one" do
    lambda {
      @new_player.incr_plus_minus
    }.should change(@new_player, :plus_minus).by(1)
  end

  it "should decrement plus minus by one" do
    lambda {
      @new_player.decr_plus_minus
    }.should change(@new_player, :plus_minus).by(-1)
  end

  it "should not save player without name" do
    expect(@new_player.save).to be(false)
  end

  it "should have default plus minus of zero" do
    @new_player.plus_minus.should == 0
  end

  it "test failure" do
    fail "make sure ci fails when it should"
  end
end
