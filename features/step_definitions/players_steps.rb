When(/^the user visits the players page$/) do
  visit(players_path)
end

Then(/^the user is shown a list of players$/) do
  expect(page).to have_css("#players")
end
