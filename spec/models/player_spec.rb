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

  it "should find correct bagel contributors" do
    expected_contributor_1 = Player.make(:contributor, :name => "Bob")
    expected_contributor_2 = Player.make(:contributor, :name => "Chris")
    Player.make(:plus_minus => 1000)
    actual_contributors = Player.bagel_contributors
    actual_contributors.should == [ expected_contributor_1, expected_contributor_2 ]
  end

  it "should find correct bagel preventers" do
    expected_preventer_1 = Player.make(:preventer, :name => "Albert")
    expected_preventer_2 = Player.make(:preventer, :name => "Greg")
    Player.make
    actual_preventers = Player.bagel_preventers
    actual_preventers.should == [ expected_preventer_1, expected_preventer_2 ]
  end

  it "should have capitalized name" do
    Player.make(:name => 'ben').name.should == 'Ben'
    Player.make(:name => 'foo bar').name.should == 'Foo Bar'
  end

  it "should not save player with non-unique name" do
    name = 'Albert'
    Player.make(:name => name)
    actual = Player.new(:name => name)
    actual.save.should be_false
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
    @new_player.save.should be_false
  end

  it "should have default plus minus of zero" do
    @new_player.plus_minus.should == 0
  end
end

describe Player, "when working with the special wagers" do
  before do
    @paul = Player.make(:name => 'Paul')
    @bill = Player.make(:name => 'Bill')
  end

  it "should return paul and bill" do
    special_wager_players = Player.special_wager_players
    special_wager_players.size.should == 2
    special_wager_players.shift[0].should == @bill
    special_wager_players.shift[0].should == @paul
  end
end