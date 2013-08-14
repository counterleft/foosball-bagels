require "spec_helper"

describe CurrentBagelOwner do
  it "returns nil when no bagels in the system" do
    Bagel.any_instance.stub(:fetch).and_return(nil)
    expect(CurrentBagelOwner.fetch).to eq(nil)
  end

  it "returns current bagel owner" do
    player = Player.make
    Bagel.make(baked_on: '3000/12/31', owner: player)
    expect(CurrentBagelOwner.fetch).to eq(player)
  end
end
