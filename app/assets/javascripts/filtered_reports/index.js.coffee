
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tabcustomers').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabcustomers').data('source')
        
  
 jQuery ->
     $(':input').addClass('mousetrap');


