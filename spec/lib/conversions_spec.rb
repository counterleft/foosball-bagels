require "spec_helper"

describe Conversions do
  describe ".Present" do
    it "a list of objects" do
      expect(Conversions::Present([Bagel.new])).to be_a(BagelListPresenter)
      expect(Conversions::Present([])).to be_a(NullObjects::EmptyListPresenter)
      expect(Conversions::Present([])).to be_empty
      expect(Conversions::Present([nil])).to be_a(NullObjects::EmptyListPresenter)
      expect(Conversions::Present([nil])).to be_empty
    end

    it "nil nicely" do
      expect(Conversions::Present(nil)).to be_a(NullObjects::NullObjectPresenter)
    end

    it "actual presentees nicely" do
      expect(Conversions::Present(Player.new)).to be_a(PlayerPresenter)
    end
  end
end
