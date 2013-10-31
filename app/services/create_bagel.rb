require 'ostruct'

class CreateBagel
  def self.save(baked_on, owner_id, teammate_id, winning_offensive_player_id, winning_defensive_player_id)
    bagel = Bagel.new(baked_on: baked_on,
                      owner_id: owner_id,
                      teammate_id: teammate_id,
                      opponent_1_id: winning_offensive_player_id,
                      opponent_2_id: winning_defensive_player_id)

    bagel.save

    players = FindPlayers.get_players_for(bagel)
    AdjustPlayerPlusMinus.adjust(players) if bagel.persisted?

    bagel
  end
end
