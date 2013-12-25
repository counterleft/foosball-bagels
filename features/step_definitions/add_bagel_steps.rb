When "the user visits the add-bagel page" do
  visit(new_bagel_path)
end

And "adds valid bagel info" do
  within("#new_bagel") do
    find("#bagel_owner_name").native.send_keys("Brian", :Tab)
    find("#bagel_teammate_name").native.send_keys("Greg", :Tab)
    find("#bagel_opponent_1_name").native.send_keys("Nathan", :Tab)
    find("#bagel_opponent_2_name").native.send_keys("Emre", :Tab)
  end
end

And "clicks Add Bagel" do
  within("#new_bagel") do
    click_button("Add New Bagel")
  end
end

Then "a new bagel should be added" do
  expect(page).to have_content("We got ourselves a new bagel!")

  within("#bagels") do
    expect(page).to have_xpath("table/tbody/tr[1]/td[2][. = '#{@brian.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[3][. = '#{@greg.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[4][. = '#{@nathan.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[5][. = '#{@emre.name}']")
  end
end
