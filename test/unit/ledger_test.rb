# == Schema Information
#
# Table name: ledgers
#
#  id                    :integer          not null, primary key
#  is_active             :string(50)
#  name                  :string(255)      not null
#  short_name            :string(255)
#  code                  :string(255)
#  group                 :string(255)
#  opening_balance       :decimal(18, 2)
#  dr_cr                 :string(255)
#  current_balance       :decimal(18, 2)
#  set_as_party          :string(255)
#  name_to_print         :string(255)
#  comments              :text
#  office_addr_bill_to   :text
#  office_city           :string(255)
#  office_district       :string(255)
#  office_state          :string(255)
#  office_country        :string(255)
#  office_pin_code       :string(255)
#  office_website        :string(255)
#  office_contact_person :string(255)
#  office_designation    :string(255)
#  office_phone          :string(255)
#  office_fax            :string(255)
#  office_mobile_no      :string(255)
#  office_email_id       :string(255)
#  tin_no                :string(255)
#  cst_no                :string(255)
#  acct_no               :string(255)
#  bank_name             :string(255)
#  bank_ifsc             :string(255)
#  bank_branch           :string(255)
#  license_no            :string(255)
#  rate                  :string(255)
#  currency              :string(255)
#  central_excise_no     :string(255)
#  salesman              :string(255)
#  income_tax_no         :string(255)
#  use_voucher           :string(255)
#  discount_percentage   :decimal(18, 2)
#  credit_period         :integer
#  maximum_credit_limit  :decimal(18, 2)
#  maximum_debit_limit   :decimal(18, 2)
#  stop_if_period_exceed :string(255)
#  stop_if_amount_exceed :string(255)
#  segment               :string(255)
#  grade                 :string(255)
#  fleet_order           :string(255)
#  dely_addr_ship_to     :text
#  dely_city             :string(255)
#  dely_district         :string(255)
#  dely_state            :string(255)
#  dely_country          :string(255)
#  dely_pin_code         :string(255)
#  dely_website          :string(255)
#  dely_contact_person   :string(255)
#  dely_designation      :string(255)
#  dely_phone            :string(255)
#  dely_fax              :string(255)
#  dely_mobile_no        :string(255)
#  dely_email_id         :string(255)
#  dely_add_same_cont    :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class LedgerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
