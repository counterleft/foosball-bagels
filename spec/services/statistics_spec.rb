require "spec_helper"

describe Statistics do
  it ".index_page_report" do
    player = Player.make
    Bagel.make(baked_on: '3000/12/12', owner: player)

    actual = Statistics.index_report
    expect(actual.current_bagel_owner).to eq(player)
  end
end
