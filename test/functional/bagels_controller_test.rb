require 'test_helper'

class BagelsControllerTest < ActionController::TestCase
  test "bagels nav link should point to bagels index" do
    get :index
    assert_select "#navigation" do
      assert_select "a", { :text => "Bagels" } do
        assert_select "[href=?]", bagels_path
      end
    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bagels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bagel" do
    assert_difference('Bagel.count') do
      post :create, :bagel => { :baked_on => '2009/01/02',
                                :owner_name => players(:four).name,
                                :opponent_1_name => players(:one).name,
  	                            :opponent_2_name => players(:two).name,
  	                            :teammate_name => players(:three).name  }
    end

    assert_redirected_to bagel_path(assigns(:bagel))
  end

  test "should show bagel" do
    get :show, :id => bagels(:one).to_param
    assert_response :success
  end

# there is no edit bagel page 
#  test "should get edit" do
#    get :edit, :id => bagels(:one).to_param
#    assert_response :success
#  end

# there is no update-bagel feature 
#  test "should update bagel" do
#    put :update, :id => bagels(:one).to_param,
#        :bagel => { :baked_on => '2009/01/02',
#                    :owner_name => players(:four).name,
#                    :opponent_1_name => players(:one).name,
#                    :opponent_2_name => players(:two).name,
#                    :teammate_name => players(:three).name  }
#    assert_redirected_to bagel_path(assigns(:bagel))
#  end

# delete bagel feature not needed
#  test "should destroy bagel" do
#    assert_difference('Bagel.count', -1) do
#      delete :destroy, :id => bagels(:one).to_param
#    end
#
#    assert_redirected_to bagels_path
#  end

  test "current owner is correct" do
    get :index
    assert_equal assigns(:current_owner), players(:bill), "current owner is not correct!"
  end

  test "should show max of 5 bagels on front page" do
    get :index
    assert assigns(:bagels).size <= 5
  end

  test "bagels on front page sorted by baked on date desc" do
    get :index
    recent_bagels = assigns(:bagels)
    desc_bagels = recent_bagels.sort
    assert_equal recent_bagels, desc_bagels
  end

  test "bagel contributors is correct" do
    get :index
    contributors = [ players(:contributor1), players(:contributor2) ]
    assert_equal contributors[0], assigns(:contributors)[0]
    assert_equal contributors[1], assigns(:contributors)[1]
  end

  test "bagel preventers is correct" do
    get :index
    preventers = [ players(:preventer1), players(:preventer2) ]
    assert_equal preventers[0], assigns(:preventers)[0]
    assert_equal preventers[1], assigns(:preventers)[1]
  end
end

