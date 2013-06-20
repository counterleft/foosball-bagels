When "the user visits the add-bagel page" do
  visit(new_bagel_path)
end

And "adds valid bagel info" do
  within("#new_bagel") do
    fill_in("bagel_baked_on", with: "2013-10-15")
    fill_in("Owner's Name", with: @brian.name)
    fill_in("Teammate's Name", with: @greg.name)
    fill_in("Winning Offensive Player's Name", with: @nathan.name)
    fill_in("Winning Defensive Player's Name", with: @emre.name)
  end
end

And "clicks Add Bagel" do
  within("#new_bagel") do
    click_button("Add New Bagel")
  end
end

Then "a new bagel should be added" do
  expect(page).to have_content("We got ourselves a new bagel!")
end
