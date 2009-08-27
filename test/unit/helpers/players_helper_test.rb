require 'test_helper'

class PlayersHelperTest < ActionView::TestCase
  test "should return neutral class for zero plus minus" do
    plus_minus = 0
    plus_minus_markup = PlayersHelper.colored_plus_minus plus_minus
    assert_equal %(<span class="neutral">#{plus_minus}</span>), plus_minus_markup
  end

  test "should return negative class for negative plus minus" do
    plus_minus = -1
    plus_minus_markup = PlayersHelper.colored_plus_minus plus_minus
    assert_equal %(<span class="negative">#{plus_minus}</span>), plus_minus_markup
  end

  test "should return positive class for positive plus minus" do
    plus_minus = 1
    plus_minus_markup = PlayersHelper.colored_plus_minus plus_minus
    assert_equal %(<span class="positive">#{plus_minus}</span>), plus_minus_markup
  end
end
