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

  class MyValidator < ActiveModel::Validator
     def validate(record)
       if record.cash_credit == "Credit" then
        if record.customer_name == "" then
         # record.errors[:base] = "You have to select a customer for credit transaction"
          record.errors[:customer_name] = "Please select a customer"
        end
      end
    end
   end 

class Invoice < ActiveRecord::Base
  

  #validates_with MyValidator
  


  
  attr_accessible :Paid, :balance, :bill_to_address, :customer_name, :invoice_date, :ship_to_address, :sub_total, :total, :vat, :comments, :cash_credit,
   :account_head, :transaction_name, :other_account_head, :address_line_1, :address_line_2, :address_line_3, :address_line_4, :address_line_5, :address_line_6, :phone, :email
  
  validates  :invoice_date, :presence => true
  
  has_many :itemorders, :dependent => :destroy
  has_many :journal_entries, :dependent => :destroy
  
  accepts_nested_attributes_for :itemorders, :reject_if => lambda { |a| a[:item_code].blank? }, :allow_destroy => true
  attr_accessible :itemorders_attributes


  #attr_accessible itemorders[:invoice_id , :item_code, :item_name, :quantity]
  
  
  
  #before_save :assign_invoice_id_to_lineItem

  #def assign_invoice_id_to_lineItem
   #self.itemorders.each do |itemorder|
   #  itemorder.invoice_id = params[:id]
   #  itemorder.save
    # LeadsUsers.create :user_id => :user_id, :lead_id => line_item.lead.id
  # ItOrd = self.itemorders.new :invoice_id => "1002", :item_code => "3000"
   #  ItOrd.save
   #end
   #:invoice_id,
   #itord = Itemorder.find_by_invoice_id("")
    #  itord.
 # end 
  
  
  
  
   
 def aa_before_create #do |invoice|     
   
   #--- invoice.account_head = params[:acchead]
   #---- invoice.total = invoice.colTotal
   
    if  invoice.cash_credit == "Cash" then 
        debitOrcredit invoice.other_account_head, "Dr", invoice.total.to_f
        debitOrcredit invoice.account_head, "Cr", invoice.total.to_f
    else
      if invoice.other_account_head.downcase == "cash in hand" then
           debitOrcredit invoice.customer_name, "Dr", invoice.total.to_f
           debitOrcredit invoice.account_head, "Cr", invoice.total.to_f  
      else
          debitOrcredit invoice.customer_name, "Cr", invoice.total.to_f
          debitOrcredit invoice.other_account_head, "Dr", invoice.total.to_f  
      end
          
    end       
      
end
  
  
def aa_before_update #do |invoice|
    
     if  invoice.cash_credit == "Cash" then 
       
       debitOrcredit invoice.other_account_head, "Cr", invoice.total_was.to_f
        debitOrcredit invoice.account_head, "Dr", invoice.total_was.to_f

       
        debitOrcredit invoice.other_account_head, "Dr", invoice.total.to_f
        debitOrcredit invoice.account_head, "Cr", invoice.total.to_f
    else
      
       debitOrcredit invoice.customer_name, "Cr", invoice.total_was.to_f
       debitOrcredit invoice.account_head, "Dr", invoice.total_was.to_f   
      
      
       debitOrcredit invoice.customer_name, "Dr", invoice.total.to_f
       debitOrcredit invoice.account_head, "Cr", invoice.total.to_f      
    end       
      
end
  
  
  def getOppositeDrCr(dr_cr)
    if dr_cr == "Dr" then
       "Cr"
      else
        "Dr" 
    end
  end
 
 
 
 
  def debitOrcredit varAccountName, varDr_Cr, varAmount
   @account = Ledger.find_by_name(varAccountName)
     
     @currentbalance = 0.00
     if  @account.current_balance != nil and  @account.current_balance != "" and  @account.current_balance  != 0.00 then
         @currentbalance = @account.current_balance 
     else
        if @account.opening_balance != nil and  @account.opening_balance != "" and  @account.opening_balance  != 0.00 then
           @currentbalance = @account.opening_balance 
        else
            @currentbalance = 0.00  
        end    
     end
     
    
        if  varDr_Cr == "Cr" then  
          if  @currentbalance != 0.00 then    
            if  @account.dr_cr == "Cr" then
              @currentbalance =  @currentbalance + varAmount           
            else
              if @account.dr_cr == "Dr" then
                 @currentbalance =  @currentbalance - varAmount
              else
                  @currentbalance = varAmount     
                   @account.dr_cr = "Cr"             
              end 
           end
          else
              @currentbalance = varAmount     
               @account.dr_cr = "Cr"      
          end    
        else
          if  @currentbalance != 0.00 then   
           if  @account.dr_cr == "Cr" then
              @currentbalance =  @currentbalance - varAmount          
           else
              if @account.dr_cr == "Dr" then
                 @currentbalance =  @currentbalance + varAmount
              else
                  @currentbalance = varAmount    
                   @account.dr_cr = "Dr"             
              end 
           end  
           else
              @currentbalance = varAmount    
              @account.dr_cr = "Dr"      
          end     
           
        end
     
     
     
    if @currentbalance < 0.00 then
         if @account.dr_cr == "Cr" then
            @account.dr_cr = "Dr"
         else
            @account.dr_cr = "Cr"  
         end
      @currentbalance = @currentbalance * -1 
    else
      if @currentbalance == 0.00 then
        @account.dr_cr =""
      end
    end
    
    @account.current_balance = @currentbalance
     @account.save    
  end
  
  
  
end
