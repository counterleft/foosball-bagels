require "spec_helper"

describe "bagels home page" do
  before do
    assigns[:current_owner] = Player.make_unsaved
    assigns[:contributors] = [ Player.make_unsaved, Player.make_unsaved ]
    assigns[:preventers] = [ Player.make_unsaved, Player.make_unsaved ]
    assigns[:bagels] = [ Bagel.make_unsaved, Bagel.make_unsaved ]
    assigns[:special_wager] = { Player.make_unsaved => 1, Player.make_unsaved => 2 }
  end

  it "should have special wagers" do
    render '/bagels/home'
    response.should have_tag('#special_wager')
  end

  it "should degrade well if no bagel owner" do
    assigns[:current_owner] = nil
    render '/bagels/home'
    response.should have_tag('#main-box') do
      with_tag('#quote', 'No one owns the bagel, start playing better!')
    end
  end

  it "should display bagel owner link" do
    render '/bagels/home'
    response.should have_tag('#main-box') do
      with_tag('#quote') do
        with_tag('a')
      end
    end
  end

  it "should display bagel baked_on date as yyyy-mm-dd" do
    render '/bagels/home'
    response.should have_tag('table#recent_bagels') do
      with_tag('tr') do
        with_tag('td', assigns[:bagels][0].baked_on.strftime("%Y-%m-%d"))
        with_tag('td', assigns[:bagels][1].baked_on.strftime("%Y-%m-%d"))
      end
    end
  end
end