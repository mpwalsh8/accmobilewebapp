require 'test_helper'

class AthletesTeamsControllerTest < ActionController::TestCase
  setup do
    @athletes_team = athletes_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:athletes_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create athletes_team" do
    assert_difference('AthletesTeam.count') do
      post :create, athletes_team: { athlete_id: @athletes_team.athlete_id, captain: @athletes_team.captain, jerseynumber: @athletes_team.jerseynumber, position: @athletes_team.position, team_id: @athletes_team.team_id }
    end

    assert_redirected_to athletes_team_path(assigns(:athletes_team))
  end

  test "should show athletes_team" do
    get :show, id: @athletes_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @athletes_team
    assert_response :success
  end

  test "should update athletes_team" do
    patch :update, id: @athletes_team, athletes_team: { athlete_id: @athletes_team.athlete_id, captain: @athletes_team.captain, jerseynumber: @athletes_team.jerseynumber, position: @athletes_team.position, team_id: @athletes_team.team_id }
    assert_redirected_to athletes_team_path(assigns(:athletes_team))
  end

  test "should destroy athletes_team" do
    assert_difference('AthletesTeam.count', -1) do
      delete :destroy, id: @athletes_team
    end

    assert_redirected_to athletes_teams_path
  end
end
