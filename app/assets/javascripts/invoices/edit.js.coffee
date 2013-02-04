//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable
//= require ./InvoiceForm


  
jQuery ->
  $('#tabinvoices_itemorders').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false
    #bJQueryUI: true
    sAjaxSource: $('#tabinvoices_itemorder').data('source')   
   
           