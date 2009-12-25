require "spec_helper"

describe "players index page" do
  it "should have the correct headers" do
    assigns[:players] = []
    render '/players/index'
    
    response.should have_tag('#main-box') do
      with_tag('#quote',  "Foos Your Daddy?")
    end

    response.should have_tag('#content') do
      with_tag('h2', 'Plus-Minus Rankings')
    end
  end

  it "should have list players" do
    first_player = Player.make_unsaved
    second_player = Player.make_unsaved

    assigns[:players] = [first_player, second_player]
    render '/players/index'
    response.should have_tag('ol') do
      with_tag('li', "#{first_player.name} : #{first_player.plus_minus}")
      with_tag('li', "#{second_player.name} : #{second_player.plus_minus}")
    end
  end

  it "should have link to new player page" do
    assigns[:players] = []
    render '/players/index'
    response.should have_tag('a') do
      with_tag("[href=?]", new_player_path)
    end
  end
end