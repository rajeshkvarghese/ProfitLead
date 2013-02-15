class DynamicModel < ActiveRecord::Base
    
end


class FilteredReportsController < ApplicationController
  def index
    
    modelName = params[:modelname]
    filterConds = params[:filterconds]
    
    strFilterConds = ""
    if params[:filterconds] != "" then
     strFilterConds = " WHERE "+ params[:filterconds]
    end  
   
    @columnsWidth= params[:columnswidth].split(",")
    @columnsTitleDisp= params[:columnstitledisp].split(",")
    @columnsDisp= params[:columnsdisp].split(",")
   
    dateWise = params[:datewise]
    addColumns = params[:addcolumns].split(",")
    dateColumn = params[:datecolumn]
    DynamicModel.set_table_name(modelName)
    
   # logger.debug 'message'
     @remainCols = params[:columnsdisp].split(",")
   
     dateColumnP = dateColumn
     @firstLink = ""
   
   if dateWise == "month" then
        
      if   params[:filterconds] != "" then
          @filteredCondT = params[:filterconds]+" AND MONTH("+params[:datecolumn] +")="
      else
          @filteredCondT = " MONTH("+params[:datecolumn] +")="
      end
        
        
      @firstLink = filtered_reports_path + "?modelname="+params[:modelname]
      @firstLink = @firstLink + "&columnswidth="+ params[:columnswidth] +"&columnstitledisp="+params[:columnstitledisp]
      @firstLink = @firstLink + "&columnsdisp="+params[:columnsdisp]+"&datewise=day"+"&addcolumns="+params[:addcolumns]
      @firstLink = @firstLink + "&datecolumn="+params[:datecolumn]+"&filterconds="+ @filteredCondT
     
     # logger.debug '>>>>>>>>>> @firstLink = '+ @firstLink 
      
      @strAddCol = "SELECT MONTH("+ dateColumn + ") AS  dateColumnP , MONTHNAME(" + dateColumn +") AS "+ dateColumn
      @remainCols.delete_if {|item| item == dateColumn } 
      addColumns.each do |a| 
        @strAddCol = @strAddCol + ", SUM(" + a + ") AS "+ a
        @remainCols.delete_if {|item| item == a } 
      end
      if @remainCols.count > 0 then
        # logger.debug "!!!!!!!!!!!!"+@strAddCol+ ", "+ @remainCols.join(",") +" FROM  "+modelName+"  GROUP BY MONTH(journal_date); "
        @rowItems = DynamicModel.connection.execute(@strAddCol+ ", "+ @remainCols.join(",") +" FROM  "+modelName + strFilterConds +"  GROUP BY MONTH("+dateColumn+"); ")
      else
       # logger.debug "???????????????"
        @rowItems = DynamicModel.connection.execute(@strAddCol + " FROM  "+modelName + strFilterConds +"  GROUP BY MONTH("+dateColumn+"); ")
      end   
     # puts "Select SUM("+addColumns.split(",").join("), SUM(") +") from  "+modelName+" ;"
     
   else
     if  dateWise == "day" then
          
      if   params[:filterconds] != "" then
          @filteredCondT = params[:filterconds]+" AND DAY("+params[:datecolumn] +")="
      else
          @filteredCondT = " DAY("+params[:datecolumn] +")="
      end
      
        
      @firstLink = filtered_reports_path + "?modelname="+params[:modelname]
      @firstLink = @firstLink + "&columnswidth="+ params[:columnswidth] +"&columnstitledisp="+params[:columnstitledisp]
      @firstLink = @firstLink + "&columnsdisp="+params[:columnsdisp]+"&datewise=intraday"+"&addcolumns="+params[:addcolumns]
      @firstLink = @firstLink + "&datecolumn="+params[:datecolumn]+"&filterconds="+ @filteredCondT
     
      #logger.debug '>>>>>>>>>> @firstLink = '+ @firstLink 
           @strAddCol = "SELECT  DAY("+ dateColumn + ") AS  dateColumnP , DAY(" + dateColumn +") AS "+ dateColumn
           @remainCols.delete_if {|item| item == dateColumn } 
           addColumns.each do |a| 
              @strAddCol = @strAddCol + ", SUM(" + a + ") AS "+ a
              @remainCols.delete_if {|item| item == a } 
           end
           if @remainCols.count > 0 then
              # logger.debug "!!!!!!!!!!!!"+@strAddCol+ ", "+ @remainCols.join(",") +" FROM  "+modelName+"  GROUP BY MONTH(journal_date); "
              @rowItems = DynamicModel.connection.execute(@strAddCol+ ", "+ @remainCols.join(",") +" FROM  "+modelName+ strFilterConds +"  GROUP BY "+dateColumn+"; ")
           else
              # logger.debug "???????????????"
            @rowItems = DynamicModel.connection.execute(@strAddCol + " FROM  "+modelName+ strFilterConds +"  GROUP BY "+dateColumn+"; ")
          end   
          # puts "Select SUM("+addColumns.split(",").join("), SUM(") +") from  "+modelName+" ;"
       
        else
          
         if  dateWise == "intraday" then
            @firstLink = "entt"
            
          if params[:modelname] == "journal_entries" then  
            if strFilterConds != "" then
               if params["groupby"] != "" then
                  @rowItems = DynamicModel.select("trans_rec_pay_journal_id, generaljournal_id, invoice_id, id ,"+params[:columnsdisp]).group(params["groupby"]).where(filterConds)
                else
                  @rowItems = DynamicModel.select("trans_rec_pay_journal_id, generaljournal_id, invoice_id, id ,"+params[:columnsdisp]).where(filterConds)
               end     
            else
              @rowItems = DynamicModel.select("trans_rec_pay_journal_id, generaljournal_id,invoice_id, id ,"+params[:columnsdisp])
            end     
          #  if @rowItems.trans_rec_pay_journal_id != nil then
          #    DynamicModel.set_table_name("trans_rec_pay_journals")
          #  else
          #    DynamicModel.set_table_name("generaljournals")
          #  end      
          else
            if strFilterConds != "" then
              if params["groupby"] != "" then
                @rowItems = DynamicModel.select("id ,"+params[:columnsdisp]).group(params["groupby"]).where(filterConds)
              else
                @rowItems = DynamicModel.select("id ,"+params[:columnsdisp]).where(filterConds)
               end   
            else
              @rowItems = DynamicModel.select("id ,"+params[:columnsdisp])
            end      
          end  
          
       
       
      else
        if strFilterConds != "" then
           @rowItems = DynamicModel.select(params[:columnsdisp]).where(filterConds)
        else
           @rowItems = DynamicModel.select(params[:columnsdisp])
        end      
      end
      end
   end 
     
    
    
    #http://127.0.0.1:3000/filtered_reports?modelname=ledgers&columnstitledisp=A,%20b,c,D&columnsdisp=is_active,name,current_balance,dr_cr&columnswidth=10,50,30,10&filerconds=current_balance=0.0%20AND%20%20dr_cr='Dr'
    #http://127.0.0.1:3000/filtered_reports?modelname=journal_entries&columnstitledisp=A,C&columnsdisp=trans_type,master_leg&columnswidth=50,50&filerconds=trans_type='Bank%20Current%20Account'%20AND%20journal_date%3E'2013-01-17'
  end
  
  
  
  def catDateWise(rowItemsP, dateWiseP )
    
    
  end
  
  
 
  
  def show
    
  end
  
  
end
