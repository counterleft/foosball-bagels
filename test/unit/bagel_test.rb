require 'test_helper'

class BagelTest < ActiveSupport::TestCase
  test "opponent_2 plus-minus increases by one after receiving a bagel" do
    opponent_2 = players(:four)
    assert_difference('Player.find_by_name(opponent_2.name).plus_minus') do
      bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:one).name,
  	                  :opponent_1_name => players(:two).name,
  	                  :opponent_2_name => opponent_2.name,
  	                  :teammate_name => players(:three).name)
      bagel.save
    end
  end

  test "opponent_1 plus-minus increases by one after receiving a bagel" do
    opponent_1 = players(:four)
    assert_difference('Player.find_by_name(opponent_1.name).plus_minus') do
      bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:one).name,
  	                  :opponent_1_name => opponent_1.name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
      bagel.save
    end
  end
  
  test "teammate plus-minus decreases by one after receiving a bagel" do
    teammate = players(:four)
    assert_difference('Player.find_by_name(teammate.name).plus_minus', -1) do
      bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:one).name,
  	                  :opponent_1_name => players(:three).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => teammate.name)
      bagel.save
    end
  end

  test "owner plus-minus decreases by one after receiving a bagel" do
    owner = players(:four)
    assert_difference('Player.find_by_name(owner.name).plus_minus', -1) do
      bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => owner.name,
  	                  :opponent_1_name => players(:one).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
      bagel.save
    end
  end

  test "must have owner on save" do
  	bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :opponent_1_name => players(:one).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
  	assert !bagel.save
  end

  test "must have teammate on save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
                      :owner_name => players(:four).name,
  	                  :opponent_1_name => players(:one).name,
  	                  :opponent_2_name => players(:two).name)
  	assert !bagel.save
  end

  test "must have offensive opponent on save" do
  	bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:four).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
  	assert !bagel.save
  end

  test "must have defensive opponent on save" do
  	bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:four).name,
  	                  :opponent_1_name => players(:one).name,
  	                  :teammate_name => players(:three).name)
  	assert !bagel.save
  end

  test "must have a bake date on save" do
    bagel = Bagel.new(:owner_name => players(:four).name,
  	                  :opponent_1_name => players(:one).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
  	assert !bagel.save
  end

  test "all players involved in baking must be distinct from eachother" do
    bagel = Bagel.new(:baked_on => '2009/01/02')
    bagel.owner_name = players(:one).name
    bagel.teammate_name = players(:two).name
    bagel.opponent_1_name = players(:three).name
    bagel.opponent_2_name = bagel.opponent_1_name
    assert !bagel.save
  end

  test "good bagel save" do
    bagel = Bagel.new(:baked_on => '2009/01/02',
  	                  :owner_name => players(:four).name,
  	                  :opponent_1_name => players(:one).name,
  	                  :opponent_2_name => players(:two).name,
  	                  :teammate_name => players(:three).name)
  	assert bagel.save
  end

  test "bagel sorts by baked_on date" do
  	more_recent_bagel = Bagel.new(:baked_on => '2009/01/02')
    less_recent_bagel = Bagel.new(:baked_on => '2008/02/03')

    sorted_bagels = [less_recent_bagel, more_recent_bagel].sort
    assert_equal more_recent_bagel, sorted_bagels[0]
    assert_equal less_recent_bagel, sorted_bagels[1]
  end
end

