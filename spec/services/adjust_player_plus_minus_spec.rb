require "spec_helper"

describe AdjustPlayerPlusMinus do
  let(:player1) { Player.make }
  let(:player2) { Player.make }
  let(:player3) { Player.make }
  let(:player4) { Player.make }

  it "updates players plus-minus when bagel is given" do
    players = PlayersForBagel.new(player1, player2, player3, player4)

    expect { AdjustPlayerPlusMinus.adjust(players) }.to change {
      Player.find_by_id(player1.id).plus_minus
    }.by(-1)

    expect { AdjustPlayerPlusMinus.adjust(players) }.to change {
      Player.find_by_id(player2.id).plus_minus
    }.by(-1)

    expect { AdjustPlayerPlusMinus.adjust(players) }.to change {
      Player.find_by_id(player3.id).plus_minus
    }.by(1)

    expect { AdjustPlayerPlusMinus.adjust(players) }.to change {
      Player.find_by_id(player4.id).plus_minus
    }.by(1)
  end
end
