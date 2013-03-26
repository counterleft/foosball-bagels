describe "TeamRank" do
  Player = Struct.new(:name, :id)
  Bagel = Struct.new(:owner, :teammate, :opponent_1, :opponent_2)

  let(:alice) { Player.new("alice", 1) }
  let(:bob) { Player.new("bob", 2) }
  let(:sally) { Player.new("sally", 3) }
  let(:fred) { Player.new("fred", 4) }

  let(:bagels) {
    [
      Bagel.new(sally, fred, alice, bob),
      Bagel.new(sally, fred, alice, bob),
      Bagel.new(bob, alice, fred, sally),
    ]
  }

  it "ranks teams by their combined plus-minus in descending order" do
    teams = TeamRank.by_plus_minus(bagels)
    expect(teams).to_not be_empty
    expect(teams).to eq [Team.new(alice, bob), Team.new(fred, sally)]
  end

  it "returns an empty list when no teams have played" do
    expect(TeamRank.by_plus_minus([])).to be_empty
  end
end
