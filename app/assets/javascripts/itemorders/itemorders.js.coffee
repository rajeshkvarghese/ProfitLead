# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



jQuery ->
  $('#tabitemorders').dataTable
    sPaginationType: "full_numbers"
    bScrollAutoCss: false
    #bJQueryUI: true
    sAjaxSource: $('#tabitemorders').data('source')
    
          
jQuery ->
     $(':input').addClass('mousetrap');
 

 # $(":customer_id").value = 222
  
  
     
#jQuery ->
 #   $(':invoice_id').text = 1
