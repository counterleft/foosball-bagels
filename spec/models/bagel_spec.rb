require 'spec_helper'

describe Bagel do
  let(:old_bagel) { Bagel.make(:baked_on => '2009/01/02') } 
  let(:new_bagel) { Bagel.make(:baked_on => '2013/01/02') } 
  let(:player1) { Player.make }
  let(:player2) { Player.make }
  let(:player3) { Player.make }
  let(:player4) { Player.make }

  it "should display baked_on as yyyy-mm-dd" do
    expect(old_bagel.baked_on_display).to eq(old_bagel.baked_on.strftime("%Y-%m-%d"))
  end

  it "should create a new bagel given valid attributes" do
    bagel = Bagel.new({
      :baked_on => '2009/01/02',
      :owner_name => player1.name,
      :opponent_1_name => player2.name,
      :opponent_2_name => player3.name,
      :teammate_name => player4.name
    })
    expect { bagel.save }.to change { Bagel.count }.by 1
  end

  it "should sort bagels by baked_on desc" do
    expect([old_bagel, new_bagel].sort).to eq([new_bagel, old_bagel])
  end

  it "should save only if players involved are distinct" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :owner => player1,
                      :teammate => player2,
                      :opponent_1 => player2,
                      :opponent_2 => player1)
    expect(bagel.save).to be_false
  end

  it "should have baked_on date on save" do
    bagel = Bagel.new(:owner => player1,
                      :teammate => player2,
                      :opponent_1 => player3,
                      :opponent_2 => player4)
    expect(bagel.save).to be_false
  end

  it "should have defensive opponent on save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :owner => player1,
                      :teammate => player2,
                      :opponent_1 => player3)
    expect(bagel.save).to be_false
  end

  it "should have offensive opponent on save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :owner => player1,
                      :teammate => player2,
                      :opponent_2 => player4)
    expect(bagel.save).to be_false
  end

  it "should have teammate on save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :owner => player1,
                      :opponent_1 => player3,
                      :opponent_2 => player4)
    expect(bagel.save).to be_false
  end

  it "should have owner on save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :teammate => player2,
                      :opponent_1 => player3,
                      :opponent_2 => player4)
    expect(bagel.save).to be_false
  end

  it "should decrease owner's plus minus by one on save" do
    expect {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => player1,
                :teammate => player2,
                :opponent_1 => player3,
                :opponent_2 => player4).save
    }.to change { player1.plus_minus }.by(-1)
  end

  it "should decrease teammate's plus minus by one on save" do
    expect {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => player1,
                :teammate => player2,
                :opponent_1 => player3,
                :opponent_2 => player4).save
    }.to change { player2.plus_minus }.by(-1)
  end

  it "should increase offensive opponent's plus minus by one on save" do
    expect {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => player1,
                :teammate => player2,
                :opponent_1 => player3,
                :opponent_2 => player4).save
    }.to change { player3.plus_minus }.by(1)
  end

  it "should increase defensive opponent's plus minus by one on save" do
    expect {
      Bagel.new(:baked_on => '2009/10/12',
                :owner => player1,
                :teammate => player2,
                :opponent_1 => player3,
                :opponent_2 => player4).save
    }.to change { player4.plus_minus }.by(1)
  end

  context "when getting current owner" do
    it "should return nil when no bagels available" do
      expect(Bagel.current_owner).to be_nil
    end

    it "should return first bagel owner if given list of desc bagels" do
      latest_bagel = Bagel.make(:baked_on => '2010/01/01')
      second_bagel = Bagel.make(:baked_on => '2009/12/23')
      expect(Bagel.current_owner([latest_bagel, second_bagel])).to eq(latest_bagel.owner)
    end

    it "should return current bagel owner when given empty list" do
      Bagel.make
      latest_bagel = Bagel.make
      expect(Bagel.current_owner).to eq(latest_bagel.owner)
      expect(Bagel.current_owner([])).to eq(latest_bagel.owner)
    end
  end
end

