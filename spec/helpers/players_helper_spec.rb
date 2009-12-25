require "spec_helper"

describe PlayersHelper do
  it "should return neutral class for zero plus minus" do
    plus_minus = 0
    PlayersHelper.colored_plus_minus(plus_minus).should == %(<span class="neutral">#{plus_minus}</span>)
  end

  it "should return positive class for positive plus minus" do
    plus_minus = 1
    PlayersHelper.colored_plus_minus(plus_minus).should == %(<span class="positive">#{plus_minus}</span>)
  end

  it "should return negative class for negative plus minus" do
    plus_minus = -1
    PlayersHelper.colored_plus_minus(plus_minus).should == %(<span class="negative">#{plus_minus}</span>)
  end
end