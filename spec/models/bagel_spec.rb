require 'spec_helper'

describe Bagel do
  let(:old_bagel) { Bagel.make(:baked_on => '2009/01/02') } 
  let(:new_bagel) { Bagel.make(:baked_on => '2013/01/02') } 

  it "should display baked_on as yyyy-mm-dd" do
    expect(old_bagel.baked_on_display).to eq(old_bagel.baked_on.strftime("%Y-%m-%d"))
  end

  it "should sort bagels by baked_on desc" do
    expect([old_bagel, new_bagel].sort).to eq([new_bagel, old_bagel])
  end
end

