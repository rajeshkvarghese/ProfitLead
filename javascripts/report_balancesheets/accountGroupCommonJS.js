function interChangeIFrames(){
	varT = parent.window.frames[0].location; 
	parent.window.frames[0].location = parent.window.frames[1].location;
	 parent.window.frames[1].location = varT;
}


function showLedgerAccountGroup(ledgerPath, ledgerName){
	//alert(ledgerPath);
	
	var a = parent.window.frames[0].document.getElementsByClassName("selectIndicator");
	for (var i = 0; i < a.length; i++){
		a[i].innerHTML = "";
		//alert(a[i].innerHTML.lastIndexOf('&lt;&lt;'));
		//if (a[i].innerHTML.lastIndexOf('&lt;')==)
		//a[i].innerHTML = "777";
	}	
	parent.window.frames[0].document.getElementById(ledgerName).innerHTML = parent.window.frames[0].document.getElementById(ledgerName).innerHTML+"&nbsp;<font face = 'impact' color = blue size = '2'><b>&lt;</b></font>"
	
	window.open(ledgerPath, 'accountGroupLedgerWin');
}

function accGroupLedgersMaximize(){
	
	document.getElementById('accGroup').style.display = 'none';
	document.getElementById('max').style.display =  'none';
	//parent.window.frames[0].style.display =  'none';
	document.getElementById('min').style.display =  'block';
}

function accGroupLedgersMinimize(){
	
	document.getElementById('accGroup').style.display = 'block';
	document.getElementById('max').style.display =  'block';
	document.getElementById('min').style.display =  'none';
}



function showLedgersFromAccountGroups(){
	var elemShowLedgers = parent.window.frames[1].document.getElementById('showLedgersFromAccountGroups')
	if (elemShowLedgers.style.display == "none")
		elemShowLedgers.style.display = "block";
	else
		elemShowLedgers.style.display = "none"	
	
}


function refreshGroupTree(){
	//alert(action)
	parent.window.frames[0].location.reload();
}


function createNewChildGroup(pathNewAccountGroup, parGroupId){
	
	//alert(pathNewAccountGroup + '?parGroupId='+parGroupId);
	parent.window.frames[1].location = pathNewAccountGroup +'?parGroupId='+parGroupId
	//alert(parent.window.frames[1].location);
	//parent.window.frames[1].document.forms.accountgroup_parent_group.value = parGroupId.to_s;
		
}


function newLedgerFromAccountGroup(pathNewCustomerPath, parGroupId){
	//parGroupId = "Tomy"
	newWin = window.open(pathNewCustomerPath + "?parGroupId="+parGroupId, 'newLedgerFromAccGroups');
	//parent.window.location.href = pathNewCustomerPath;
	
}



function showAccountGroup(idParent, curObj){
	
	//alert(curObj.name)
	//alert(idParent);
//	alert(document.getElementByName(curObj.name).outerHTML)
	//alert(curObj.outerHTML);
	//$('#accGrpContent').prop('src', 'ibm.com')
	//loadIframe('accGrpContent', './accountgroups/'+idParent.to_s );
	//loadIframe("accGrpContent", './accountgroups/2' );
	//alert(document.getElementById('cnt').outerHTML)
	//document.getElementById('cnt').innerHTML = '23432423324';
	//alert(parent.window.frames[0].location);
	//alert(parent.window.frames[0].document.getElementById(idParent).innerHTML);
	var a = parent.window.frames[0].document.getElementsByClassName("selectIndicator");
	for (var i = 0; i < a.length; i++){
		a[i].style.backgroundColor = "#ffffff"; //innerHTML = "";
		//alert(a[i].innerHTML.lastIndexOf('&lt;&lt;'));
		//if (a[i].innerHTML.lastIndexOf('&lt;')==)
		//a[i].innerHTML = "777";
	}	
	//parent.window.frames[0].document.getElementById(idParent).innerHTML = parent.window.frames[0].document.getElementById(idParent).innerHTML+"&nbsp;<font face = 'impact' color = blue size = '2'><b>&lt;</b></font>"
	parent.window.frames[0].document.getElementById(idParent).style.backgroundColor = "brown";
	parent.window.frames[1].location= './accountgroups/'+ idParent
	//var firstIframe = document.getElementById('accGrpNavTree');
	//if (firstIframe){
	//	var tabl = getParentByTagName(curObj, '<table>');
	//	alert(tabl.innerHTML)
	//var secIframe = tabl.getElementsByTagName('tr')[0].getElementsByTagName('td')[1]
	//secIframe.innerHTML = 'adfasdasd'
	//}
	//document.getElementById('accGrpContent').src = 'ibm.com'
}


function loadIframe(iframeName, url) {
	alert('444 '+iframeName + "   "+ url)
    var $iframe = $('#' + iframeName);
    if ( $iframe.length ) {
    	alert('y')
        $iframe.attr('src',url);   
        return false;
    }
    return true;
}

function getParentByTagName(obj, tag){
	var obj_parent = obj.parentNode;
	alert(obj_parent.innerHTML)
	if (!obj_parent) return false;
		if (obj_parent.tagName.toLowerCase() == tag) 
			return obj_parent;
		else
			getParentByTagName(obj_parent, tag)	
		
}