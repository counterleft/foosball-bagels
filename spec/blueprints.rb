require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name { Faker::Name.name}

Player.blueprint do
  name { Sham.name }
  plus_minus { 0 }
end

CONTRIBUTOR_PLUS_MINUS = -10000

Player.blueprint(:contributor) do
  name { Sham.name }
  plus_minus { CONTRIBUTOR_PLUS_MINUS }
end

PREVENTER_PLUS_MINUS = 20000

Player.blueprint(:preventer) do
  name { Sham.name }
  plus_minus { PREVENTER_PLUS_MINUS }
end

Bagel.blueprint do
  baked_on { Date.today }
  owner
  teammate
  opponent_1
  opponent_2
end