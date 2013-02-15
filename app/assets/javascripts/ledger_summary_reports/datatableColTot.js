$(document).ready(function() {
	$('#tabcustomers').dataTable( {
		
		// "aaSorting": [[ 2, "asc" ]]
		
		"fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay, aData, iDisplayIndex, iDisplayIndexFull  ) {
			/*
			 * Calculate the total market share for all browsers in this table (ie inc. outside
			 * the pagination)
			 */
			//alert(location.href)
			var textCol = 0;
			var drcol = 1;
			var crcol = 2;
			if (location.href.indexOf("ledger_summary_reports?datewise=voucherwise") != -1 ){
				textCol = 5;
				drcol = 6;
				crcol = 7;
			}
			
			var drTotFull = 0;
			for ( var i=0 ; i<aaData.length ; i++ )
			{
				drTotFull += aaData[i][drcol]*1;
			}
			
			var crTotFull = 0;
			for ( var i=0 ; i<aaData.length ; i++ )
			{
				crTotFull += aaData[i][crcol]*1;
			}
			
			
			/* Calculate the market share for browsers on this page */
			
			var drTotPage = 0;
			for ( var i=iStart ; i<iEnd ; i++ )
			{
				drTotPage += aaData[ aiDisplay[i] ][drcol]*1;
			}
			
			var crTotPage = 0;
			for ( var i=iStart ; i<iEnd ; i++ )
			{
				crTotPage += aaData[ aiDisplay[i] ][crcol]*1;
			}
			
			
			//alert(iTotalMarket);
			
			/* Modify the footer row to match what we want */
			var nCells = nRow.getElementsByTagName('th');
			//alert(nCells[2].innerHTML);
			nCells[textCol].innerHTML =  "TOTAL"
			
			nCells[drcol].innerHTML =  drTotPage.toFixed(2).toString()+" ("+drTotFull.toFixed(2).toString()+")" ;
			nCells[crcol].innerHTML =  crTotPage.toFixed(2).toString()+" ("+crTotFull.toFixed(2).toString()+")" ;
			
			//nCells[drcol].innerHTML = "<div  style = 'float:right'>Total Balance: "+ iTotalMarket.toFixed(2).toString()+"</div>";
			//nCells[crcol].innerHTML = "<div  style = 'float:right'>Balanace on this Page: "+ iPageMarket.toFixed(2).toString()+"</div>";
			//this.fnDraw();		
			
		}		
		
		
	} );
} );

