<html>

	<head>
	    <style type="text/css">
	        ${css}
	    </style>
	</head>

	<body>
		%for o in objects:
			<br/>
			<br/>
			<center><h2>Invoice rate by user</h2></center>
			<br/>
			<br/>
			<table class="basic_table" width="100%" align="center">
				<tr>
					<td width="40%">
						<b>${_("Period from startdate")} </b>
					</td>
					<td width="30%">
						<b>${_("Period to enddate")}</b>
					</td>
					<td width="30%">
						<b>${_("Currency")} </b>
					</td>
				</tr>
				<tr>
					<td>
						${formatLang(data['form']['date_from'],date=True) or '' |entity}
					</td>
					<td>
						${formatLang (data['form']['date_to'] ,date=True) or ''|entity}
					</td>
					<td>
						${company.currency_id.name or ''|entity}
					</td>
				</tr>
			</table>
		<br/><br/>
		<table class="list_table"  width="100%">
    		<thead>
    			<tr>
	    			<th style="text-align:left;" width="30%">${_("User or Journal Name")}</th>
	    			<th style="text-align:left;" width="5%"></th>
	    			<th style="text-align:left;" width="10%">${_("Units")}</th>
	    			<th style="text-align:left;" width="15%">${_("Theorical")}</th>
	    			<th style="text-align:right;" width="10%">${_("Income")}</th>
	    			<th style="text-align:right;" width="10%">${_("Cost")}</th>
	    			<th style="text-align:right;" width="10%">${_("Profit")}</th>
	    			<th style="text-align:right;" width="10%">${_("Eff.")}</th>
    			</tr>
    		</thead>
		</table>
		<br/>
		<table class="list_table"  width="100%">
    		<thead>
    			<tr>
	    			<th style="text-align:left;" width="30%">${_("Totals:")}</th>
	    			<th style="text-align:left;" width="5%"></th>
	    			<th style="text-align:left;" width="10%">${reduce(lambda x, y: x+y['unit_amount'], line(data['form'], data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0) }</th>
	    			<th style="text-align:left;" width="15%"></th>
	    			<th style="text-align:right;" width="10%">${reduce(lambda x, y: x+y['amount'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0) }</th>
	    			<th style="text-align:right;" width="10%">${reduce(lambda x, y: x+y['cost'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0) }</th>
	    			<th style="text-align:right;" width="10%">${reduce(lambda x, y: x+y['profit'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0) }</th>
	    			<th style="text-align:right;" width="10%">${reduce(lambda x, y: x+y['cost'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0) and round(reduce(lambda x, y: x+y['amount'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0)/reduce(lambda x, y: x+y['cost'], line(data['form'],data['form']['journal_ids'][0][2], data['form']['employee_ids'][0][2]), 0)* -100, 2)}%</th>
    			</tr>
    		</thead>
    		%for e in user_ids(lines(data['form'])):
    			<tbody>
            	<tr>
	                <td class="td_line" style="text-align:left;">
	                	<b>${e.name or '' |entity}</b>
					 </td>
					 %for j in journal_ids(data['form'], [e.id]):
						<td style="text-align:left;">
					 	</td>
		                <td style="text-align:left;">
		                	${reduce(lambda x, y: x+y['unit_amount'], line(data['form'], [j.id], [e.id]), 0) or '' |entity}
						 </td>
	            		<td style="text-align:left;">
	            			${reduce(lambda x, y: x+y['amount_th'], line(data['form'], [j.id], [e.id]), 0) or '' |entity} 
	            		</td>
	            		<td style="text-align:left;">
	            			${reduce(lambda x, y: x+y['amount'], line(data['form'], [j.id], [e.id]), 0) or '' |entity} 
	            		</td>
	            		<td style="text-align:right;">
	            			${reduce(lambda x, y: x+y['cost'], line(data['form'], [j.id], [e.id]), 0) or 0.0 |entity} 
	            		</td>
	            		<td style="text-align:right;">
	            			${reduce(lambda x, y: x+y['profit'], line(data['form'], [j.id], [e.id]), 0) or 0.0 |entity} 
	            		</td>
	            		<td style="text-align:right;">
	            			${reduce(lambda x, y: x+y['cost'], line(data['form'], [j.id], [e.id]), 0) and '%d' % (reduce(lambda x, y: x+y['amount'], line(data['form'], [j.id], [e.id]), 0) / reduce(lambda x, y: x+y['cost'], line(data['form'], [j.id], [e.id]), 0) * 100.0)} %
	            		</td>
            	</tr>
            	</tbody>
    			<tbody>
            	<tr>
	                <td style="text-align:left;">
	                	${j.name or '' |entity}
					 </td>
						<td style="text-align:left;">
					 	</td>
		                <td style="text-align:left;">
						 </td>
	            		<td style="text-align:left;">
	            		</td>
	            		<td style="text-align:left;">
	            		</td>
	            		<td style="text-align:right;">
	            		</td>
	            		<td style="text-align:right;">
	            		</td>
	            		<td style="text-align:right;">
	            		</td>
            	</tr>
            	</tbody>
            	%endfor
    		%endfor
		</table> 
		<table class="list_table"  width="100%">
			%for l in line(data['form'], [j.id],[e.id]):
	   			<tbody>
	            	<tr>
		                <td style="text-align:left; border-style:none;" width="30%">
		                	${ l['name'] or '' |entity}
						 </td>
		                <td style="text-align:left; border-style:none;" width="5%">
						 </td>
						<td style="text-align:left; border-style:none;" width="10%">
		                	${ l['unit_amount'] or '' |entity}
						 </td>
			             <td style="text-align:left; border-style:none;" width="15%">
		                	${ l['amount_th'] or '' |entity}
						</td>
		            	<td style="text-align:right; border-style:none;" width="10%">
		                	${ l['amount'] or '' |entity}
		            	</td>
		            	<td style="text-align:right; border-style:none;" width="10%">
		                	${ l['cost'] or '' |entity}
		            	</td>
		            	<td style="text-align:right; border-style:none;" width="10%">
		                	${ l['profit'] or '' |entity}
		            	</td>
		            	<td style="text-align:right; border-style:none;" width="10%">
		                	${ l['eff'] or '' |entity} %
		            	</td>
	            	</tr>
	            </tbody>
			%endfor
	    </table>
		<p style="page-break-after:always"></p>		
	%endfor
</body>
</html>
