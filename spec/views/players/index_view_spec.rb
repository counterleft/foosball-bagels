require "spec_helper"

describe "players/index.html.haml" do
  it "should have the correct headers" do
    assign(:players, [])
    render
    
    rendered.should have_selector('#main-box/#quote', :content => "Foos Your Daddy?")
    rendered.should have_selector('#content/h2', :content => 'Plus-Minus Rankings')
  end

  it "should have list players" do
    first_player = Player.make_unsaved
    second_player = Player.make_unsaved
    assign(:players, [first_player, second_player])
    
    render
    rendered.should have_selector('ol/li', :content => "#{first_player.name} : #{first_player.plus_minus}")
    rendered.should have_selector('ol/li', :content => "#{second_player.name} : #{second_player.plus_minus}")
  end

  it "should have link to new player page" do
    assign(:players, [])
    render
    rendered.should have_selector('a', :href => new_player_path)
  end
end