require 'spec_helper'

describe Bagel do
  before(:each) do
    @valid_attributes = {
            :baked_on => '2009/01/02',
            :owner_name => Player.make.name,
            :opponent_1_name => Player.make.name,
            :opponent_2_name => Player.make.name,
            :teammate_name => Player.make.name
    }
  end

  it "should display baked_on as yyyy-mm-dd" do
    actual = Bagel.make_unsaved
    actual.baked_on_display.should == actual.baked_on.strftime("%Y-%m-%d")
  end

  it "should create a new bagel given valid attributes" do
    Bagel.create!(@valid_attributes)
  end

  it "should sort bagels by baked_on desc" do
    older = Bagel.make(:baked_on => '2009/01/02')
    newer = Bagel.make(:baked_on => '2010/01/02')
    [older, newer].sort.should == [newer, older]
  end

  it "should save only if players involved are distinct" do
    foo_player = Player.make(:name => 'foo')
    Bagel.new(:owner => foo_player,
              :teammate => Player.make,
              :opponent_1 => Player.make,
              :opponent_2 => foo_player).save.should be_false
  end

  it "should have baked_on date on save" do
    Bagel.new(:owner => Player.make,
              :teammate => Player.make,
              :opponent_1 => Player.make,
              :opponent_2 => Player.make).save.should be_false
  end

  it "should have defensive opponent on save" do
    Bagel.new(:baked_on => '2009/10/10',
              :owner => Player.make,
              :teammate => Player.make,
              :opponent_1 => Player.make).save.should be_false
  end

  it "should have offensive opponent on save" do
    Bagel.new(:baked_on => '2009/10/10',
              :owner => Player.make,
              :teammate => Player.make,
              :opponent_2 => Player.make).save.should be_false
  end

  it "should have teammate on save" do
    Bagel.new(:baked_on => '2009/10/10',
              :owner => Player.make,
              :opponent_2 => Player.make,
              :opponent_1 => Player.make).save.should be_false
  end

  it "should have owner on save" do
    Bagel.new(:baked_on => '2009/10/10',
              :opponent_2 => Player.make,
              :teammate => Player.make,
              :opponent_1 => Player.make).save.should be_false
  end

  it "should decrease owner's plus minus by one on save" do
    owner = Player.make
    lambda {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => owner,
                :teammate => Player.make,
                :opponent_1 => Player.make,
                :opponent_2 => Player.make).save.should change(owner, :plus_minus).by(-1)
    }
  end

  it "should decrease teammate's plus minus by one on save" do
    teammate = Player.make
    lambda {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => Player.make,
                :teammate => teammate,
                :opponent_1 => Player.make,
                :opponent_2 => Player.make).save.should change(teammate, :plus_minus).by(-1)
    }
  end

  it "should increase offensive opponent's plus minus by one on save" do
    opponent_1 = Player.make
    lambda {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => Player.make,
                :teammate => Player.make,
                :opponent_1 => opponent_1,
                :opponent_2 => Player.make).save.should change(opponent_1, :plus_minus).by(1)
    }
  end

  it "should increase defensive opponent's plus minus by one on save" do
    opponent_2 = Player.make
    lambda {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => Player.make,
                :teammate => Player.make,
                :opponent_1 => Player.make,
                :opponent_2 => opponent_2).save.should change(opponent_2, :plus_minus).by(1)
    }
  end
end

describe Bagel, "when getting current owner" do
  it "should return nil when no bagels available" do
    Bagel.current_owner.should be_nil
  end

  it "should return first bagel owner if given list of desc bagels" do
    latest_bagel = Bagel.make(:baked_on => '2010/01/01')
    second_bagel = Bagel.make(:baked_on => '2009/12/23')
    actual = Bagel.current_owner([latest_bagel, second_bagel])
    actual.should == latest_bagel.owner
  end

  it "should return current bagel owner when given empty list" do
    Bagel.make
    latest_bagel = Bagel.make
    Bagel.current_owner.should == latest_bagel.owner

    Bagel.current_owner([]).should == latest_bagel.owner
  end
end