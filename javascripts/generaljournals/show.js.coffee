
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable
//= require ./datatableColTot

jQuery ->
  $('#tabgeneraljournal').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false    
    #bJQueryUI: true
    sAjaxSource: $('#tabgeneraljournal').data('source')
    bRetrieve: true   
  
 jQuery ->
     $(':input').addClass('mousetrap');




