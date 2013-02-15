
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable
//= require ./datatableColTot

jQuery ->
  $('#tabcustomers').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabcustomers').data('source')
    bRetrieve: true   
        
  
 jQuery ->
     $(':input').addClass('mousetrap');


