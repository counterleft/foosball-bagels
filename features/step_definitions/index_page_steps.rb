Given "a logged-in user" do
  pending("need initial data")
end


When "the user visits the index page" do
  # TODO initial data
  @report = Statistics.index_report
end

Then "the current bagel owner should be displayed" do
  expect(@report.current_bagel_owner.name).to eq("Brian")
end

