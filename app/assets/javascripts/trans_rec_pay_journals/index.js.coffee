
//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tab_trans_pay_rec_journals').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tab_trans_pay_rec_journals').data('source')
        
  
 jQuery ->
     $(':input').addClass('mousetrap');


