require 'test_helper'

class SugsControllerTest < ActionController::TestCase
  setup do
    @sug = sugs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sugs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sug" do
    assert_difference('Sug.count') do
      post :create, sug: { active: @sug.active, description: @sug.description, name: @sug.name, sugurl: @sug.sugurl }
    end

    assert_redirected_to sug_path(assigns(:sug))
  end

  test "should show sug" do
    get :show, id: @sug
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sug
    assert_response :success
  end

  test "should update sug" do
    patch :update, id: @sug, sug: { active: @sug.active, description: @sug.description, name: @sug.name, sugurl: @sug.sugurl }
    assert_redirected_to sug_path(assigns(:sug))
  end

  test "should destroy sug" do
    assert_difference('Sug.count', -1) do
      delete :destroy, id: @sug
    end

    assert_redirected_to sugs_path
  end
end
