//= require_directory ../keybindings
//= require mousetrap
//= require ./accountGroupCommonJS
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tabcustomersfromaccountgroup').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabcustomersfromaccountgroup').data('source')


jQuery ->
  $("#tabs").tabs(); 

 jQuery ->
     $(':input').addClass('mousetrap');


