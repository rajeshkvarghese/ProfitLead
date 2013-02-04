require 'test_helper'

class TransRecPayJournalsControllerTest < ActionController::TestCase
  setup do
    @trans_rec_pay_journal = trans_rec_pay_journals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trans_rec_pay_journals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trans_rec_pay_journal" do
    assert_difference('TransRecPayJournal.count') do
      post :create, trans_rec_pay_journal: { account_head: @trans_rec_pay_journal.account_head, approve: @trans_rec_pay_journal.approve, cheque_date: @trans_rec_pay_journal.cheque_date, cheque_description: @trans_rec_pay_journal.cheque_description, cheque_no: @trans_rec_pay_journal.cheque_no, journal_date: @trans_rec_pay_journal.journal_date, narration: @trans_rec_pay_journal.narration, recd_paid_from_to: @trans_rec_pay_journal.recd_paid_from_to, verify: @trans_rec_pay_journal.verify }
    end

    assert_redirected_to trans_rec_pay_journal_path(assigns(:trans_rec_pay_journal))
  end

  test "should show trans_rec_pay_journal" do
    get :show, id: @trans_rec_pay_journal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trans_rec_pay_journal
    assert_response :success
  end

  test "should update trans_rec_pay_journal" do
    put :update, id: @trans_rec_pay_journal, trans_rec_pay_journal: { account_head: @trans_rec_pay_journal.account_head, approve: @trans_rec_pay_journal.approve, cheque_date: @trans_rec_pay_journal.cheque_date, cheque_description: @trans_rec_pay_journal.cheque_description, cheque_no: @trans_rec_pay_journal.cheque_no, journal_date: @trans_rec_pay_journal.journal_date, narration: @trans_rec_pay_journal.narration, recd_paid_from_to: @trans_rec_pay_journal.recd_paid_from_to, verify: @trans_rec_pay_journal.verify }
    assert_redirected_to trans_rec_pay_journal_path(assigns(:trans_rec_pay_journal))
  end

  test "should destroy trans_rec_pay_journal" do
    assert_difference('TransRecPayJournal.count', -1) do
      delete :destroy, id: @trans_rec_pay_journal
    end

    assert_redirected_to trans_rec_pay_journals_path
  end
end
