//= require_directory ../keybindings
//= require mousetrap
//= require ./trans_rec_pay_journals_form
//= require_directory ../jqueryDataTable



 jQuery ->
     $(':input').addClass('mousetrap');
     
 jQuery ->
  $('#tabtranspayrecjournal').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false
    #bJQueryUI: true
    sAjaxSource: $('#tabtranspayrecjournal').data('source')   

