# == Schema Information
#
# Table name: items
#
#  id                      :integer          not null, primary key
#  code                    :string(50)       not null
#  alias                   :string(50)
#  name                    :string(255)      not null
#  group                   :string(100)
#  base_unit               :string(50)
#  opening_quantity        :integer          default(0)
#  quantity_on_hand        :integer          default(0)
#  opening_stock_value     :decimal(18, 2)   default(0.0)
#  reorder_level           :integer
#  indicator_level         :integer
#  manufacturer            :string(100)
#  category                :string(50)
#  max_retail_price        :decimal(18, 2)
#  hsn_code                :string(50)
#  min_retail_price        :decimal(18, 2)
#  ean_code                :string(50)
#  purchase_rate           :decimal(18, 2)
#  vat_account             :string(50)
#  sales_rate              :decimal(18, 2)
#  costing                 :string(50)
#  other_rate              :decimal(18, 2)
#  pack_numbers            :integer
#  market_rate             :decimal(18, 2)
#  discount_percentage     :decimal(18, 2)   default(0.0)
#  comments                :text
#  update_stock_with_bonus :string(45)
#  is_active               :string(45)
#  set_as_container        :string(45)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  discount_amount         :decimal(18, 2)
#  tax_amount              :decimal(18, 2)
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
