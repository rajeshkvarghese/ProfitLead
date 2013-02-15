//= require_directory ../jquery
//= require_directory ../jqueryUI
//= require_directory ../jqueryCookie
//= require_directory ../jqueryTreeView
//= require_directory ../keybindings
//= require mousetrap
//= require ./accountGroupCommonJS

        



jQuery ->
      $("#tree").treeview({
        collapsed: true,
        animated: "fast",
        control:"#sidetreecontrol",
        prerendered: true,
        persist: "location"
      });

        
  
 jQuery ->
     $(':input').addClass('mousetrap');


    

      

