require 'test_helper'

class ItemgroupsControllerTest < ActionController::TestCase
  setup do
    @itemgroup = itemgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:itemgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create itemgroup" do
    assert_difference('Itemgroup.count') do
      post :create, itemgroup: { category: @itemgroup.category, code: @itemgroup.code, description: @itemgroup.description, discount_per: @itemgroup.discount_per, main_group: @itemgroup.main_group, name: @itemgroup.name, print_name: @itemgroup.print_name, print_only_sum: @itemgroup.print_only_sum, tax: @itemgroup.tax, update_disc_child: @itemgroup.update_disc_child, update_tax_child: @itemgroup.update_tax_child }
    end

    assert_redirected_to itemgroup_path(assigns(:itemgroup))
  end

  test "should show itemgroup" do
    get :show, id: @itemgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @itemgroup
    assert_response :success
  end

  test "should update itemgroup" do
    put :update, id: @itemgroup, itemgroup: { category: @itemgroup.category, code: @itemgroup.code, description: @itemgroup.description, discount_per: @itemgroup.discount_per, main_group: @itemgroup.main_group, name: @itemgroup.name, print_name: @itemgroup.print_name, print_only_sum: @itemgroup.print_only_sum, tax: @itemgroup.tax, update_disc_child: @itemgroup.update_disc_child, update_tax_child: @itemgroup.update_tax_child }
    assert_redirected_to itemgroup_path(assigns(:itemgroup))
  end

  test "should destroy itemgroup" do
    assert_difference('Itemgroup.count', -1) do
      delete :destroy, id: @itemgroup
    end

    assert_redirected_to itemgroups_path
  end
end
