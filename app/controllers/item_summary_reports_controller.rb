class ItemSummaryReportsController < ApplicationController
  
  
  def index
    
    @item = params[:item]
    @columnsWidth= params[:columnswidth].split(",")
    @datewise = params[:datewise]
    
    @repType = "bankbook"
    
  #  @getOpBalance =  get_item_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
  #  @getClBalance =  get_item_ClOp_Balances("Cash in Hand", Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
    
    if @datewise == "yearly" then
      
    else 
      if @datewise == "monthly" then
        
        #  @getOpBalance =  get_item_ClOp_Balances(@item, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "OP" ) 
    
        #  @getClBalance =  get_item_ClOp_Balances(@item, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
          
          if Date.today.month < 4 then
            @OPYear = Date.today.year-1
          else
            @OPYear = Date.today.year 
          end
          
         @itemRec =  Item.find_by_code(@item)
         
         @getOpBalance =  @itemRec.opening_quantity.to_s+"@in" #get_item_ClOp_Balances(@item, OPYear.to_s, "4", "1", "OP" ) 
    
         @getClBalance =  @itemRec.quantity_on_hand.to_s+"@in"  #get_item_ClOp_Balances(@item, Date.today.year.to_s, Date.today.month.to_s, Date.today.day.to_s, "CL" ) 
      
    
          
          @columnsTitleDisp = "Month,Stock In,Stock Out,Balance".split(",")
          @columnsDisp = 'monthname,quantity,quantity,balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          @rowItems = Itemorder.select("YEAR(sales_date) AS yearJ, MONTH(sales_date) AS monthJ, MONTHNAME(sales_date) AS monthname, SUM(quantity) as quantity, transaction_name").where("item_code = '" + @item +"'").group("MONTH(sales_date)").order("sales_date ASC");
      
          @rowItems.each do |rowIt|
            
            if rowIt.transaction_name == "Sales Invoice" then
              rowIt["in_out"] = "out"
            else
              if rowIt.transaction_name == "Purchase Invoice" then
                rowIt["in_out"] = "in"
              else
                if rowIt.transaction_name == "Purchase Returns" then
                  rowIt["in_out"] = "out"
                else
                  rowIt["in_out"] = "in"
                end
              end
            end
            
           # last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
            rowIt["alink"] = item_summary_reports_path + "?datewise=daily&columnswidth=10,10,20,21,12,12&item="+ @item +"&month="+rowIt.monthJ.to_s+"&year="+rowIt.yearJ.to_s
            rowIt["balance"] = getItemMonthFistLastBalances(@item, rowIt.yearJ.to_s, rowIt.monthJ.to_s, "CL").split("@")[0] #get_item_ClOp_Balances(@item, rowIt.yearJ.to_s, rowIt.monthJ.to_s, last_day_of_the_month.to_s, "CL" ).split("@").join(" ")
          end
            
      else 
        if @datewise == "daily" then
          
          if params[:month].to_i < 4 then
            @OPYear = Date.today.year-1
          else
            @OPYear = Date.today.year 
          end
          
          @getOpBalance =  getItemMonthFistLastBalances(@item, params[:year], params[:month], "OP")
    
          @getClBalance =  getItemMonthFistLastBalances(@item, params[:year], params[:month], "CL")
          
          @columnsTitleDisp = "Date,Stock In,Stock Out,Balance".split(",")
          @columnsDisp = 'sales_date,quantity,quantity,balance'.split(",")
          @DebitCol = 1
          @CreditCol = 2
          
          @rowItems = Itemorder.select("YEAR(sales_date) AS yearJ, MONTH(sales_date) AS monthJ, sales_date, MONTHNAME(sales_date) AS monthname, SUM(quantity) as quantity, transaction_name").where("item_code = '" + @item +"' AND month(sales_date) = "+params[:month]+"").group("DAY(sales_date)");
      
          @rowItems.each do |rowIt|
            
            if rowIt.transaction_name == "Sales Invoice" then
              rowIt["in_out"] = "out"
            else
              if rowIt.transaction_name == "Purchase Invoice" then
                rowIt["in_out"] = "in"
              else
                if rowIt.transaction_name == "Purchase Returns" then
                  rowIt["in_out"] = "out"
                else
                  rowIt["in_out"] = "in"
                end
              end
            end
            
           # last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
            rowIt["alink"] = item_summary_reports_path + "?datewise=voucherwise&columnswidth=10,10,10,10,10,20,0,10,10&item=" + @item +"&month=" + rowIt.monthJ.to_s + "&jdate="+rowIt.sales_date.day.to_s+"&year="+rowIt.yearJ.to_s
            rowIt["balance"] = get_item_ClOp_Balances(@item, rowIt.yearJ.to_s, rowIt.monthJ.to_s, rowIt.sales_date.day.to_s, "CL" ).split("@")[0]
          end
          
        else 
          if @datewise == "voucherwise" then
            
            if params[:month].to_i < 4 then
              @OPYear = Date.today.year
            else
              @OPYear = Date.today.year 
            end
            @getOpBalance =  get_item_ClOp_Balances(@item, params[:year], params[:month], params[:jdate], "OP" ) 
    
            @getClBalance =  get_item_ClOp_Balances(@item, params[:year], params[:month], params[:jdate], "CL" ) 
            
            @columnsTitleDisp = "Voucher No.,Date,Voucher Type,Particluars,Stock In,Stock Out,Balance".split(",")
            @columnsDisp = 'voucher_no,sales_date,transaction_name,other_account_head,quantity,quantity,balance'.split(",")
            @DebitCol = 4
            @CreditCol = 5
          
            @rowItems = Itemorder.select("other_account_head,transaction_name, invoice_id as voucher_no, id , YEAR(sales_date) AS yearJ, MONTH(sales_date) AS monthJ, sales_date, MONTHNAME(sales_date) AS monthname, SUM(quantity) as quantity").where("item_code = '" + @item +"' AND DAY(sales_date) = "+params[:jdate]+" AND MONTH(sales_date) = " + params[:month]).group("invoice_id");
      
             @rowItems.each do |rowIt|
               
               
             if rowIt.transaction_name == "Sales Invoice" then
              rowIt["in_out"] = "out"
            else
              if rowIt.transaction_name == "Purchase Invoice" then
                rowIt["in_out"] = "in"
              else
                if rowIt.transaction_name == "Purchase Returns" then
                  rowIt["in_out"] = "out"
                else
                  rowIt["in_out"] = "in"
                end
              end
            end
            # last_day_of_the_month = (Date.parse(rowIt.yearJ + "-" + (rowIt.monthJ.to_i + 1).to_s + "-01") - 1).mday().to_s rescue "31"
            
             rowIt["alink"] = item_summary_reports_path + "?datewise=voucherwise&columnswidth=10,10,20,21,12,12&item=Cash%20in%20Hand"
             rowIt["balance"] =  getItemSPBalance(rowIt["voucher_no"], @item)    #get_item_ClOp_Balances(@item, rowIt.yearJ.to_s, rowIt.monthJ.to_s, rowIt.journal_date.day.to_s, "CL" ).split("@").join(" ")
            end
          else
            if @datewise == "entt" then
              
              
              
              
            end 
            
          
          end  
         
        end
      
      end
    end
    
    
  end
  
  
  
  def getItemMonthFistLastBalances(item_codeP, yearP, monthP, balance_type)
     if balance_type == "CL" then  monthColName =  "month_closing_balance" else  monthColName =  "month_opening_balance" end
      filterConds = " item_code = '"+item_codeP +"'"
     if yearP != "" then
        filterConds = filterConds +" AND year = '" + yearP+"'"
     end
     if monthP != "" then
       filterConds = filterConds +" AND month = '" + monthP +"'"
     end
     rowItemsArr = ItemClOpBalances.select(monthColName).where(filterConds) # connection.execute("select * from "<< ItemClOpBalances.table_name << " where " << filterConds << ";")
    #rowItemsArr
    
     if rowItemsArr.count > 0 then
       if rowItemsArr.count > 0 then   #changhe this tline (remove)
         if rowItemsArr.first[monthColName] != nil then
           rowItemsArr.first[monthColName].split("@")[0]+"@in"
         else
           "0.00"
         end  
       else
         rowItemsArr[monthColName].split("@")[0]+"@in"
       end      
      else
        "0.00"
      end 
  end
  
  
  
  def getItemSPBalance(vchr_no, item)
    retVal = ""
    
    @rowItem = VoucherExtraData.find_by_voucher_no(vchr_no)
    if @rowItem != nil then
      valP = @rowItem.item_balances
      if valP != nil and valP != "" then
        arrItems = valP.split("@@")
        arrItems.each do |itm|
          if itm.split("=")[0] == item then
            retVal = itm.split("=")[1].split(" ")[0]
          end
        end
      end
    end
    retVal
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
       if dayP == "" then
          retVal = get_month_balance( firstRowItem[colName], dayP)
       else
          retVal = get_day_balance( firstRowItem[colName], dayP)
       end    
         
    end
    if retVal == nil or retVal == "" then
      retVal = Item.find_by_code(item_codeP).quantity_on_hand.to_s + "@in" 
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
