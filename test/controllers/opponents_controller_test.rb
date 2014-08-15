require 'test_helper'

class OpponentsControllerTest < ActionController::TestCase
  setup do
    @opponent = opponents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opponents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opponent" do
    assert_difference('Opponent.count') do
      post :create, opponent: { conferenceopponent: @opponent.conferenceopponent, homevenue: @opponent.homevenue, mascot: @opponent.mascot, name: @opponent.name }
    end

    assert_redirected_to opponent_path(assigns(:opponent))
  end

  test "should show opponent" do
    get :show, id: @opponent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opponent
    assert_response :success
  end

  test "should update opponent" do
    patch :update, id: @opponent, opponent: { conferenceopponent: @opponent.conferenceopponent, homevenue: @opponent.homevenue, mascot: @opponent.mascot, name: @opponent.name }
    assert_redirected_to opponent_path(assigns(:opponent))
  end

  test "should destroy opponent" do
    assert_difference('Opponent.count', -1) do
      delete :destroy, id: @opponent
    end

    assert_redirected_to opponents_path
  end
end
