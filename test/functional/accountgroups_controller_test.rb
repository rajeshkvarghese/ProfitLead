require 'test_helper'

class AccountgroupsControllerTest < ActionController::TestCase
  setup do
    @accountgroup = accountgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accountgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accountgroup" do
    assert_difference('Accountgroup.count') do
      post :create, accountgroup: { book_type: @accountgroup.book_type, group_name: @accountgroup.group_name, parent_group: @accountgroup.parent_group, schedule_no: @accountgroup.schedule_no }
    end

    assert_redirected_to accountgroup_path(assigns(:accountgroup))
  end

  test "should show accountgroup" do
    get :show, id: @accountgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accountgroup
    assert_response :success
  end

  test "should update accountgroup" do
    put :update, id: @accountgroup, accountgroup: { book_type: @accountgroup.book_type, group_name: @accountgroup.group_name, parent_group: @accountgroup.parent_group, schedule_no: @accountgroup.schedule_no }
    assert_redirected_to accountgroup_path(assigns(:accountgroup))
  end

  test "should destroy accountgroup" do
    assert_difference('Accountgroup.count', -1) do
      delete :destroy, id: @accountgroup
    end

    assert_redirected_to accountgroups_path
  end
end
