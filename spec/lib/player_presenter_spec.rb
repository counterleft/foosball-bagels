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

  it "presents a player's bagels" do
    bob = Player.new(name: "Bob")
    subject = PlayerPresenter.new(bob, nil, nil, nil, nil, nil, [Bagel.new(owner_id: bob.id)])
    expect(subject.bagels.size).to be(1)
    subject.bagels.each_bagel do |bagel|
      expect(bagel.owner_id).to eq(bob.id)
    end
  end

  it "has sensible defaults" do
    subject = PlayerPresenter.new(Player.new(name: "Bob"))
    expect(subject.name).to eq("Bob")
    expect(subject.plus_minus).to eq(0)
    expect(subject.bagels).to eq([])

    expect(subject.best_team_on_offense.offense_name).to be_nil
    expect(subject.best_team_on_offense.plus_minus.to_i).to eq(0)

    expect(subject.worst_team_on_offense.offense_name).to be_nil
    expect(subject.worst_team_on_offense.plus_minus.to_i).to eq(0)

    expect(subject.best_team_on_defense.offense_name).to be_nil
    expect(subject.best_team_on_defense.plus_minus.to_i).to eq(0)

    expect(subject.worst_team_on_defense.offense_name).to be_nil
    expect(subject.worst_team_on_defense.plus_minus.to_i).to eq(0)

    expect(subject.data_for_bagels_owned_chart).to be_nil
  end

end

