require "spec_helper"

describe PlayerPresenter do
  describe "#name" do
    before(:all) do
      FakePlayer = Struct.new(:name, :surname)
    end

    it "shortens first and surname into first name and first initial of surname" do
      bob = FakePlayer.new("Bob", "Fields")
      subject = PlayerPresenter.new(bob, nil, nil, nil, nil, nil, nil)
      expect(subject.name).to eq("Bob F.")
    end

    it "is OK for players to not have surnames" do
      bob = FakePlayer.new("Bob", nil)
      subject = PlayerPresenter.new(bob, nil, nil, nil, nil, nil, nil)
      expect(subject.name).to eq("Bob")
    end
  end
end

