# == Schema Information
#
# Table name: itemorders
#
#  id                  :integer          not null, primary key
#  invoice_id          :integer          not null
#  sales_date          :date
#  item_code           :string(255)      not null
#  item_name           :string(255)
#  quantity            :float
#  sales_rate_per_unit :float
#  total               :float
#  discount_percentage :float
#  final_total         :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_head        :string(225)      not null
#  other_account_head  :string(225)      not null
#  cash_credit         :string(45)       not null
#  transaction_name    :string(45)       not null
#  base_unit           :string(45)
#

require 'test_helper'

class ItemorderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
