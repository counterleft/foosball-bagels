require "spec_helper"

describe "layouts/application.html.haml", :type => :view do
  before do
    render
  end

  it "should point to bagels index page for 'Bagels' nav link " do
    rendered.should have_selector('#navigation//a', :content => "Bagels", :href => bagels_path)
  end

  it "should point to players index page for 'Players' nav link " do
    rendered.should have_selector('#navigation//a', :content => 'Players', :href => players_path)
  end
end