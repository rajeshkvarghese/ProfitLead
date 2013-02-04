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

class Itemorder < ActiveRecord::Base
  
  belongs_to :invoice
  
  attr_accessible :discount_percentage, :invoice_id, :quantity, :sales_date,:item_code, :item_name, :sales_rate_per_unit, :total, 
  :final_total, :account_head, :other_account_head, :cash_credit, :transaction_name, :base_unit, :vat_account, :quantity_on_hand, 
  :discount_amount, :tax_amount
  
  validates :item_code, :presence => true
  
  before_create do |itemorderT|
    itemorderT.sales_date = itemorderT.invoice.invoice_date 
    itemorderT.cash_credit = itemorderT.invoice.cash_credit
    
    @taxLedger = "VAT " +itemorderT.vat_account.to_s + "%"
    
    if itemorderT.invoice.cash_credit == "Cash" then
      itemorderT.account_head = itemorderT.invoice.other_account_head
    else
      itemorderT.account_head = itemorderT.invoice.customer_name 
    end
     
 
     
  end
  
  
  
  before_update do |itemorderT|
    itemorderT.cash_credit = itemorderT.invoice.cash_credit
     itemorderT.sales_date = itemorderT.invoice.invoice_date 
     
    
      if itemorderT.invoice.cash_credit == "Cash" then
         itemorderT.account_head = itemorderT.invoice.other_account_head
      else
         itemorderT.account_head = itemorderT.invoice.customer_name 
      end
    
    
   #  if  itemorderT.other_account_head != nil and  itemorderT.other_account_head != "" then 
        @taxLedger = "VAT " +itemorderT.vat_account_was.to_s + "%"
           if itemorderT.tax_amount_was > 0.00 then   
       #      debitOrcredit @taxLedger, "Dr", itemorderT.tax_amount_was
      #       debitOrcredit itemorderT.other_account_head_was, "Dr", itemorderT.final_total_was - itemorderT.tax_amount_was
           else
      #       debitOrcredit itemorderT.other_account_head_was, "Dr", itemorderT.final_total_was
           end    
      #     debitOrcredit itemorderT.account_head_was, "Cr", itemorderT.final_total_was
           
         @taxLedger = "VAT " +itemorderT.vat_account.to_s + "%"  
           if itemorderT.tax_amount > 0.00 then   
       #       debitOrcredit @taxLedger, "Dr", itemorderT.tax_amount
        #       debitOrcredit itemorderT.other_account_head, "Cr", itemorderT.final_total - itemorderT.tax_amount
           else   
       #       debitOrcredit itemorderT.other_account_head, "Cr", itemorderT.final_total
           end
               
        #   debitOrcredit itemorderT.account_head, "Dr", itemorderT.final_total
   #   end    
      
      #  debitOrcredit itemorderT.account_head, getOppositeDrCr(itemorderT.dr_cr_was), itemorderT.final_total_was
      # debitOrcredit itemorderT.account_head, itemorderT.dr_cr, itemorderT.final_total
    
  end
  
  
  before_destroy do |itemorderT|
            # debitOrcredit itemorderT.other_account_head, "Dr", itemorderT.final_total
            # debitOrcredit itemorderT.account_head, "Cr", itemorderT.final_total
            
       allJEntriesInAPack = JournalEntry.find_by_line_item_ref("item_ord_"+itemorderT.id.to_s)
       if allJEntriesInAPack != nil then
          allJEntriesInAPack.destroy
       end   
  end  
  
  #after_destroy do |itemorderT|
    
 # end
  
  after_create do |itemorderT|
    @ItemT = Item.find_by_code(itemorderT.item_code)
    if @ItemT != nil then
      if @ItemT.quantity_on_hand != nil then
        
         if itemorderT.transaction_name.downcase == "sales invoice" or itemorderT.transaction_name.downcase == "purchase returns" then
            @ItemT.quantity_on_hand = @ItemT.quantity_on_hand - itemorderT.quantity
            @ItemT.save
         else
            if itemorderT.transaction_name.downcase == "purchase invoice" or itemorderT.transaction_name.downcase == "sales returns" then
               @ItemT.quantity_on_hand = @ItemT.quantity_on_hand + itemorderT.quantity
               @ItemT.save
            end
         end     
      end
    end
    
    
    
    
     if itemorderT.tax_amount > 0.00 then   
      
      
      
     jentry = JournalEntry.new
     jentry.account_head = @taxLedger
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = @taxLedger
     jentry.amount = itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save 
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.invoice.account_head
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.final_total -  itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
     
     
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = itemorderT.invoice.account_head
     jentry.amount = itemorderT.final_total -  itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
      
      
      
    # debitOrcredit @taxLedger, "Cr", itemorderT.tax_amount
    # debitOrcredit itemorderT.invoice.account_head, "Cr", itemorderT.final_total -  itemorderT.tax_amount
     
      
    else
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.invoice.account_head
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.final_total
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_"+itemorderT.id.to_s
     jentry.save
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = itemorderT.invoice.account_head
     jentry.amount = itemorderT.final_total
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_"+itemorderT.id.to_s
     jentry.save
      
      
      
      
      # debitOrcredit itemorderT.invoice.account_head, "Cr", itemorderT.final_total
    end      
     
    #debitOrcredit itemorderT.account_head, "Dr", itemorderT.final_total  
    
    
    
    
  end
  
  
  
  
  
  after_update do |itemorderT|
    @ItemT = Item.find_by_code(itemorderT.item_code)
    if @ItemT != nil then
      if @ItemT.quantity_on_hand != nil then
        
         if itemorderT.transaction_name.downcase == "sales invoice" or itemorderT.transaction_name.downcase == "purchase returns" then
            @ItemT.quantity_on_hand = @ItemT.quantity_on_hand + itemorderT.quantity_was
            @ItemT.quantity_on_hand = @ItemT.quantity_on_hand - itemorderT.quantity
            @ItemT.save
         else
            if itemorderT.transaction_name.downcase == "purchase invoice" or itemorderT.transaction_name.downcase == "sales returns" then
              @ItemT.quantity_on_hand = @ItemT.quantity_on_hand - itemorderT.quantity_was
               @ItemT.quantity_on_hand = @ItemT.quantity_on_hand + itemorderT.quantity
               @ItemT.save
            end
         end     
      end
    end
    
    
    
    
   allJEntriesInAPack = JournalEntry.find_by_line_item_ref("item_ord_"+itemorderT.id.to_s)
   if allJEntriesInAPack != nil then
          allJEntriesInAPack.destroy
   end   
   
   
    @taxLedger = "VAT " +itemorderT.vat_account_was.to_s + "%"
    
   
    
    
    if itemorderT.tax_amount > 0.00 then   
      
      
      
     jentry = JournalEntry.new
     jentry.account_head = @taxLedger
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = @taxLedger
     jentry.amount = itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save 
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.invoice.account_head
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.final_total -  itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
     
     
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = itemorderT.invoice.account_head
     jentry.amount = itemorderT.final_total -  itemorderT.tax_amount
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_" << itemorderT.id.to_s
     jentry.save
      
      
      
    # debitOrcredit @taxLedger, "Cr", itemorderT.tax_amount
    # debitOrcredit itemorderT.invoice.account_head, "Cr", itemorderT.final_total -  itemorderT.tax_amount
     
      
    else
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.invoice.account_head
     jentry.other_account_head = itemorderT.account_head
     jentry.amount = itemorderT.final_total
     jentry.description = ""
     jentry.dr_cr = "Cr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_"+itemorderT.id.to_s
     jentry.save
      
      
     jentry = JournalEntry.new
     jentry.account_head = itemorderT.account_head
     jentry.other_account_head = itemorderT.invoice.account_head
     jentry.amount = itemorderT.final_total
     jentry.description = ""
     jentry.dr_cr = "Dr"
     jentry.trans_type = itemorderT.transaction_name
     jentry.journal_date = itemorderT.sales_date
     jentry.invoice_id = itemorderT.invoice_id
     jentry.master_leg = "0"
     jentry.line_item_ref = "item_ord_"+itemorderT.id.to_s
     jentry.save
      
      
      
      
      # debitOrcredit itemorderT.invoice.account_head, "Cr", itemorderT.final_total
    end      
     
    #debitOrcredit itemorderT.account_head, "Dr", itemorderT.final_total
    
    
    
    
    
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
     if  @account.current_balance != nil and  @account.current_balance != "" and  @account.current_balance  != 0 then
         @currentbalance = @account.current_balance 
     else
        if @account.opening_balance != nil and  @account.opening_balance != "" and  @account.opening_balance  != 0 then
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
     
     
     
    if @currentbalance < 0 then
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
