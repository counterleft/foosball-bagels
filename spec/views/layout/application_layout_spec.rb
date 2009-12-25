require "spec_helper"

describe "application layout", :type => :view do
  before do
    render '/layouts/application'
  end

  it "should point to bagels index page for 'Bagels' nav link " do
    response.should have_tag('#navigation') do
      with_tag('a', 'Bagels') do
        with_tag("[href=?]", bagels_path)
      end
    end
  end

  it "should point to players index page for 'Players' nav link " do
    response.should have_tag('#navigation') do
      with_tag('a', 'Players') do
        with_tag("[href=?]", players_path)
      end
    end
  end
end