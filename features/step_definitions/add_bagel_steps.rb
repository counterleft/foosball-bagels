When "the user visits the add-bagel page" do
  visit("/bagels/new")
end

And "adds valid bagel info" do
  within("#new-bagel-form") do
    fill_in("baked_on", with: "2013-10-15")
    fill_in("Owner's Name", with: @brian.name)
    fill_in("Teammate's Name", with: @greg.name)
    fill_in("Winning Offensive Player's Name", with: @nathan.name)
    fill_in("Winning Defensive Player's Name", with: @emre.name)
  end
end

And "clicks Add Bagel" do
  pending
end

Then "a new bagel should be added" do
end

And "the page should redirect to the new bagel page" do

end

