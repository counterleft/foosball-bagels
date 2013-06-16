describe "TeamRank" do
  PlayerStub = Struct.new(:name, :id)
  BagelStub = Struct.new(:owner, :teammate, :opponent_1, :opponent_2) do
    def missing_players?
      owner.nil? || teammate.nil? || opponent_1.nil? || opponent_2.nil?
    end
  end

  let(:alice) { PlayerStub.new("alice", 1) }
  let(:bob) { PlayerStub.new("bob", 2) }
  let(:sally) { PlayerStub.new("sally", 3) }
  let(:fred) { PlayerStub.new("fred", 4) }

  let(:bagels) {
    [
      BagelStub.new(sally, fred, alice, bob),
      BagelStub.new(sally, fred, alice, bob),
      BagelStub.new(bob, alice, fred, sally),
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
