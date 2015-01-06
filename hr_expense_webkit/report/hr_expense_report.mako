<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
	%for o in objects :
		<br/>
		<br/>
		<center><h3>HR Expenses</h3></center>
		<center><h4>${o.name or '' | entity}</h4></center>
		
		<table class="basic_table" width="90%" align="center">
			<tr>
		         <td width="25%"><b>${_("Employee")}</b></td>
		         <td width="25%"><b>${_("Date")}</b></td>
		         <td width="25%"><b>${_("Description")}</b></td>
		         <td width="25%"><b>${_("Validated By")}</b></td>
      		</tr>
        	<tr>
		         <td>${o.employee_id.name or ''|entity}</td>
		         <td>${formatLang(o.date,date=True) or ''|entity}</td>
		         <td>${o.name or '' |entity}</td>
		         <td>${o.user_valid.name or ''|entity}</td>
      		</tr>
    	</table>
      	<br />
    	<table class="list_table"  width="100%">
    		<thead>
    			<tr>
	    			<th style="text-align:left;">${_("Date")}</th>
	    			<th style="text-align:left;">${_("Name")}</th>
	    			<th style="text-align:left;">${_("Ref.")}</th>
	    			<th style="text-align:right;">${_("Unit Price")}</th>
	    			<th style="text-align:right;" >${_("Qty")}</th>
	    			<th style="text-align:right;" >${_("Price")}</th>
    			</tr>
    		</thead>
    		%for line in o.line_ids :
    			<tbody>
            	<tr>
	                <td style="text-align:left;" width="10%">${formatLang(line.date_value,date=True)}</td>
	                <td style="text-align:left;" width="36%">${line.name or ''|entity}${line.description or ''|entity}</td>
	                <td style="text-align:right;" width="10%">${line.ref or '' |entity}</td>
	                <td style="text-align:right;" width="10%">${formatLang(line.unit_amount) or 0.0 |entity}</td>
	                <td style="text-align:right;" width="12%">${formatLang(line.unit_quantity) or 0.0 |entity}</td>
	                <td style="text-align:right;" width="12%">${formatLang(line.total_amount, currency_obj=o.currency_id) or 0.0 |entity}</td>
            	</tr>
            	%if line.analytic_account and line.analytic_account.complete_name:
            		<tr>
	            		<td style="border-style:none"/>
	            		<td style="border-style:none;text-align:left;font-size:10px"><i>${line.analytic_account and line.analytic_account.complete_name or '' |entity}</i></td>
	            		<td style="border-style:none"/>
	            		<td style="border-style:none"/>
	            		<td style="border-style:none"/>
	            		<td style="border-style:none"/>
            		</tr>
				%endif
            %endfor
            	<tr>
            		<td style="border-style:none"/>
            		<td style="border-style:none"/>
            		<td style="border-style:none"/>
            		<td style="border-style:none"/>
            		<td style="border-top:1px solid"><b>Total:</b></td>
            		<td style="border-top:1px solid;text-align:right">${formatLang(o.amount, digits=get_digits(dp='Account') , currency_obj=o.currency_id)}
            		</td>
            	</tr>
            	</tbody>
    	</table>
    	<br/><br/>
    	%if o.note:
    		${ o.note or '' | entity} <br/>
    	%endif
    		${_("Certified honest and conform,")} <br/>
    		${_("(Date and signature)")} <br/><br/>
    		${_("This document must be dated and signed for reimbursement")}
    	
    	<p style="page-break-after:always"></p>
	%endfor	
</body>
</html>