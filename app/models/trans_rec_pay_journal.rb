# == Schema Information
#
# Table name: trans_rec_pay_journals
#
#  id                 :integer          not null, primary key
#  journal_date       :date
#  account_head       :string(255)
#  amount             :decimal(10, 2)
#  dr_cr              :string(45)
#  narration          :text
#  cheque_no          :string(255)
#  cheque_date        :date
#  recd_paid_from_to  :string(255)
#  cheque_description :text
#  approve            :string(255)
#  verify             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class TransRecPayJournal < ActiveRecord::Base
  
  attr_accessible :account_head, :approve, :cheque_date, :cheque_description, :cheque_no, :journal_date, :narration, :recd_paid_from_to, :verify, :amount, :dr_cr
  
  has_many :journal_entries, :dependent => :destroy
  
  accepts_nested_attributes_for :journal_entries, :reject_if => lambda { |a| a[:account_head].blank? or  a[:amount].blank? or  a[:dr_cr].blank?  }, :allow_destroy => true
  attr_accessible :journal_entries_attributes
  
  
  before_create do |transRecPayJournal|        
    
    # debitOrcredit transRecPayJournal.account_head, transRecPayJournal.dr_cr, transRecPayJournal.amount
      
  end
  
 
 
 
 
 
 
  before_update do |transRecPayJournal|
    
     debitOrcredit transRecPayJournal.account_head, transRecPayJournal.dr_cr, transRecPayJournal.amount
      
  end
 
 
 
 
  before_destroy do |transRecPayJournal|
  #  @subLedgers = JournalEntry.find_all_by_other_account_head(transRecPayJournal.account_head)
  #  @subLedgers.each do |sublegs|
  #    debitOrcredit sublegs.account_head, getOppositeDrCr(sublegs.dr_cr), sublegs.amount
  #  end
    
  #  debitOrcredit transRecPayJournal.account_head, getOppositeDrCr(transRecPayJournal.dr_cr), transRecPayJournal.amount
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
 
