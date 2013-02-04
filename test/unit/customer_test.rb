# == Schema Information
#
# Table name: customers
#
#  id                    :integer          not null, primary key
#  is_active             :string(20)
#  name                  :string(255)      not null
#  short_name            :string(50)
#  code                  :string(50)
#  group                 :string(50)
#  opening_balance       :decimal(18, 2)
#  dr_cr                 :string(45)
#  current_balance       :decimal(18, 2)
#  set_as_party          :string(50)
#  name_to_print         :string(255)
#  comments              :text
#  cont_addr_bill_to     :text
#  cont_city             :string(50)
#  cont_district         :string(50)
#  cont_state            :string(50)
#  cont_country          :string(100)
#  cont_pin_code         :string(45)
#  cont_website          :string(255)
#  cont_contact_person   :string(100)
#  cont_designation      :string(100)
#  cont_phone            :string(50)
#  cont_fax              :string(50)
#  cont_mobile_no        :string(100)
#  cont_email_id         :string(50)
#  tin_no                :string(50)
#  cst_no                :string(50)
#  acct_no               :string(50)
#  bank_name             :string(50)
#  bank_ifsc             :string(50)
#  bank_branch           :string(50)
#  license_no            :string(100)
#  rate                  :string(50)
#  currency              :string(50)
#  central_excise_no     :string(50)
#  salesman              :string(50)
#  income_tax_no         :string(100)
#  use_voucher           :string(45)
#  discount_percentage   :decimal(5, 2)
#  credit_period         :integer
#  maximum_credit_limit  :decimal(18, 2)
#  maximum_debit_limit   :decimal(18, 2)
#  stop_if_period_exceed :string(45)
#  stop_if_amount_exceed :string(45)
#  segment               :string(45)
#  grade                 :string(45)
#  fleet_order           :string(45)
#  dely_addr_ship_to     :text
#  dely_city             :string(50)
#  dely_district         :string(50)
#  dely_state            :string(50)
#  dely_country          :string(100)
#  dely_pin_code         :string(45)
#  dely_website          :string(255)
#  dely_contact_person   :string(100)
#  dely_designation      :string(100)
#  dely_phone            :string(50)
#  dely_fax              :string(50)
#  dely_mobile_no        :string(100)
#  dely_email_id         :string(50)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  dely_add_same_cont    :string(45)
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
