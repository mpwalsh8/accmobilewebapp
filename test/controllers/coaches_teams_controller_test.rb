require 'test_helper'

class CoachesTeamsControllerTest < ActionController::TestCase
  setup do
    @coaches_team = coaches_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coaches_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coaches_team" do
    assert_difference('CoachesTeam.count') do
      post :create, coaches_team: { coach_id: @coaches_team.coach_id, headcoach: @coaches_team.headcoach, team_id: @coaches_team.team_id }
    end

    assert_redirected_to coaches_team_path(assigns(:coaches_team))
  end

  test "should show coaches_team" do
    get :show, id: @coaches_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coaches_team
    assert_response :success
  end

  test "should update coaches_team" do
    patch :update, id: @coaches_team, coaches_team: { coach_id: @coaches_team.coach_id, headcoach: @coaches_team.headcoach, team_id: @coaches_team.team_id }
    assert_redirected_to coaches_team_path(assigns(:coaches_team))
  end

  test "should destroy coaches_team" do
    assert_difference('CoachesTeam.count', -1) do
      delete :destroy, id: @coaches_team
    end

    assert_redirected_to coaches_teams_path
  end
end
