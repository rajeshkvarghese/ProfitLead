//= require_directory ../keybindings
//= require mousetrap
//= require_directory ../jqueryDataTable

jQuery ->
  $('#tabitems').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false 
    #bJQueryUI: true
    sAjaxSource: $('#tabitems').data('source')



 jQuery ->
     $(':input').addClass('mousetrap');
