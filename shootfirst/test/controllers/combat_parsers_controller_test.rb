require 'test_helper'

class CombatParsersControllerTest < ActionController::TestCase
  setup do
    @combat_parser = combat_parsers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:combat_parsers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create combat_parser" do
    assert_difference('CombatParser.count') do
      post :create, combat_parser: { log: @combat_parser.log }
    end

    assert_redirected_to combat_parser_path(assigns(:combat_parser))
  end

  test "should show combat_parser" do
    get :show, id: @combat_parser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @combat_parser
    assert_response :success
  end

  test "should update combat_parser" do
    patch :update, id: @combat_parser, combat_parser: { log: @combat_parser.log }
    assert_redirected_to combat_parser_path(assigns(:combat_parser))
  end

  test "should destroy combat_parser" do
    assert_difference('CombatParser.count', -1) do
      delete :destroy, id: @combat_parser
    end

    assert_redirected_to combat_parsers_path
  end
end
