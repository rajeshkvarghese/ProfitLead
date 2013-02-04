class AccountgroupsController < ApplicationController
   def liabiltyTree
    
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

          getChildGroups("_Liability", @accntGrpId.id.to_s)  
   while @@ulCounter > @@childInd 
        @@rethtmlGroups = @@rethtmlGroups + "</ul>"
 
        @@ulCounter = @@ulCounter - 1
    
        @@ulCounter = 0
    
    end
    
    puts @@ulCounter.to_s
    
    
     @@rethtmlGroups =  @@rethtmlGroups + "</ul>"
 
    
    @liabilityHTML=@@rethtmlGroups 
    
  end
end