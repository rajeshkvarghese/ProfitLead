
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable
//= require ./datatableColTot

jQuery ->
  $('#tabtranspayrecjournal').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false    
    #bJQueryUI: true
    sAjaxSource: $('#tabtranspayrecjournal').data('source')
    bRetrieve: true   
  
 jQuery ->
     $(':input').addClass('mousetrap');




