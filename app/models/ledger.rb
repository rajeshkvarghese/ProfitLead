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




class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end 



class Ledger < ActiveRecord::Base
  attr_accessible :acct_no, :bank_branch, :bank_ifsc, :bank_name, :central_excise_no, :code, :comments, :credit_period, :cst_no, :currency, :current_balance, :dely_add_same_cont, :dely_addr_ship_to, :dely_city, :dely_contact_person, :dely_country, :dely_designation, :dely_district, :dely_email_id, :dely_fax, :dely_mobile_no, :dely_phone, :dely_pin_code, :dely_state, :dely_website, :discount_percentage, :dr_cr, :fleet_order, :grade, :group, :income_tax_no, :is_active, :license_no, :maximum_credit_limit, :maximum_debit_limit, :name, :name_to_print, :office_addr_bill_to, :office_city, :office_contact_person, :office_country, :office_designation, :office_district, :office_email_id, :office_fax, :office_mobile_no, :office_phone, :office_pin_code, :office_state, :office_website, :opening_balance, :rate, :salesman, :segment, :set_as_party, :short_name, :stop_if_amount_exceed, :stop_if_period_exceed, :tin_no, :use_voucher

   validates :name, :presence => true
   
   validates :name , :uniqueness => true
      
   validates :office_email_id, :dely_email_id , :allow_blank => true, :uniqueness => true,  :email => true
   
   validates   :opening_balance,  :current_balance, :numericality => { :greater_than_or_equal_to => 0 }

  validates :maximum_debit_limit, :maximum_credit_limit, :credit_period , :discount_percentage,  :allow_blank => true, :numericality => { :greater_than_or_equal_to => 0 }
  
  
  
  
   before_save do |ledgerT|
     if ledgerT.current_balance <= 0 then
       ledgerT.current_balance = ledgerT.opening_balance
     end
   end
  
  
  after_save do |ledgerT|
    opBalance = get_ledger_ClOp_Balances(ledgerT.name, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP")
    if opBalance == nil or opBalance == "" then
      if ledgerT.current_balance_was != nil and ledgerT.current_balance_was != "" then
        put_ledger_ClOp_Balances(ledgerT.name, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP",  ledgerT.current_balance_was.to_s+"@"+ledgerT.dr_cr )
      else
        put_ledger_ClOp_Balances(ledgerT.name, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP",  ledgerT.current_balance.to_s+"@"+ledgerT.dr_cr )
      end
          
    end 
     put_ledger_ClOp_Balances(ledgerT.name, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL",  ledgerT.current_balance.to_s+"@"+ledgerT.dr_cr )  
  end
  
  
  def get_ledger_ClOp_Balances(ledger_nameP, yearP, monthP, dayP, balance_type ) #balance_type = CL or OP
    retVal = nil
    filterConds = "ledger_name = '"+ledger_nameP +"'"
   if balance_type == "CL" then  colName =  "closing_balances" else  colName =  "opening_balances" end
    if yearP != "" then
      filterConds = filterConds +" AND year = '" + yearP+"'"
    end
     if monthP != "" then
      filterConds = filterConds +" AND month = '" + monthP +"'"
    end
    rowItemsArr = LedgerClOpBalances.connection.execute("select * from "<< LedgerClOpBalances.table_name << " where " << filterConds << ";")
    if rowItemsArr.count == 0 then
      
     else
       firstRowItem = LedgerClOpBalances.find_by_id(rowItemsArr.first["id"])
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
  
  
  
  def put_ledger_ClOp_Balances(ledger_nameP, yearP, monthP, dayP, balance_type, strNewVal ) #balance_type = CL or OP
    filterConds = "ledger_name = '"+ledger_nameP +"'"
   if balance_type == "CL" then  colName =  "closing_balances" else  colName =  "opening_balances" end
    if yearP != "" then
      filterConds = filterConds +" AND year = '" + yearP+"'"
    end
     if monthP != "" then
      filterConds = filterConds +" AND month = '" + monthP +"'"
    end
    rowItemsArr = LedgerClOpBalances.connection.execute("select * from "<< LedgerClOpBalances.table_name << " where " << filterConds << ";")
    if rowItemsArr.count == 0 then
       rowItems = LedgerClOpBalances.create(:ledger_name => ledger_nameP, :year => yearP, :month => monthP, :closing_balances => "", :opening_balances => ""  )
       rowItems[colName] = put_day_balance( rowItems[colName], dayP, strNewVal)
       rowItems.save  
     else
       firstRowItem = LedgerClOpBalances.find_by_id(rowItemsArr.first["id"])
       firstRowItem[colName] = put_day_balance( firstRowItem[colName], dayP, strNewVal)
       firstRowItem.save
    end
    
     
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
