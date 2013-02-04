# == Schema Information
#
# Table name: journal_entries
#
#  id                       :integer          not null, primary key
#  trans_rec_pay_journal_id :integer
#  journal_date             :date
#  account_head             :string(255)
#  other_account_head       :string(255)
#  amount                   :decimal(10, 2)
#  dr_cr                    :string(255)
#  trans_type               :string(255)
#  master_leg               :string(255)
#  description              :text
#  dr_amount                :decimal(10, 2)
#  cr_amount                :decimal(10, 2)
#  generaljournal_id        :string(45)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class JournalEntry < ActiveRecord::Base
  
  
  
  attr_accessible :dr_amount, :cr_amount, :account_head, :amount, :description, :dr_cr, :journal_date, 
  :master_leg, :trans_type, :trans_rec_pay_journal_id, :generaljournal_id, :other_account_head, :invoice_id, :line_item_ref
   
   belongs_to :trans_rec_pay_journal
   belongs_to :generalledger
   
   
  
   
  before_create do |journal_entry|
     
    debitOrcredit journal_entry.account_head, journal_entry.dr_cr, journal_entry.amount
    
    begin
      token = SecureRandom.urlsafe_base64
    end while JournalEntry.where(:line_item_ref => token).exists?
    
    if line_item_ref == "" then
      journal_entry.line_item_ref = token
    end   
      
    
   end
   
   after_create do |journal_entry|
     
     if journal_entry.trans_rec_pay_journal_id != nil and JournalEntry.find_all_by_line_item_ref(journal_entry.line_item_ref).count < 2  then
      
        jentry = JournalEntry.new
        
        jentry.account_head = journal_entry.other_account_head
        jentry.other_account_head = journal_entry.account_head
        jentry.amount = journal_entry.amount
        jentry.description = journal_entry.description
        jentry.dr_cr = getOppositeDrCr(journal_entry.dr_cr)
        jentry.trans_type = journal_entry.trans_type
        jentry.journal_date = journal_entry.journal_date
        jentry.trans_rec_pay_journal_id = journal_entry.trans_rec_pay_journal_id
        jentry.master_leg = "0"
        jentry.line_item_ref = journal_entry.line_item_ref 
        jentry.save
        
        
        debitOrcredit journal_entry.other_account_head, getOppositeDrCr(journal_entry.dr_cr), journal_entry.amount
    end    
     
   end
  
  
  
  
     
   before_update do |journal_entry|
     
#   before_save do |journal_entry|     
    
      if  journal_entry.other_account_head != nil and  journal_entry.other_account_head != "" then 
             debitOrcredit journal_entry.other_account_head, journal_entry.dr_cr_was, journal_entry.amount_was
             debitOrcredit journal_entry.other_account_head, getOppositeDrCr(journal_entry.dr_cr), journal_entry.amount
             
             debitOrcredit journal_entry.other_account_head, journal_entry.dr_cr_was, journal_entry.amount_was
             debitOrcredit journal_entry.other_account_head, getOppositeDrCr(journal_entry.dr_cr), journal_entry.amount
      end    
      
       debitOrcredit journal_entry.account_head, getOppositeDrCr(journal_entry.dr_cr_was), journal_entry.amount_was
       debitOrcredit journal_entry.account_head, journal_entry.dr_cr, journal_entry.amount
       
       
       @other_journal = JournalEntry.find(:first, :conditions => ["id != ? and line_item_ref = ?", journal_entry.id, journal_entry.line_item_ref])
       if @other_journal != nil then
        begin
          token = SecureRandom.urlsafe_base64
        end while JournalEntry.where(:line_item_ref => token).exists?
        journal_entry.line_item_ref = token
      end   
       
  end
  
   after_update do |journal_entry|
          @other_journal = JournalEntry.find(:first, :conditions => ["id != ? and line_item_ref = ?", journal_entry.id, journal_entry.line_item_ref_was])
          if @other_journal != nil  then
            @other_journal.amount = journal_entry.amount
            @other_journal.dr_cr = getOppositeDrCr(journal_entry.dr_cr)
            @other_journal.line_item_ref = journal_entry.line_item_ref 
            
            #OTHER FIELDS GO HERE
            
            
            @other_journal.save
          end
  end        
  
  
   def getOppositeDrCr(dr_cr)
     if dr_cr == "Dr" then
       "Cr"
      else
        "Dr" 
     end
   end
  
  
  
  
   before_destroy do |journal_entry|
     
     
     
     if  journal_entry.dr_cr == "Cr" then  
          debitOrcredit journal_entry.account_head, "Dr", journal_entry.amount
         # if  journal_entry.other_account_head != nil and  journal_entry.other_account_head != "" then 
         #     debitOrcredit journal_entry.other_account_head, "Cr", journal_entry.amount
        #  end    
     else  
         debitOrcredit journal_entry.account_head, "Cr", journal_entry.amount
        # if  journal_entry.other_account_head != nil and  journal_entry.other_account_head != "" then
        #    debitOrcredit journal_entry.other_account_head, "Dr", journal_entry.amount
        # end   
     end 
  end  
  
  
  after_destroy do |journal_entry|
    allJEntriesInAPack = JournalEntry.find_all_by_line_item_ref(journal_entry.line_item_ref)
    if allJEntriesInAPack.count > 0 then
      allJEntriesInAPack.each do |je|
        je.destroy
      end
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


