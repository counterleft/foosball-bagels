require "spec_helper"

describe "players show page" do

  it "should should have back link inside content div" do
    player = Player.make_unsaved
    assigns[:player] = player
    render 'players/show'
    response.should have_tag('#content') do
      with_tag('a', 'Back')
    end
  end
end