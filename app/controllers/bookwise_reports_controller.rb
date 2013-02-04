class DynamicModel < ActiveRecord::Base
    
end



class BookwiseReportsController < ApplicationController
  def index
    @repType = params[:reptype]
    @columnsWidth= params[:columnswidth].split(",")
    
    if @repType == "daybook" then
      @columnsTitleDisp = "Vchr No.,Vchr Date,Vchr Type,Ledger,Debit,Credit".split(",")
      @columnsDisp = 'id,journal_date,trans_type,account_head,amount,amount'.split(",")
      @DebitCol = 4
      @CreditCol = 5
      @rowItems = JournalEntry.select('trans_rec_pay_journal_id,generaljournal_id,invoice_id,id,journal_date,trans_type,account_head,sum(amount) as amount,dr_cr').where('journal_date=current_date').group("trans_rec_pay_journal_id,generaljournal_id,invoice_id,account_head");
      #@rowItems = JournalEntry.find_all_by_journal_date(Date.today).group("id,account_head");
      
      @getCashInHandOpBalance =  get_ledger_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
      @getCashInHandClBalance =  get_ledger_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
      
    else
      if @repType == "bankbook" then
          @columnsTitleDisp = "Account Name,Debit,Credit".split(",")
          @columnsDisp = 'name,current_balance,current_balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          @rowItems = Ledger.select('name,current_balance, dr_cr').where("name='Bank Current Account' OR name = 'Bank Overdraft'");
      else
         if @repType == "cashbook" then
            @columnsTitleDisp = "Account Name,Debit,Credit".split(",")
            @columnsDisp = 'name,current_balance,current_balance'.split(",")
            @DebitCol = 1
            @CreditCol = 2
            @rowItems = Ledger.select('name,current_balance, dr_cr').where("name='Cash in Hand'");
           
         end 
      end
    end
   
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
    if retVal == nil or retVal == "" then
      retVal = Ledger.find_by_name(ledger_nameP).current_balance.to_s + "@" + Ledger.find_by_name(ledger_nameP).dr_cr
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
  
  
  
 
  
 
  
  
end
