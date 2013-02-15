$(document).ready(function() {
	$('#tabcustomers').dataTable( {
		"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay, aData, iDisplayIndex, iDisplayIndexFull  ) {
			/*
			 * Calculate the total market share for all browsers in this table (ie inc. outside
			 * the pagination)
			 */
			//alert('aaa')
			var iTotalMarket = 0;
			for ( var i=0 ; i<aaData.length ; i++ )
			{
				iTotalMarket += aaData[i][1]*1;
			}
			
			/* Calculate the market share for browsers on this page */
			
			var iPageMarket = 0;
			for ( var i=iStart ; i<iEnd ; i++ )
			{
				iPageMarket += aaData[ aiDisplay[i] ][1]*1;
			}
			
			
			//alert(iTotalMarket);
			
			/* Modify the footer row to match what we want */
			var nCells = nRow.getElementsByTagName('th');
			//alert(nCells[2].innerHTML);
			nCells[0].innerHTML = "<div  style = 'float:right'>Total Balance: "+ iTotalMarket.toFixed(2).toString()+"</div>";
			nCells[1].innerHTML = "<div  style = 'float:right'>Balanace on this Page: "+ iPageMarket.toFixed(2).toString()+"</div>";
			//this.fnDraw();		
			
		}		
		
		
	} );
} );

