//= require_directory ../keybindings
//= require mousetrap
//= require ./InvoiceForm
//= require_directory ../jqueryDataTable


  
jQuery ->
  $('#tabinvoices_itemorders').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false
    #bJQueryUI: true
    sAjaxSource: $('#tabinvoices_itemorder').data('source')   
   
           