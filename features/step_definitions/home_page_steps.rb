Given "a logged-in user" do
  # TODO need to attempt login via http client
end


When "the user visits the home page" do
  visit("/")
  #@report = Statistics.index_report
end

Then "the current bagel owner should be displayed" do
  within("#bagel_owner") do
    expect(page).to have_content("Brian")
  end
  #expect(@report.current_bagel_owner.name).to eq("Brian")
end

