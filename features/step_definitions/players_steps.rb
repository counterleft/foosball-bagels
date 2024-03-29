Then(/^the user is shown a list of players$/) do
  expect(page).to have_css("#players")
end

When(/^visits a player's show page$/) do
  click_link("emre")
end

Then(/^the user is shown that player's show page$/) do
  expect(page).to have_content("Emre")
  expect(page).to have_css("#plus-minus")
  expect(page).to have_css("#ownership-chart")
  expect(page).to have_css("#best-offensive-teammate")
  expect(page).to have_css("#best-defensive-teammate")
  expect(page).to have_css("#worst-offensive-teammate")
  expect(page).to have_css("#worst-defensive-teammate")
  expect(page).to have_css("#bagels")
end

Then(/^pagination exists for bagels$/) do
  within("#bagels") do
    within(".pagination") do
      click_link("2")
      expect(page.html).to have_xpath("//li[@class = 'active']/span[. = '2']")
    end
  end
end

When(/^enters "(.*?)" into the (\w+) field$/) do |value, input_label|
  fill_in(input_label, with: value)
end

When(/^clicks the "(.*?)" button$/) do |button_label|
  click_button(button_label)
end

Then(/^a new player, "(.*?)" should be added$/) do |player_name|
  expect(page).to have_content("We got ourselves a new player")
  expect(page).to have_content(player_name)
end
