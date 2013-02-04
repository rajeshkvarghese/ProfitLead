require 'test_helper'

class DataConfigsControllerTest < ActionController::TestCase
  setup do
    @data_config = data_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_config" do
    assert_difference('DataConfig.count') do
      post :create, data_config: { ledger_area_list: @data_config.ledger_area_list, ledger_designation_list: @data_config.ledger_designation_list, ledger_fleetorder_list: @data_config.ledger_fleetorder_list, ledger_grade_list: @data_config.ledger_grade_list, ledger_grade_list: @data_config.ledger_grade_list, ledger_rate_used_list: @data_config.ledger_rate_used_list, ledger_salesman_list: @data_config.ledger_salesman_list, ledger_use_voucher_list: @data_config.ledger_use_voucher_list }
    end

    assert_redirected_to data_config_path(assigns(:data_config))
  end

  test "should show data_config" do
    get :show, id: @data_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_config
    assert_response :success
  end

  test "should update data_config" do
    put :update, id: @data_config, data_config: { ledger_area_list: @data_config.ledger_area_list, ledger_designation_list: @data_config.ledger_designation_list, ledger_fleetorder_list: @data_config.ledger_fleetorder_list, ledger_grade_list: @data_config.ledger_grade_list, ledger_grade_list: @data_config.ledger_grade_list, ledger_rate_used_list: @data_config.ledger_rate_used_list, ledger_salesman_list: @data_config.ledger_salesman_list, ledger_use_voucher_list: @data_config.ledger_use_voucher_list }
    assert_redirected_to data_config_path(assigns(:data_config))
  end

  test "should destroy data_config" do
    assert_difference('DataConfig.count', -1) do
      delete :destroy, id: @data_config
    end

    assert_redirected_to data_configs_path
  end
end
