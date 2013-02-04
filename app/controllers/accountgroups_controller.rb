class AccountgroupsController < ApplicationController
  #layout 'application', :except => :index 
  # GET /accountgroups
  # GET /accountgroups.json
  
 
  
  
  
  
  def report_balancesheet  
   # @accountgroups = Accountgroup.all

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accountgroups }
    end
  end
  
  
  def listAccountGroups
    
    
  end
  
  def getChildGroups(parentGroupName, idParent)   
   
     @childGroupsT = Accountgroup.find_all_by_parent_group(idParent.to_s)     
     @childGroupsT = @childGroupsT.sort_by { |hsh| hsh[:group_name] }
     
     @accGroupLedgersT = Ledger.find_all_by_group(parentGroupName)
     @accGroupLedgersT = @accGroupLedgersT.sort_by { |hsh| hsh[:group] }
         
   #  puts "parentGroupName = " + parentGroupName
   #  puts "@@childInd " + @@childInd.to_s
   #  puts "@@childCount" + @@childCount.to_s 
    
     if @childGroupsT.count > 0  then         
      
            
          if @@childInd > -1 then
                       
            if @@childCount[@@childInd] < 2 then
                                     
                  @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
             
                @@childCount[@@childInd] = @@childCount[@@childInd] - 1   
                               
            else
                         
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable'><div class='hitarea expandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
              
               @@childCount[@@childInd] = @@childCount[@@childInd] - 1               
            end
            
          else
              if parentGroupName == "Account Groups" then
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b><font size = '3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+parentGroupName +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
              else              
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
              end  
          end
          
           @@rethtmlGroups = @@rethtmlGroups + "<ul style='display: none;'>"
           @@ulCounter = @@ulCounter + 1
           
          @@childInd = @@childInd + 1    
          @@childCount << @childGroupsT.count    
          
          
         if  @accGroupLedgersT.count > 0 then
                 @accGroupLedgersT.each do |accLedgT|  
                      @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('"+ ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'>"+ accLedgT.name + '</font>&nbsp;&nbsp;&nbsp;('+accLedgT.current_balance.to_s + '&nbsp;'+ accLedgT.dr_cr + ".)</b></small></a><div style='float:right;' id = ledger_" + accLedgT.id.to_s + " class = 'selectIndicator'> </div></i></li>"
                 end
          end
        
      
          @childGroupsT.each do |accGrpTC|   
            # @@childCount[@@childInd] = @@childCount[@@childInd] - 1                                                                                                                                            #    @@arrChildGrpsTemp.push accGrpTC.parent_group << "&&&" <<accGrpTC.group_name      
             getChildGroups(accGrpTC.group_name, accGrpTC.id.to_s)  
          end
     else 
     
       
         begin 
            if @@childCount[@@childInd] < 2 then 
          
                #puts "@@@@parentGroupName=>" + parentGroupName
               # puts "@@childInd " + @@childInd.to_s
               # puts "@@childCount" + @@childCount.to_s
           
              
                if  @accGroupLedgersT.count > 0 then
                  # @@rethtmlGroups = @@rethtmlGroups + "<li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName+"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></li></span>"
                   @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
                   @@rethtmlGroups = @@rethtmlGroups +  "<ul style='display: none;'>"
                     @counterInd = 0;
                   @accGroupLedgersT.each do |accLedgT|  
                       @counterInd = @counterInd + 1
                       if @counterInd >= @accGroupLedgersT.length then
                            @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'>"+ accLedgT.name + '</font>&nbsp;&nbsp;&nbsp;('+accLedgT.current_balance.to_s + '&nbsp;'+ accLedgT.dr_cr + ".)</b></small></a><div style='float:right;' id = ledger_" + accLedgT.id.to_s + " class = 'selectIndicator'> </div></i></li>"
                         else  
                            @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'>"+ accLedgT.name + '</font>&nbsp;&nbsp;&nbsp;('+accLedgT.current_balance.to_s + '&nbsp;'+ accLedgT.dr_cr + ".)</b></small></a><div style='float:right;' id = ledger_" + accLedgT.id.to_s + " class = 'selectIndicator'> </div></i></li>"
                        end 
                   end
                    @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                else
                     @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName+"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></li>"
                end
                 
           
                @@rethtmlGroups = @@rethtmlGroups + "</ul>"
           
              if  @@childInd > 0 then
                
                @@childInd = @@childInd - 1  
                @@childCount.pop
       
              #  @@rethtmlGroups =   @@rethtmlGroups +  "  111@@childInd " + @@childInd.to_s+"  111@@childCount" + @@childCount.to_s
                
                 while @@childInd > 1 and @@childCount[@@childInd] < 1 
             
                  
             
                  # if @@ulCounter > 0 then
                       @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                     #  puts "</ul>"
                       @@ulCounter = @@ulCounter - 1 
                   #end
                   @@childCount.pop   
                   @@childInd = @@childInd - 1 
                  
                      
                  # puts "@@childCount=>"+ @@childCount.to_s                     
                end
                if  @@childInd == 1 and @@childCount[@@childInd] < 1 then
                    @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                     #  puts "</ul>"
                       @@ulCounter = @@ulCounter - 1 
                   #end
                   @@childCount.pop   
                   @@childInd = @@childInd - 1 
                end
             end  
          else          
             
               
               
               if  @accGroupLedgersT.count > 0 then
                    @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable'><div class='hitarea expandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></span>"
                    @@rethtmlGroups = @@rethtmlGroups +  "<ul style='display: none;'>"
                    @counterInd = 0;
                    @accGroupLedgersT.each do |accLedgT|  
                         @counterInd = @counterInd + 1
                         if @counterInd >= @accGroupLedgersT.length then
                            @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'>"+ accLedgT.name + '</font>&nbsp;&nbsp;&nbsp;('+accLedgT.current_balance.to_s + '&nbsp;'+ accLedgT.dr_cr + ".)</b></small></a><div style='float:right;' id = ledger_" + accLedgT.id.to_s + " class = 'selectIndicator'> </div></i></li>"
                         else                         
                            @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'>"+ accLedgT.name + '</font>&nbsp;&nbsp;&nbsp;('+accLedgT.current_balance.to_s + '&nbsp;'+ accLedgT.dr_cr + ".)</b></small></a><div style='float:right;' id = ledger_" + accLedgT.id.to_s + " class = 'selectIndicator'> </div></i></li>"
                         end
                    end
                    @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                
                else
                      @@rethtmlGroups = @@rethtmlGroups + "<li> <a  href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></li>"  
                end
               
                   
               puts "!!!!==parentGroupName=>" + parentGroupName
               puts "@@childInd " + @@childInd.to_s
               puts "@@childCount" + @@childCount.to_s
               @@childCount[@@childInd] = @@childCount[@@childInd] - 1   
          end 
          
          
          
          
          rescue  
      end  
   
   
   
   
     end  
     
  end  
  
  
  
   
  def index  
    
    
    @@childInd = -1
    @@childCount = []
    @@rethtmlGroups = ""
    @@ulCounter = 0
    @accountgroupsTree = Accountgroup.find_all_by_parent_group(nil) 
    @accountgroupsTree = @accountgroupsTree.concat(Accountgroup.find_all_by_parent_group("")) 
    @accountgroupsTree = @accountgroupsTree.sort_by { |hsh| hsh[:group_name] }
    accGrpArr = []

    @@topCount = @accountgroupsTree.count

   
   @accntGrpId = Accountgroup.find_by_group_name("Account Groups")

          getChildGroups("Account Groups", @accntGrpId.id.to_s)  
       while @@ulCounter > @@childInd 
        @@rethtmlGroups = @@rethtmlGroups + "</ul>"
 
        @@ulCounter = @@ulCounter - 1
    
        @@ulCounter = 0
    
    end
    
    puts @@ulCounter.to_s
    
    
     @@rethtmlGroups =  @@rethtmlGroups + "</ul>"
 
    
    @acctreeHTML=@@rethtmlGroups 
    
  
    
    #@accountgroups = Accountgroup.all

    
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accountgroups }
    end
  end

  
  

  # GET /accountgroups/1
  # GET /accountgroups/1.json
  def show
    @accountgroup = Accountgroup.find(params[:id])
    gon.parentGroupId = @accountgroup.id;
    
    @ledgers = Ledger.find_all_by_group(@accountgroup.group_name) 
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accountgroup }
    end
  end

  # GET /accountgroups/new
  # GET /accountgroups/new.json
  def new
    @accountgroup = Accountgroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accountgroup }
    end
  end

  # GET /accountgroups/1/edit
  def edit
    @accountgroup = Accountgroup.find(params[:id])
  end

  # POST /accountgroups
  # POST /accountgroups.json
  def create
    @accountgroup = Accountgroup.new(params[:accountgroup])

    respond_to do |format|
      if @accountgroup.save
        format.html { redirect_to @accountgroup, notice: 'Accountgroup was successfully created.' }
        format.json { render json: @accountgroup, status: :created, location: @accountgroup }
      else
        format.html { render action: "new" }
        format.json { render json: @accountgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accountgroups/1
  # PUT /accountgroups/1.json
  def update
    @accountgroup = Accountgroup.find(params[:id])

    respond_to do |format|
      if @accountgroup.update_attributes(params[:accountgroup])
        format.html { redirect_to @accountgroup, notice: 'Accountgroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accountgroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountgroups/1
  # DELETE /accountgroups/1.json
  def destroy
    @accountgroup = Accountgroup.find(params[:id])
    @accountgroup.destroy

#
 #   respond_to do |format|
  #   format.html { redirect_to accountgroups_url }
   #   format.json { head :no_content }
    #end
    
 
  end
end
