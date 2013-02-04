require 'test_helper'

class GeneraljournalsControllerTest < ActionController::TestCase
  setup do
    @generaljournal = generaljournals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generaljournals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generaljournal" do
    assert_difference('Generaljournal.count') do
      post :create, generaljournal: { cr_total: @generaljournal.cr_total, dr_total: @generaljournal.dr_total, job: @generaljournal.job, journal_date: @generaljournal.journal_date, narration: @generaljournal.narration, total_amount: @generaljournal.total_amount }
    end

    assert_redirected_to generaljournal_path(assigns(:generaljournal))
  end

  test "should show generaljournal" do
    get :show, id: @generaljournal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generaljournal
    assert_response :success
  end

  test "should update generaljournal" do
    put :update, id: @generaljournal, generaljournal: { cr_total: @generaljournal.cr_total, dr_total: @generaljournal.dr_total, job: @generaljournal.job, journal_date: @generaljournal.journal_date, narration: @generaljournal.narration, total_amount: @generaljournal.total_amount }
    assert_redirected_to generaljournal_path(assigns(:generaljournal))
  end

  test "should destroy generaljournal" do
    assert_difference('Generaljournal.count', -1) do
      delete :destroy, id: @generaljournal
    end

    assert_redirected_to generaljournals_path
  end
end
