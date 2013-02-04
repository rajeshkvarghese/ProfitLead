# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


//= require_directory ../jqueryDataTable
//= require_directory ../keybindings
//= require_directory .

jQuery ->
  $('#tabitemgroups').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false
    #bJQueryUI: true
    sAjaxSource: $('#tabitemgroups').data('source')
    
   
        
  
 jQuery ->
     $(':input').addClass('mousetrap');
      

   