
class LedgerSummaryReportsController < ApplicationController
  
  
  def index
    
    @ledger = params[:ledger]
    @columnsWidth= params[:columnswidth].split(",")
    @datewise = params[:datewise]
    
    @repType = "bankbook"
    
    if @datewise == "yearly" then
      
   
      
    else 
      if @datewise == "monthly" then
        
        #  @getOpBalance =  get_ledger_ClOp_Balances(@ledger, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
        #  @getClBalance =  get_ledger_ClOp_Balances(@ledger, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
          
          @columnsTitleDisp = "Month,Debit,Credit,Balance".split(",")
          @columnsDisp = 'monthname,amount,amount,balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          @rowItems = JournalEntry.select("YEAR(journal_date) AS yearJ, MONTH(journal_date) AS monthJ, MONTHNAME(journal_date) AS monthname, SUM(amount) as amount, dr_cr").where("account_head = '" + @ledger +"'").group("MONTH(journal_date)");
      
          @rowItems.each do |rowIt|
            last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"

            rowIt["balance"] = get_ledger_ClOp_Balances(@ledger, rowIt.yearJ.to_s, rowIt.monthJ.to_s, last_day_of_the_month.to_s, "CL" ).split("@").join(" ")
          end
            
      else 
        if @datewise == "daily" then
          
          
        else 
          if @datewise == "voucherwise" then
            
            
            
          else
            
            
          
          end  
         
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
       if dayP == "" then
          retVal = get_month_balance( firstRowItem[colName], dayP)
       else
          retVal = get_day_balance( firstRowItem[colName], dayP)
       end    
         
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
   
   
   def get_month_balance(strBalText, strDateNumberOnly) # returns balance @ Dr/Cr #strDateNumberOnly = "1" etc
    retValT = 0.00
    tmpArr = strBalText.split("=")
    intCntr = 0
    if tmpArrInd != nil then
      tmpArr.each do |tmpIt|
        intCntr += 1
        if intCntr % 2 == 0 then
          retValT = getSum(retValT.to_s, tmpIt)
        end  
       end
     end 
    retValT.to_s
   end
   
   def getSum(retValP, tmpItP)
     retVal = retValP.to_f
     if tmpItP != nil and tmpItP != "" then
       retVal = retVal.to_f + tmpItP.to_f
     end
   end  
   
   
end
