# == Schema Information
#
# Table name: invoices
#
#  id                 :integer          not null, primary key
#  invoice_date       :date             not null
#  customer_name      :string(255)
#  bill_to_address    :text
#  ship_to_address    :text
#  sub_total          :decimal(18, 2)
#  vat                :decimal(18, 2)
#  total              :decimal(18, 2)
#  Paid               :decimal(18, 2)
#  balance            :decimal(18, 2)
#  comments           :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cash_credit        :string(45)       not null
#  account_head       :string(255)      not null
#  transaction_name   :string(45)       not null
#  other_account_head :string(255)      not null
#  address_line_1     :string(255)
#  address_line_2     :string(255)
#  address_line_3     :string(255)
#  address_line_4     :string(255)
#  address_line_5     :string(255)
#  address_line_6     :string(255)
#  phone              :string(45)
#  email              :string(45)
#

require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
