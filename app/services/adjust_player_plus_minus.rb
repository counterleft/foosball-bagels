class AdjustPlayerPlusMinus
  def self.adjust(players_for_bagel)
    players_for_bagel.bagel_owner.decr_plus_minus
    players_for_bagel.bagel_owner.save!

    players_for_bagel.bagel_teammate.decr_plus_minus
    players_for_bagel.bagel_teammate.save!

    players_for_bagel.winning_offensive_player.incr_plus_minus
    players_for_bagel.winning_offensive_player.save!

    players_for_bagel.winning_defensive_player.incr_plus_minus
    players_for_bagel.winning_defensive_player.save!
  end
end
