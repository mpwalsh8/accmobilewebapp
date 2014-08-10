require 'test_helper'

class SportsVenuesControllerTest < ActionController::TestCase
  setup do
    @sports_venue = sports_venues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sports_venues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sports_venue" do
    assert_difference('SportsVenue.count') do
      post :create, sports_venue: { sport_id: @sports_venue.sport_id, venue_id: @sports_venue.venue_id }
    end

    assert_redirected_to sports_venue_path(assigns(:sports_venue))
  end

  test "should show sports_venue" do
    get :show, id: @sports_venue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sports_venue
    assert_response :success
  end

  test "should update sports_venue" do
    patch :update, id: @sports_venue, sports_venue: { sport_id: @sports_venue.sport_id, venue_id: @sports_venue.venue_id }
    assert_redirected_to sports_venue_path(assigns(:sports_venue))
  end

  test "should destroy sports_venue" do
    assert_difference('SportsVenue.count', -1) do
      delete :destroy, id: @sports_venue
    end

    assert_redirected_to sports_venues_path
  end
end
