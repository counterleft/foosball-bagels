require 'test_helper'

class PlayersHelperTest < ActionView::TestCase
  test "should return positive class for positive plus minus" do
    p = Player.new
    p.plus_minus = 1
    plus_minus_markup = colored_plus_minus p
    assert_equal %(<span class="positive">#{p.plus_minus}</span>), plus_minus_markup
  end

  test "should return negative class for negative plus minus" do
    p = Player.new
    p.plus_minus = -1
    plus_minus_markup = colored_plus_minus p
    assert_equal %(<span class="negative">#{p.plus_minus}</span>), plus_minus_markup
  end

  test "should return neutral class for zero plus minus" do
    p = Player.new
    p.plus_minus = 0
    plus_minus_markup = colored_plus_minus p
    assert_equal %(<span class="neutral">#{p.plus_minus}</span>), plus_minus_markup
  end
end
