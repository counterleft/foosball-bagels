When "the user visits the add-bagel page" do
  visit(new_bagel_path)
end

And "adds valid bagel info" do
  within("#new_bagel") do
    fill_in("bagel_baked_on", with: "2013-10-15")
    select("Brian", from: "bagel[owner]")
    select("Greg", from: "bagel[teammate]")
    select("Nathan", from: "bagel[opponent_1]")
    select("Emre", from: "bagel[opponent_2]")
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
    expect(page).to have_xpath("table/tbody/tr[1]/td[1][. = '2013-10-15']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[2][. = '#{@brian.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[3][. = '#{@greg.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[4][. = '#{@nathan.name}']")
    expect(page).to have_xpath("table/tbody/tr[1]/td[5][. = '#{@emre.name}']")
  end
end
