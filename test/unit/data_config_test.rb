# == Schema Information
#
# Table name: data_configs
#
#  id                      :integer          not null, primary key
#  ledger_designation_list :string(1000)
#  ledger_area_list        :string(1000)
#  ledger_salesman_list    :string(1000)
#  ledger_use_voucher_list :string(1000)
#  ledger_rate_used_list   :string(1000)
#  ledger_grade_list       :string(1000)
#  ledger_fleetorder_list  :string(1000)
#  ledger_segment_list     :string(1000)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  item_base_unit          :string(1000)
#

require 'test_helper'

class DataConfigTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
