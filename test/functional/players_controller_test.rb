require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, :player => { :name => 'Fooo Bizz' }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, :id => players(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => players(:one).to_param
    assert_response :success
  end

  test "should update player" do
    put :update, :id => players(:one).to_param, :player => { }
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, :id => players(:one).to_param
    end

    assert_redirected_to players_path
  end

  test "brian should have correct bagel plus-minus" do
    expected_plus_minus = players(:brian).plus_minus
    get :show, :id => players(:brian).to_param
    bagel_plus_minus = players(:brian).plus_minus
    assert_equal expected_plus_minus, bagel_plus_minus
  end
end

