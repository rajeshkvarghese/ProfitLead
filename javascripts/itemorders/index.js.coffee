
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tabitemorders').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabitemorders').data('source')
        
  
 jQuery ->
     $(':input').addClass('mousetrap');


