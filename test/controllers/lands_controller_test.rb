require 'test_helper'

class LandsControllerTest < ActionController::TestCase
  setup do
    @land = lands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create land" do
    assert_difference('Land.count') do
      post :create, land: { body: @land.body, external_url: @land.external_url, heading: @land.heading, neigborhood: @land.neigborhood, price: @land.price, timestamp: @land.timestamp }
    end

    assert_redirected_to land_path(assigns(:land))
  end

  test "should show land" do
    get :show, id: @land
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @land
    assert_response :success
  end

  test "should update land" do
    patch :update, id: @land, land: { body: @land.body, external_url: @land.external_url, heading: @land.heading, neigborhood: @land.neigborhood, price: @land.price, timestamp: @land.timestamp }
    assert_redirected_to land_path(assigns(:land))
  end

  test "should destroy land" do
    assert_difference('Land.count', -1) do
      delete :destroy, id: @land
    end

    assert_redirected_to lands_path
  end
end
