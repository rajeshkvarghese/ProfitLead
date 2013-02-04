function clickNextPrev(varId){
	if (document.getElementById(varId))
		document.getElementById(varId).click();	
	
}

function clickPrevShow(){
	if (document.getElementById("customers_previous"))
		document.getElementById("customers_previous").click();	
}

function saveCustomer(){
	if (document.getElementById("saveCustomer"))
		document.getElementById("saveCustomer").click();	
	
}

function saveLedger(){
	if (document.getElementById("saveLedger"))
		document.getElementById("saveLedger").click();	
	
}


function saveItem(){ 
	if (document.getElementById('saveItem'))
		document.getElementById('saveItem').click();	
	
}

function saveInvoice(){ 
	if (document.getElementById('saveInvoice'))
		document.getElementById('saveInvoice').click();	
	
}


function saveItemorder(){ 
	if (document.getElementById('saveItemorder'))
		document.getElementById('saveItemorder').click();		
}


function saveItemgroup(){ 
	if (document.getElementById('saveItemgroup'))
		document.getElementById('saveItemgroup').click();		
}


function deleteCustomer(){
	if (document.getElementById("deleteCustomer"))
		document.getElementById("deleteCustomer").click();		
}

function deleteItem(){
	if (document.getElementById("deleteItem"))
		document.getElementById("deleteItem").click();		
}

function deleteInvoice(){
	if (document.getElementById("deleteInvoice"))
		document.getElementById("deleteInvoice").click();		
}

function deleteItemorder(){
	if (document.getElementById("deleteItemorder"))
		document.getElementById("deleteItemorder").click();		
}

function deleteItemgroup(){
	if (document.getElementById("deleteItemgroup"))
		document.getElementById("deleteItemgroup").click();		
}


function openDocLinks(varId){
	if (document.getElementsByClassName("docLinksClass")[varId])
		document.getElementsByClassName("docLinksClass")[varId].click();
	
}


function openDocLinksNewWin(varId){		
	if (document.getElementsByClassName("docLinksClass")[varId])
		window.open(document.getElementsByClassName("docLinksClass")[varId].href,'docLinkWin'+varId)
	
}



function focusFilterBox(){ 
	var bFound = false;
	var all = document.getElementsByTagName("input");
	for(i=0; i < all.length; i++){
  		if (all[i].type != "hidden"){
    		if (all[i].disabled != true){
        		all[i].focus();
        		var bFound = true;
   			 }
 		 }
 	 if (bFound == true)
    	break;
	}	
}


function focusSelectBox(){ 
	var bFound = false;
	var all = document.getElementsByTagName("select");
	for(i=0; i < all.length; i++){
  		if (all[i].type != "hidden"){
    		if (all[i].disabled != true){
        		all[i].focus();
        		var bFound = true;
   			 }
 		 }
 	 if (bFound == true)
    	break;
	}	
}



function remove_fields_gen_journal(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").remove();  //hide();
  refreshColDrCr();
}




function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").remove();  //hide();
  refreshColTotal();
}



function remove_fields(link, trans, dr_cr) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").remove();  //hide();
  refreshColTotal(trans , dr_cr );
}

function add_fields(link, association, content) {
	
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().parent().parent().before(content.replace(regexp, new_id));
  //alert($(link).parent().parent().innerHTML);
  //alert('aaa'+$(".abc").innerHTML);
  //alert(gon.current_invoice_id);
  //$(".class_invoice_no input").val(gon.current_invoice_id)
  //$('[class = aa]').val('Save');
}


function add_fields_generaljournal(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().parent().parent().before(content.replace(regexp, new_id));
  //alert($(link).parent().parent().innerHTML);
  //alert('aaa'+$(".abc").innerHTML);
  //alert(gon.current_invoice_id);
  //$(".class_invoice_no input").val(gon.current_invoice_id)
  //$('[class = aa]').val('Save');
}


function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}


 //alert(document.getElementByName('customer_short_name').text); 
 
 
 

