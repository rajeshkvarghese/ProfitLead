
class LedgerSummaryReportsController < ApplicationController
  
  
  def index
    
    @ledger = params[:ledger]
    @columnsWidth= params[:columnswidth].split(",")
    @datewise = params[:datewise]
    
    @repType = "bankbook"
    
  #  @getOpBalance =  get_ledger_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
  #  @getClBalance =  get_ledger_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
    
    if @datewise == "yearly" then
      
   
      
    else 
      if @datewise == "monthly" then
        
        #  @getOpBalance =  get_ledger_ClOp_Balances(@ledger, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
        #  @getClBalance =  get_ledger_ClOp_Balances(@ledger, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
          
          if Date.today.month > 4 then
            @OPYear = Date.today.year-1
          else
            @OPYear = Date.today.year 
          end
          
         @ledgRec =  Ledger.find_by_name(@ledger)
         @getOpBalance =  @ledgRec.opening_balance.to_s+"@"+@ledgRec.dr_cr_opening #get_ledger_ClOp_Balances(@ledger, OPYear.to_s, "4", "1", "OP" ) 
    
         @getClBalance =  @ledgRec.current_balance.to_s+"@"+@ledgRec.dr_cr_opening  #get_ledger_ClOp_Balances(@ledger, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
    
          
          @columnsTitleDisp = "Month,Debit,Credit,Balance".split(",")
          @columnsDisp = 'monthname,amount,amount,balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          @rowItems = JournalEntry.select("YEAR(journal_date) AS yearJ, MONTH(journal_date) AS monthJ, MONTHNAME(journal_date) AS monthname, SUM(amount) as amount, dr_cr").where("account_head = '" + @ledger +"'").group("MONTH(journal_date)").order("journal_date ASC");
      
          @rowItems.each do |rowIt|
            
          #  last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
            rowIt["alink"] = ledger_summary_reports_path + "?datewise=daily&columnswidth=10,10,20,21,12,12&ledger="+ @ledger +"&month="+rowIt.monthJ.to_s+"&year="+rowIt.yearJ.to_s
            rowIt["balance"] = getLedgerMonthFistLastBalances(@ledger, rowIt.yearJ.to_s, rowIt.monthJ.to_s, "CL") #get_ledger_ClOp_Balances(@ledger, rowIt.yearJ.to_s, rowIt.monthJ.to_s, last_day_of_the_month.to_s, "CL" ).split("@").join(" ")
          end
            
      else 
        if @datewise == "daily" then
          
          if params[:month].to_i > 4 then
            @OPYear = Date.today.year-1
          else
            @OPYear = Date.today.year 
          end
         @getOpBalance =  getLedgerMonthFistLastBalances(@ledger, params[:year], params[:month], "OP") #get_ledger_ClOp_Balances(@ledger, @OPYear.to_s, params[:month], "1", "OP" ) 
    
         @getClBalance =  getLedgerMonthFistLastBalances(@ledger, params[:year], params[:month], "CL") #get_ledger_ClOp_Balances(@ledger, @OPYear.to_s, params[:month], "31", "CL" ) 
      
          
          @columnsTitleDisp = "Date,Debit,Credit,Balance".split(",")
          @columnsDisp = 'journal_date,amount,amount,balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          
          @rowItems = JournalEntry.select("YEAR(journal_date) AS yearJ, MONTH(journal_date) AS monthJ, journal_date, MONTHNAME(journal_date) AS monthname, SUM(amount) as amount, dr_cr").where("account_head = '" + @ledger +"' AND month(journal_date) = "+params[:month]+"").group("DAY(journal_date)");
      
          @rowItems.each do |rowIt|
            
       #     last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
            rowIt["alink"] = ledger_summary_reports_path + "?datewise=voucherwise&columnswidth=10,10,10,10,10,20,0,10,10&ledger="+ @ledger +"&month=" + rowIt.monthJ.to_s + "&jdate="+rowIt.journal_date.day.to_s+"&year="+rowIt.yearJ.to_s
            rowIt["balance"] = get_ledger_ClOp_Balances(@ledger, rowIt.yearJ.to_s, rowIt.monthJ.to_s, rowIt.journal_date.day.to_s, "CL" ).split("@").join(" ")
          end
          
        else 
          if @datewise == "voucherwise" then
            
            if params[:month].to_i < 4 then
              @OPYear = Date.today.year
            else
              @OPYear = Date.today.year 
            end
            @getOpBalance =  get_ledger_ClOp_Balances(@ledger, params[:year], params[:month], params[:jdate], "OP" ) 
    
            @getClBalance =  get_ledger_ClOp_Balances(@ledger, params[:year], params[:month], params[:jdate], "CL" ) 
            
            @columnsTitleDisp = "Voucher No.,Cheque Date,Clear Date,Date,Voucher Type,Particluars,Debit,Credit,Balance".split(",")
            @columnsDisp = 'voucher_no,cheque_date,cheque_date,journal_date,trans_type,other_account_head,amount,amount,balance'.split(",")
            @DebitCol = 6
            @CreditCol = 7
          
            @rowItems = JournalEntry.select("other_account_head,trans_type, trans_rec_pay_journal_id, generaljournal_id, invoice_id, id , YEAR(journal_date) AS yearJ, MONTH(journal_date) AS monthJ, journal_date, MONTHNAME(journal_date) AS monthname, SUM(amount) as amount, dr_cr").where("account_head = '" + @ledger +"' AND DAY(journal_date) = "+params[:jdate]+" AND MONTH(journal_date) = " + params[:month]).group("trans_rec_pay_journal_id , generaljournal_id, invoice_id");
      
            @rowItems.each do |rowIt|
              @voucherId = ""
              if rowIt.trans_rec_pay_journal_id != nil then
                @voucherId = rowIt.trans_rec_pay_journal_id
                @invoice = TransRecPayJournal.find_by_id(@voucherId)
                rowIt["cheque_date"] = @invoice.cheque_date
                rowIt["voucher_no"] = @voucherId
                
              else
                if rowIt.generaljournal_id != nil then
                     @voucherId = rowIt.generaljournal_id
                     @invoice = Generaljournal.find_by_id(@voucherId)
                     rowIt["cheque_date"] ="" # @invoice.cheque_date
                     rowIt["voucher_no"] = @voucherId
                 else
                     if rowIt.invoice_id != nil then
                       @voucherId = rowIt.invoice_id
                       @invoice = Invoice.find_by_id(@voucherId)
                       rowIt["cheque_date"] = "" # @invoice.cheque_date
                       rowIt["voucher_no"] = @voucherId
                     end
                end
              end
            
            
            
            
          #   last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
             rowIt["alink"] = ledger_summary_reports_path + "?datewise=voucherwise&columnswidth=10,10,20,21,12,12&ledger="+ @ledger
             rowIt["balance"] =  getLedgerSPBalance(@voucherId, @ledger)    #get_ledger_ClOp_Balances(@ledger, rowIt.yearJ.to_s, rowIt.monthJ.to_s, rowIt.journal_date.day.to_s, "CL" ).split("@").join(" ")
            end
          else
            if @datewise == "entt" then
              
              
              
              
            end 
            
          
          end  
         
        end
      
      end
    end
    
    
  end
  
  
  
  def getLedgerMonthFistLastBalances(ledger_nameP, yearP, monthP, balance_type)
     if balance_type == "CL" then  monthColName =  "month_closing_balance" else  monthColName =  "month_opening_balance" end
      filterConds = "ledger_name = '"+ledger_nameP +"'"
     if yearP != "" then
        filterConds = filterConds +" AND year = '" + yearP+"'"
     end
     if monthP != "" then
       filterConds = filterConds +" AND month = '" + monthP +"'"
     end
     rowItemsArr = LedgerClOpBalances.connection.execute("select * from "<< LedgerClOpBalances.table_name << " where " << filterConds << ";")
     #"select * from "<< LedgerClOpBalances.table_name << " where " << filterConds << ";@Dr"
     if rowItemsArr.first[monthColName] != nil then
       rowItemsArr.first[monthColName].split("@").join(" ")
     else
       "0.00 Dr"
     end    
  end
  
  
  
  def getLedgerSPBalance(vchr_no, ledger)
    retVal = ""
    
    @rowItem = VoucherExtraData.find_by_voucher_no(vchr_no)
    if @rowItem != nil then
      valP = @rowItem.ledger_balances
      if valP != nil and valP != "" then
        arrItems = valP.split("@@")
        arrItems.each do |itm|
          if itm.split("=")[0] == ledger then
            retVal = itm.split("=")[1]
          end
        end
      end
    end
    retVal
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
