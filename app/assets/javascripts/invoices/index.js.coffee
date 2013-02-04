
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tabinvoices').dataTable 
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabinvoices').data('source') 
        
  
 jQuery ->
     $(':input').addClass('mousetrap');


