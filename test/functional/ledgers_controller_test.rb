require 'test_helper'

class LedgersControllerTest < ActionController::TestCase
  setup do
    @ledger = ledgers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ledgers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ledger" do
    assert_difference('Ledger.count') do
      post :create, ledger: { acct_no: @ledger.acct_no, bank_branch: @ledger.bank_branch, bank_ifsc: @ledger.bank_ifsc, bank_name: @ledger.bank_name, central_excise_no: @ledger.central_excise_no, code: @ledger.code, comments: @ledger.comments, credit_period: @ledger.credit_period, cst_no: @ledger.cst_no, currency: @ledger.currency, current_balance: @ledger.current_balance, dely_add_same_cont: @ledger.dely_add_same_cont, dely_addr_ship_to: @ledger.dely_addr_ship_to, dely_city: @ledger.dely_city, dely_contact_person: @ledger.dely_contact_person, dely_country: @ledger.dely_country, dely_designation: @ledger.dely_designation, dely_district: @ledger.dely_district, dely_email_id: @ledger.dely_email_id, dely_fax: @ledger.dely_fax, dely_mobile_no: @ledger.dely_mobile_no, dely_phone: @ledger.dely_phone, dely_pin_code: @ledger.dely_pin_code, dely_state: @ledger.dely_state, dely_website: @ledger.dely_website, discount_percentage: @ledger.discount_percentage, dr_cr: @ledger.dr_cr, fleet_order: @ledger.fleet_order, grade: @ledger.grade, group: @ledger.group, income_tax_no: @ledger.income_tax_no, is_active: @ledger.is_active, license_no: @ledger.license_no, maximum_credit_limit: @ledger.maximum_credit_limit, maximum_debit_limit: @ledger.maximum_debit_limit, name: @ledger.name, name_to_print: @ledger.name_to_print, office_addr_bill_to: @ledger.office_addr_bill_to, office_city: @ledger.office_city, office_contact_person: @ledger.office_contact_person, office_country: @ledger.office_country, office_designation: @ledger.office_designation, office_district: @ledger.office_district, office_email_id: @ledger.office_email_id, office_fax: @ledger.office_fax, office_mobile_no: @ledger.office_mobile_no, office_phone: @ledger.office_phone, office_pin_code: @ledger.office_pin_code, office_state: @ledger.office_state, office_website: @ledger.office_website, opening_balance: @ledger.opening_balance, rate: @ledger.rate, salesman: @ledger.salesman, segment: @ledger.segment, set_as_party: @ledger.set_as_party, short_name: @ledger.short_name, stop_if_amount_exceed: @ledger.stop_if_amount_exceed, stop_if_period_exceed: @ledger.stop_if_period_exceed, tin_no: @ledger.tin_no, use_voucher: @ledger.use_voucher }
    end

    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should show ledger" do
    get :show, id: @ledger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ledger
    assert_response :success
  end

  test "should update ledger" do
    put :update, id: @ledger, ledger: { acct_no: @ledger.acct_no, bank_branch: @ledger.bank_branch, bank_ifsc: @ledger.bank_ifsc, bank_name: @ledger.bank_name, central_excise_no: @ledger.central_excise_no, code: @ledger.code, comments: @ledger.comments, credit_period: @ledger.credit_period, cst_no: @ledger.cst_no, currency: @ledger.currency, current_balance: @ledger.current_balance, dely_add_same_cont: @ledger.dely_add_same_cont, dely_addr_ship_to: @ledger.dely_addr_ship_to, dely_city: @ledger.dely_city, dely_contact_person: @ledger.dely_contact_person, dely_country: @ledger.dely_country, dely_designation: @ledger.dely_designation, dely_district: @ledger.dely_district, dely_email_id: @ledger.dely_email_id, dely_fax: @ledger.dely_fax, dely_mobile_no: @ledger.dely_mobile_no, dely_phone: @ledger.dely_phone, dely_pin_code: @ledger.dely_pin_code, dely_state: @ledger.dely_state, dely_website: @ledger.dely_website, discount_percentage: @ledger.discount_percentage, dr_cr: @ledger.dr_cr, fleet_order: @ledger.fleet_order, grade: @ledger.grade, group: @ledger.group, income_tax_no: @ledger.income_tax_no, is_active: @ledger.is_active, license_no: @ledger.license_no, maximum_credit_limit: @ledger.maximum_credit_limit, maximum_debit_limit: @ledger.maximum_debit_limit, name: @ledger.name, name_to_print: @ledger.name_to_print, office_addr_bill_to: @ledger.office_addr_bill_to, office_city: @ledger.office_city, office_contact_person: @ledger.office_contact_person, office_country: @ledger.office_country, office_designation: @ledger.office_designation, office_district: @ledger.office_district, office_email_id: @ledger.office_email_id, office_fax: @ledger.office_fax, office_mobile_no: @ledger.office_mobile_no, office_phone: @ledger.office_phone, office_pin_code: @ledger.office_pin_code, office_state: @ledger.office_state, office_website: @ledger.office_website, opening_balance: @ledger.opening_balance, rate: @ledger.rate, salesman: @ledger.salesman, segment: @ledger.segment, set_as_party: @ledger.set_as_party, short_name: @ledger.short_name, stop_if_amount_exceed: @ledger.stop_if_amount_exceed, stop_if_period_exceed: @ledger.stop_if_period_exceed, tin_no: @ledger.tin_no, use_voucher: @ledger.use_voucher }
    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should destroy ledger" do
    assert_difference('Ledger.count', -1) do
      delete :destroy, id: @ledger
    end

    assert_redirected_to ledgers_path
  end
end
