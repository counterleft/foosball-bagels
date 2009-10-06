require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should decrement plus minus only by one" do
    assert_difference('players(:one).plus_minus', -1) do
      players(:one).decr_plus_minus
    end
  end

  test "should increment plus minus only by one" do
    assert_difference('players(:one).plus_minus') do
      players(:one).incr_plus_minus
    end
  end

  test "should not save player without name" do
    player = Player.new
    assert !player.save
  end

  test "should not save player with non-unique name" do
    player = Player.new(:name => players(:one).name)
    assert !player.save
  end

  test "name should be capitalized" do
    player = Player.new(:name => 'foo bar')
    assert_equal 'Foo Bar', player.name

    player = Player.new(:name => 'albert')
    assert_equal 'Albert', player.name
  end

  test "good player save" do
    player = Player.new(:name => 'Ben')
    assert player.save
  end

  test "find correct bagel contributors" do
    actual_contributors = Player.bagel_contributors
    expected_contributors = [ players(:contributor1), players(:contributor2) ]
    assert_equal expected_contributors[0], actual_contributors[0]
    assert_equal expected_contributors[1], actual_contributors[1]
  end

  test "find correct bagel preventers" do
    actual_preventers = Player.bagel_preventers
    expected_preventers = [ players(:preventer1), players(:preventer2) ]
    assert_equal expected_preventers[0], actual_preventers[0]
    assert_equal expected_preventers[1], actual_preventers[1]
  end
end

