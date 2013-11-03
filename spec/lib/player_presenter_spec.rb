require "spec_helper"

describe PlayerPresenter do
  describe "#name" do
    before(:all) do
      FakePlayer = Struct.new(:name, :surname)
    end

    it "shortens first and surname into first name and first initial of surname" do
      bob = FakePlayer.new("Bob", "Fields")
      subject = PlayerPresenter.new(bob)
      expect(subject.name).to eq("Bob F.")
    end

    it "is OK for players to not have surnames" do
      bob = FakePlayer.new("Bob", nil)
      subject = PlayerPresenter.new(bob)
      expect(subject.name).to eq("Bob")
    end
  end

  describe ".new_from" do
    it "allows just the player as presentee" do
      subject = PlayerPresenter.new_from(Player.new(name: "Bob"))
      expect(subject.name).to eq("Bob")
      expect(subject.bagels).to eq([])
    end

    it "accepts all optional parameters" do
      subject = PlayerPresenter.new_from(Player.new(name: "Bob"), nil, nil, nil, nil, nil, [Bagel.new])
      expect(subject.bagels).to have(1).items
    end
  end
end

