require 'ostruct'

class CreateBagel
  def self.save(baked_on, owner_name, teammate_name, winning_offensive_player_name, winning_defensive_player_name)
    bagel = Bagel.new(baked_on: baked_on)

    players = FindPlayers.get_players_by_name(
      OpenStruct.new(
        owner_name: owner_name,
        teammate_name: teammate_name,
        winning_offensive_player_name: winning_offensive_player_name,
        winning_defensive_player_name: winning_defensive_player_name
      )
    )

    bagel.players = players
    bagel.save

    AdjustPlayerPlusMinus.adjust(players) if bagel.persisted?

    bagel
  end
end
