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

  it "should sort bagels by baked_on desc" do
    expect([old_bagel, new_bagel].sort).to eq([new_bagel, old_bagel])
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

