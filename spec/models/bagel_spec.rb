require 'spec_helper'

describe Bagel do
  let(:old_bagel) { Bagel.make(:baked_on => '2009/01/02') } 
  let(:new_bagel) { Bagel.make(:baked_on => '2013/01/02') } 

  it "should sort bagels by baked_on desc" do
    expect([old_bagel, new_bagel].sort).to eq([new_bagel, old_bagel])
  end
end

