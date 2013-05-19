class CreateBagel
  attr_reader :baked_on, :owner_name, :teammate_name, :winning_offensive_player_name, :winning_defensive_player_name

  def initialize(baked_on, owner_name, teammate_name, winning_offensive_player_name, winning_defensive_player_name)
    @baked_on = baked_on
    @owner_name = owner_name
    @teammate_name = teammate_name
    @winning_offensive_player_name = winning_offensive_player_name
    @winning_defensive_player_name = winning_defensive_player_name
  end

  def save
    bagel = Bagel.new(baked_on: baked_on)
    players = FindPlayers.get_players_by_name(self)
    bagel.players = players

    bagel.save

    AdjustPlayerPlusMinus.adjust(players) if bagel.persisted?

    bagel
  end
end
