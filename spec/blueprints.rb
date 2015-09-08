require "machinist/active_record"
require "faker"

Player.blueprint do
  name { Faker::Name.name }
  plus_minus { 0 }
end

CONTRIBUTOR_PLUS_MINUS = -10000

Player.blueprint(:contributor) do
  name { Faker::Name.name }
  plus_minus { CONTRIBUTOR_PLUS_MINUS }
end

PREVENTER_PLUS_MINUS = 20000

Player.blueprint(:preventer) do
  name { Faker::Name.name }
  plus_minus { PREVENTER_PLUS_MINUS }
end

Bagel.blueprint do
  baked_on { Date.today }
  owner { Player.make! }
  teammate { Player.make! }
  opponent_1 { Player.make! }
  opponent_2 { Player.make! }
end
