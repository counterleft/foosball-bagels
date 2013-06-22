Given "a logged-in user" do
  sign_in
end

When "the user visits the home page" do
  visit("/")
end

Then "the current bagel owner should be displayed" do
  within("#bagel-owner") do
    expect(page).to have_content("Brian")
  end

  within("#best-team") do
    expect(page).to have_content("Emre")
    expect(page).to have_content("Nathan")
  end
end

Then "the player rankings are shown" do
  within("#player-rankings") do
    expect(page).to have_xpath("table/tbody/tr[1]/td[1]/a[. = 'Emre']")
  end
end

Then(/^the section "(.*?)" should include "(.*?)"$/) do |div, content|
  within(div) do
    expect(page).to have_content(content)
  end
end

