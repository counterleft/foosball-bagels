require "set"

class Team
  attr_reader :offense, :defense, :plus_minus

  def initialize(offense, defense)
    @offense = offense
    @defense = defense
    @plus_minus = 0
  end

  def increment_plus_minus
    @plus_minus += 1
  end

  def decrement_plus_minus
    @plus_minus -= 1
  end

  def ==(other)
    offense.id == other.offense.id && defense.id == other.defense.id
  end

  def eql?(other)
    self == other
  end

  def hash
    result = 1
    result = result * 17 + offense.id
    result = result * 31 + defense.id
    result
  end

  def <=>(other)
    other.plus_minus <=> plus_minus
  end
end

class TeamRank
  def self.by_plus_minus(bagels)
    ranked_teams = {}

    bagels.each do |bagel|
      winning_team = Team.new(bagel.opponent_1, bagel.opponent_2)
      losing_team = Team.new(bagel.teammate, bagel.owner)

      winning_team = ranked_teams.fetch(winning_team, winning_team)
      winning_team.increment_plus_minus
      ranked_teams[winning_team] = winning_team

      losing_team = ranked_teams.fetch(losing_team, losing_team)
      losing_team.decrement_plus_minus
      ranked_teams[losing_team] = losing_team
    end

    ranked_teams.values.sort!
  end
end

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
