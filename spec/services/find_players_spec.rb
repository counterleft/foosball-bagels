require "spec_helper"
require "ostruct"

describe FindPlayers do
  let(:player1) { Player.make }
  let(:player2) { Player.make }
  let(:player3) { Player.make }
  let(:player4) { Player.make }
  let(:subject) { FindPlayers }

  it "finds players for a given bagel" do
    bagel = OpenStruct.new(
      owner_id: player1.id,
      teammate_id: player2.id,
      opponent_1_id: player3.id,
      opponent_2_id: player4.id
    )

    actual = subject.get_players_for(bagel)
    expect(actual.bagel_owner).to eq(player1)
    expect(actual.bagel_teammate).to eq(player2)
    expect(actual.winning_offensive_player).to eq(player3)
    expect(actual.winning_defensive_player).to eq(player4)
  end
end
