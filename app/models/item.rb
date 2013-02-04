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

class Item < ActiveRecord::Base
  attr_accessible :code, :alias, :name, :group, :base_unit, :opening_quantity, :quantity_on_hand, 
  :opening_stock_value, :reorder_level, :indicator_level, :manufacturer, :category, :max_retail_price,
  :hsn_code, :min_retail_price, :ean_code, :purchase_rate, :vat_account, :sales_rate, :costing, 
  :other_rate, :pack_numbers, :market_rate, :discount_percentage, :comments, :update_stock_with_bonus,
  :is_active, :set_as_container, :discount_amount, :tax_amount
  
   validates :opening_quantity, :code, :name, :presence => true
   
   validates :code, :alias , :uniqueness => true



  
   before_save do |itemT|
     if itemT.discount_percentage == nil or itemT.discount_percentage <= 0 then 
      @itemgroupT = Itemgroup.find_by_name(itemT.group)
      if @itemgroupT != nil then
         if @itemgroupT.update_disc_child != false then
           itemT.discount_percentage = @itemgroupT.discount_per 
         end
      end
     end
    end 
 


end
