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
   
   before_create do |itemT|
     
     if itemT.purchase_rate  != "" then
       itemT.opening_stock_value = itemT.opening_quantity * itemT.purchase_rate
     end
     
     if itemT.quantity_on_hand <= 0 or itemT.quantity_on_hand == "" then
       itemT.quantity_on_hand = itemT.opening_quantity       
     end
   end

  
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
 

  after_save do |itemT|
    opBalance = get_item_ClOp_Balances(itemT.code, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP")
    stockInOut = "in"
    if opBalance == nil or opBalance == "" then
      if itemT.quantity_on_hand_was != nil and itemT.quantity_on_hand_was != "" then
        if itemT.quantity_on_hand < itemT.quantity_on_hand_was then
          stockInOut = "out"
        else
           stockInOut = "in" 
        end
        put_item_ClOp_Balances(itemT.code, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP",  itemT.quantity_on_hand_was.to_s+"@" + stockInOut )
      else
        put_item_ClOp_Balances(itemT.code, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP",  itemT.quantity_on_hand.to_s+"@" + stockInOut )
      end
    end 
     put_item_ClOp_Balances(itemT.code, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL",  itemT.quantity_on_hand.to_s+"@" + stockInOut )  
  end


   def get_item_ClOp_Balances(item_codeP, yearP, monthP, dayP, balance_type ) #balance_type = CL or OP
   retVal = nil
   filterConds = "item_code = '"+item_codeP +"'"
   if balance_type == "CL" then  colName =  "closing_balances" else  colName =  "opening_balances" end
    if yearP != "" then
      filterConds = filterConds +" AND year = '" + yearP+"'"
    end
     if monthP != "" then
      filterConds = filterConds +" AND month = '" + monthP +"'"
    end
    rowItemsArr = ItemClOpBalances.connection.execute("select * from "<< ItemClOpBalances.table_name << " where " << filterConds << ";")
    
    if rowItemsArr.count == 0 then
     else
       firstRowItem = ItemClOpBalances.find_by_id(rowItemsArr.first["id"])
       retVal = get_day_balance( firstRowItem[colName], dayP)
    end
    retVal
  end
  
   def get_day_balance(strBalText, strDateNumberOnly) # returns balance @ Dr/Cr #strDateNumberOnly = "1" etc
    retValT = nil
    tmpArr = strBalText.split("=")
    tmpArrInd = tmpArr.index("#" + strDateNumberOnly + "#")
    if tmpArrInd != nil then
      retValT = tmpArr[tmpArrInd+1]
    end 
    retValT
   end
  
   def put_item_ClOp_Balances(item_codeP, yearP, monthP, dayP, balance_type, strNewVal ) #balance_type = CL or OP
      filterConds = "item_code = '"+item_codeP +"'"
      if balance_type == "CL" then  colName =  "closing_balances" else  colName =  "opening_balances" end
      if balance_type == "CL" then  monthColName =  "month_closing_balance" else  monthColName =  "month_opening_balance" end
      if yearP != "" then
        filterConds = filterConds +" AND year = '" + yearP+"'"
      end
      if monthP != "" then
        filterConds = filterConds +" AND month = '" + monthP +"'"
      end
      rowItemsArr = ItemClOpBalances.connection.execute("select * from "<< ItemClOpBalances.table_name << " where " << filterConds << ";")
      if rowItemsArr.count == 0 then
        rowItems = ItemClOpBalances.create(:item_code=> item_codeP, :year => yearP, :month => monthP, :closing_balances => "", :opening_balances => "", :month_closing_balance => "", :month_opening_balance => "")
        rowItems[colName] = put_day_balance( rowItems[colName], dayP, strNewVal)
        put_month_balances( rowItems, strNewVal)
        rowItems.save  
     else
       firstRowItem = ItemClOpBalances.find_by_id(rowItemsArr.first["id"])
       firstRowItem[colName] = put_day_balance( firstRowItem[colName], dayP, strNewVal)
       put_month_balances( firstRowItem, strNewVal)
       firstRowItem.save
    end
  end
  
  
  def put_month_balances(rowItemsP, strNewValP)
    if rowItemsP["month_opening_balance"] == nil or rowItemsP["month_opening_balance"] == "" then
         rowItemsP["month_opening_balance"] = strNewValP
    end    
    rowItemsP["month_closing_balance"] = strNewValP
  end
  
  
  def put_day_balance(strBalText, strDateNumberOnly, strNewVal) # returns balance @ Dr/Cr #strDateNumberOnly = "1" etc
     retVal = "#" + strDateNumberOnly + "#="+strNewVal
     if strBalText != "" then
        tmpArr = strBalText.split("=")
        tmpArrInd = tmpArr.index("#" + strDateNumberOnly + "#")
        if tmpArrInd != nil then
          tmpArr[tmpArrInd+1] = strNewVal
          retVal = tmpArr.join("=") 
        else
           retVal = strBalText + "=" + retVal 
        end  
     end   
      retVal 
  end








end
