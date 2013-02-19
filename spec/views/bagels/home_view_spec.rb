require "spec_helper"

describe "bagels/home.html.haml" do
  before do
    assign(:current_owner, Player.make_unsaved)
    assign(:contributors, [ Player.make_unsaved, Player.make_unsaved ])
    assign(:preventers, [ Player.make_unsaved, Player.make_unsaved ])
    @bagels =  [ Bagel.make_unsaved, Bagel.make_unsaved ]
    assign(:bagels, @bagels)
    assign(:special_wager, { Player.make_unsaved => 1, Player.make_unsaved => 2 })
  end

  it "should degrade well if no bagel owner" do
    assign(:current_owner, nil)
    render
    rendered.should have_selector("#quote", :content => "No one owns the bagel, start playing better!")
  end

  it "should display bagel owner link" do
    render
    rendered.should have_selector("#main-box") do |n|
      n.should have_selector("#quote") do |n1|
        n1.should have_selector("a")
      end
    end
  end

  it "should display bagel baked_on date as yyyy-mm-dd" do
    render
    rendered.should have_selector("table#recent_bagels//tr/td", :content => @bagels[0].baked_on.strftime("%Y-%m-%d"))
    rendered.should have_selector("table#recent_bagels//tr/td", :content => @bagels[1].baked_on.strftime("%Y-%m-%d"))
  end
end
