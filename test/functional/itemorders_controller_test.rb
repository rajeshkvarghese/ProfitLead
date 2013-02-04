require 'test_helper'

class ItemordersControllerTest < ActionController::TestCase
  setup do
    @itemorder = itemorders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:itemorders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create itemorder" do
    assert_difference('Itemorder.count') do
      post :create, itemorder: { name: @itemorder.name, phone: @itemorder.phone, saluation: @itemorder.saluation }
    end

    assert_redirected_to itemorder_path(assigns(:itemorder))
  end

  test "should show itemorder" do
    get :show, id: @itemorder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @itemorder
    assert_response :success
  end

  test "should update itemorder" do
    put :update, id: @itemorder, itemorder: { name: @itemorder.name, phone: @itemorder.phone, saluation: @itemorder.saluation }
    assert_redirected_to itemorder_path(assigns(:itemorder))
  end

  test "should destroy itemorder" do
    assert_difference('Itemorder.count', -1) do
      delete :destroy, id: @itemorder
    end

    assert_redirected_to itemorders_path
  end
end
