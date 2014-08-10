require 'test_helper'

class AthletesControllerTest < ActionController::TestCase
  setup do
    @athlete = athletes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:athletes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create athlete" do
    assert_difference('Athlete.count') do
      post :create, athlete: { active: @athlete.active, dob: @athlete.dob, email: @athlete.email, firstname: @athlete.firstname, gender: @athlete.gender, gradyear: @athlete.gradyear, height: @athlete.height, lastname: @athlete.lastname, middlename: @athlete.middlename, nickname: @athlete.nickname, twitter: @athlete.twitter, weight: @athlete.weight }
    end

    assert_redirected_to athlete_path(assigns(:athlete))
  end

  test "should show athlete" do
    get :show, id: @athlete
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @athlete
    assert_response :success
  end

  test "should update athlete" do
    patch :update, id: @athlete, athlete: { active: @athlete.active, dob: @athlete.dob, email: @athlete.email, firstname: @athlete.firstname, gender: @athlete.gender, gradyear: @athlete.gradyear, height: @athlete.height, lastname: @athlete.lastname, middlename: @athlete.middlename, nickname: @athlete.nickname, twitter: @athlete.twitter, weight: @athlete.weight }
    assert_redirected_to athlete_path(assigns(:athlete))
  end

  test "should destroy athlete" do
    assert_difference('Athlete.count', -1) do
      delete :destroy, id: @athlete
    end

    assert_redirected_to athletes_path
  end
end
