require "spec_helper"

describe "bagels index page" do
  before do
    assigns[:current_owner] = Player.make_unsaved
    assigns[:contributors] = [ Player.make_unsaved, Player.make_unsaved ]
    assigns[:preventers] = [ Player.make_unsaved, Player.make_unsaved ]
    assigns[:bagels] = [ Bagel.make_unsaved, Bagel.make_unsaved ]
    assigns[:special_wager] = { Player.make_unsaved => 1, Player.make_unsaved => 2 }
  end

  it "should have special wagers" do
    render '/bagels/index'
    response.should have_tag('#special_wager')
  end

  it "should degrade well if no bagel owner" do
    assigns[:current_owner] = nil
    render '/bagels/index'
    response.should have_tag('#main-box') do
      with_tag('#quote', 'No one owns the bagel, start playing better!')
    end
  end

  it "should display bagel owner link" do
    render '/bagels/index'
    response.should have_tag('#main-box') do
      with_tag('#quote') do
        with_tag('a')
      end
    end
  end
end