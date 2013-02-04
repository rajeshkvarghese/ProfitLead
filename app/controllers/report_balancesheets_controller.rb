class ReportBalancesheetsController < ApplicationController
  def index
    
  end
  def show
    
  end
  
  
  
  def spaceMe(num)
    ret = ""
    num.times { ret = ret + "&nbsp;" }
    "<font size = '1'>" + ret + "</font>"
  end
  
  def getGroupTotal(nameGroup, idGroup, dr_cr)
    
      @ledgerFind = Ledger.find_all_by_group(nameGroup)
      @ledgerFind.each do |ldg|
        if dr_cr == ldg.dr_cr  then
          @@grpTotal = @@grpTotal + ldg.current_balance
        else
          @@grpTotal = @@grpTotal - ldg.current_balance
        end    
      end   
      
      @grpFind = Accountgroup.find_all_by_parent_group(idGroup)
      if @grpFind.count > 0 then
        @grpFind.each do |grp|
          getGroupTotal(grp.group_name, grp.id, dr_cr)
        end
      end
        @@grpTotal = @@grpTotal
  end    
    
  def assetTree
    
     
      @@childInd = -1
      @@childCount = []
      @@rethtmlGroups = ""
      @@ulCounter = 0
      @accountgroupsTree = Accountgroup.find_all_by_parent_group(nil) 
      @accountgroupsTree = @accountgroupsTree.concat(Accountgroup.find_all_by_parent_group("")) 
      @accountgroupsTree = @accountgroupsTree.sort_by { |hsh| hsh[:group_name] }
      accGrpArr = []

      @@topCount = @accountgroupsTree.count

   
     @accntGrpId = Accountgroup.find_by_group_name("_Asset")

       getChildGroups("_Asset", @accntGrpId.id.to_s, "Dr")  
    while @@ulCounter > @@childInd + 1
        @@rethtmlGroups = @@rethtmlGroups + "</ul>"
 
        @@ulCounter = @@ulCounter - 1
    
        @@ulCounter = 0
    
    end
    
      puts @@ulCounter.to_s
    
    
      @@rethtmlGroups =  @@rethtmlGroups + "</ul>"
 
    
      @assetHTML=@@rethtmlGroups 
  end
  
  
  
  def liabilityTree
    
     @@childInd = -1
    @@childCount = []
    @@rethtmlGroups = ""
    @@ulCounter = 0
    @accountgroupsTree = Accountgroup.find_all_by_parent_group(nil) 
    @accountgroupsTree = @accountgroupsTree.concat(Accountgroup.find_all_by_parent_group("")) 
    @accountgroupsTree = @accountgroupsTree.sort_by { |hsh| hsh[:group_name] }
    accGrpArr = []

    @@topCount = @accountgroupsTree.count

   
   @accntGrpId = Accountgroup.find_by_group_name("_Liability")

          getChildGroups("_Liability", @accntGrpId.id.to_s, "Cr")  
   while @@ulCounter > @@childInd 
        @@rethtmlGroups = @@rethtmlGroups + "</ul>"
 
        @@ulCounter = @@ulCounter - 1
    
        @@ulCounter = 0
    
    end
    
    puts @@ulCounter.to_s
    
    @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:alert(\"hi\")'><b>"+"parentGroupName" +"</b></a> "<<  "  <div style='float:right;' id = " +" idParent.to_s" + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  "getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s"  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></span>"
    @@rethtmlGroups = @@rethtmlGroups + "<ul style='display: none;'>"
    @@rethtmlGroups =  @@rethtmlGroups + "</ul>"
 
    
    @liabilityHTML=@@rethtmlGroups 
  end
  
  
  
  
  
  
  def getChildGroups(parentGroupName, idParent, dr_crPs)   
    
    
    @@grpTotal = 0
   
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
                                     
                  @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName +"</b></a> "<<  "  <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent,dr_crPs ).to_s  <<  if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></span>"
             
                @@childCount[@@childInd] = @@childCount[@@childInd] - 1   
                               
            else
                         
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable'><div class='hitarea expandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a> "<<   " <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></span>"
              
               @@childCount[@@childInd] = @@childCount[@@childInd] - 1               
            end
            
          else
              if parentGroupName == "_Liability" or parentGroupName == "_Asset" then
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b><font size = '3'>&nbsp;&nbsp;&nbsp;"+parentGroupName +"&nbsp;&nbsp;&nbsp;</font></b></a>" <<  " <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<  spaceMe(5) << "</b></div></div></span>"
              else              
                @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><div id = " << idParent.to_s << " ><b>"+parentGroupName +"</b></div></a>  <div  id = 1" + idParent.to_s + " class = 'selectIndicator'></div> <div style=\'float:right;\'><div style=\'float:left;\'>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<  spaceMe(5) << "</div></div></span>"
              end  
          end
          
       
           
           @@rethtmlGroups = @@rethtmlGroups + "<ul style='display: none;'>"
           @@ulCounter = @@ulCounter + 1
           
          @@childInd = @@childInd + 1    
          @@childCount << @childGroupsT.count    
          
          
         if  @accGroupLedgersT.count > 0 then
                 @accGroupLedgersT.each do |accLedgT|  
                      @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('"+ ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'><div style = 'float:left'>"+ accLedgT.name + '</div></a></font><div  id = ledger_' + accLedgT.id.to_s + ' class = "selectIndicator"></div>&nbsp;&nbsp;&nbsp;<div style=\'float:right;\'><div style=\'float:left;\'>'+accLedgT.current_balance.to_s + spaceMe(50) + "</b></small></div></div></i></li>"
                 end
          end
        
      
          @childGroupsT.each do |accGrpTC|   
            # @@childCount[@@childInd] = @@childCount[@@childInd] - 1                                                                                                                                            #    @@arrChildGrpsTemp.push accGrpTC.parent_group << "&&&" <<accGrpTC.group_name      
             getChildGroups(accGrpTC.group_name, accGrpTC.id.to_s, dr_crPs)  
          end
     else 
     
       
         begin 
            if @@childCount[@@childInd] < 2 then 
          
                #puts "@@@@parentGroupName=>" + parentGroupName
               # puts "@@childInd " + @@childInd.to_s
               # puts "@@childCount" + @@childCount.to_s
           
              
                if  @accGroupLedgersT.count > 0 then
                  # @@rethtmlGroups = @@rethtmlGroups + "<li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName+"</b></a><div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div></li></span>"
                   @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable lastExpandable'><div class='hitarea expandable-hitarea lastExpandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName +"</b></a> "<<  "  <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></span>"
                   @@rethtmlGroups = @@rethtmlGroups +  "<ul style='display: none;'>"
                     @counterInd = 0;
                   @accGroupLedgersT.each do |accLedgT|  
                       @counterInd = @counterInd + 1
                       if @counterInd >= @accGroupLedgersT.length then
                            @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'><div style = 'float:left'>"+ accLedgT.name + '</div></a></font><div  id = ledger_' + accLedgT.id.to_s + ' class = "selectIndicator"></div>&nbsp;&nbsp;&nbsp;<div style=\'float:right;\'><div style=\'float:left;\'>'+accLedgT.current_balance.to_s + spaceMe(50) + "</b></small></div></div></i></li>"
                         else  
                            @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'><div style = 'float:left'>"+ accLedgT.name + '</div></a></font><div  id = ledger_' + accLedgT.id.to_s + ' class = "selectIndicator"></div>&nbsp;&nbsp;&nbsp;<div style=\'float:right;\'><div style=\'float:left;\'>'+accLedgT.current_balance.to_s + spaceMe(50) + "</b></small></div></div></i></li>"
                        end 
                   end
                    @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                else
                     @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+parentGroupName+"</b></a>  "<<  "  <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></li>"
                end
                 
                if  @@childInd != 0 then
                   @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                end   
           
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
                  
                   # @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                       puts "</ul>"
                       @@ulCounter = @@ulCounter - 1 
                   #end
                   @@childCount.pop   
                   @@childInd = @@childInd - 1 
                end
             end  
          else          
             
               if  @accGroupLedgersT.count > 0 then
                    @@rethtmlGroups = @@rethtmlGroups + " <li class='expandable'><div class='hitarea expandable-hitarea'></div><span><a href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a>  "<<  "  <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></span>"
                    @@rethtmlGroups = @@rethtmlGroups +  "<ul style='display: none;'>"
                    @counterInd = 0;
                    @accGroupLedgersT.each do |accLedgT|  
                         @counterInd = @counterInd + 1
                         if @counterInd >= @accGroupLedgersT.length then
                            @@rethtmlGroups = @@rethtmlGroups + "<li class='last'><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'><div style = 'float:left'>"+ accLedgT.name + '</div></a></font><div  id = ledger_' + accLedgT.id.to_s + ' class = "selectIndicator"></div>&nbsp;&nbsp;&nbsp;<div style=\'float:right;\'><div style=\'float:left;\'>'+accLedgT.current_balance.to_s + spaceMe(50) + "</b></small></div></div></i></li>"
                         else                         
                            @@rethtmlGroups = @@rethtmlGroups + "<li><i> <a  href=javascript:showLedgerAccountGroup('" << ledger_path(accLedgT) << "','" << "ledger_" + accLedgT.id.to_s << "')><small><b><font color = 'green'><div style = 'float:left'>"+ accLedgT.name + '</div></a></font><div  id = ledger_' + accLedgT.id.to_s + ' class = "selectIndicator"></div>&nbsp;&nbsp;&nbsp;<div style=\'float:right;\'><div style=\'float:left;\'>'+accLedgT.current_balance.to_s + spaceMe(50) + "</b></small></div></div></i></li>"
                         end
                    end
                  
                       @@rethtmlGroups = @@rethtmlGroups + "</ul>"
                   
                
                else
                      @@rethtmlGroups = @@rethtmlGroups + "<li> <a  href='javascript:showAccountGroup("+idParent.to_s+", this)'><b>"+ parentGroupName +"</b></a> "<<   "  <div style='float:right;' id = " + idParent.to_s + " class = 'selectIndicator'> </div><div style=\'float:right;\'><div style=\'float:left;\'><b>" <<  getGroupTotal(parentGroupName,idParent, dr_crPs ).to_s  <<   if @@childInd == 0 then spaceMe(25) else spaceMe(50) end  << "</b></div></div></li>"  
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
  
  
  
  
  
  
  
end
