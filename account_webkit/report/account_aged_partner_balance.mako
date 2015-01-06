<html>
	<head>
		<style type="text/css">
		
			table.mystyle{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-style: solid;
				border: 1px solid grey;
				font-size: 100%;}

			.mystyle td, .mystyle th{
				margin: 0;
				padding: 4px;
				border-width: 1px 1px 1px 1px;
				border-style: solid;
				border: 1px solid grey;
				font-size: 60%;}
				
			table.mystyleone{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-color: black;
				font-weight:bold;
				border-style: solid;
				font-size: 100%;}

			.mystyleone tr{
				margin: 0;
				padding: 4px;
				border-width: 0 0 1px 0;
				border-color: black;
				font-weight:bold;
				border-style: solid;
				font-size: 60%;}
		</style>
	</head>

	<body>

		%for o in objects:
			</br>
            <center><h2>Aged Trial Balance</h2></center>
	
			<table  width="100%" class="mystyle">
				<tr class="table_parent_data_header">
					<td width="16%" class="cell">
						<b>Chart of Accounts</b>
					</td>
					<td width="14%" class="cell">
						<b>Fiscal Year</b>
					</td>
					<td width="14%" class="cell">
						<b>Start Date</b>
					</td>
					<td width="14%" class="cell">
						<b>Period Length(days)</b>
					</td>
					<td width="14%" class="cell">
						<b>Partner's</b>
					</td>	
					<td width="16%" class="cell">
						<b>Analysis Direction</b>
					</td>
					<td width="14%" class="cell">	
						<b>Target Moves</b>
					</td>
				</tr>
	
				<tr class="table_child_data_header">
					<td width="16%" class="cell">
						${get_account(data) or ''}
					</td>
					<td width="14%" class="cell">
						${get_fiscalyear(data) or ''}
					</td>
					<td width="14%" class="cell">
						${formatLang(data['form']['date_from'],date=True)}
					</td>
					<td width="14%" class="cell">
						${data['form']['period_length'] }
					</td>
					<td width="14%" class="cell">
						${get_partners(data)}
					</td>	
					<td width="16%" class="cell">
						${data['form']['direction_selection']}
					</td>
					<td width="14%" class="cell"> 	
						${get_target_move(data)}
					</td>
				</tr>
			</table>
			</br></br>
	
	  <table width="100%" class="mystyleone">
			<tr class="table_parent_data">
				<td width="23%">
					Partners
				</td>
				<%
					direction = ''
					if data['form']['direction_selection'] == 'future':
						direction = 'Due'
					else:
						direction = 'Not due'
				%>
				<td width="11%" >
					${direction}
				</td>
				<td width="11%" >
					${ data['form']['4']['name']}
				</td><td width="11%" >
					${ data['form']['3']['name']}
				</td>
				<td width="11%" >
					${ data['form']['2']['name']}
				</td>
				<td width="11%" >
					${ data['form']['1']['name']}
				</td>
				<td width="11%" >
					${ data['form']['0']['name']}
				</td>
				<td width="11%" >
					${_('Total')}
				</td>
			</tr>	
			
	
			%if get_lines(data['form']) != False or get_lines_with_out_partner(data['form']) != False:
				<tr class="table_parent_data">
					<td width="23%">
						${_('Account Total')}
					</td>
					<td width="11%" >
						${formatLang(get_direction('6'), currency_obj=company.currency_id)}
					</td>
					<td width="11%" >
						${ formatLang(get_for_period('4'), currency_obj=company.currency_id)}
					</td><td width="11%" >
						${ formatLang(get_for_period('3'), currency_obj=company.currency_id)}
					</td>
					<td width="11%" >
						${ formatLang(get_for_period('2'), currency_obj=company.currency_id)}
					</td>
					<td width="11%" >
						${ formatLang(get_for_period('1'), currency_obj=company.currency_id)}
					</td>
					<td width="11%" >
						${ formatLang(get_for_period('0'), currency_obj=company.currency_id)}
					</td>
					<td width="11%" >
						${formatLang(get_total('5'), currency_obj=company.currency_id)}
					</td>
				</tr>	

		
					%for partner in get_lines(data['form']):
						<tr class="table_child_data">
							<td width="23%">
								${partner['name']}
							</td>
							<td width="11%" >
								${formatLang(partner['direction'], currency_obj=company.currency_id)}
							</td>
							<td width="11%" >
								${ formatLang(partner['4'], currency_obj=company.currency_id)}
							</td><td width="11%" >
								${ formatLang(partner['3'], currency_obj=company.currency_id)}
							</td>
							<td width="11%" >
								${ formatLang(partner['2'], currency_obj=company.currency_id)}
							</td>
							<td width="11%" >
								${ formatLang(partner['1'], currency_obj=company.currency_id)}
							</td>
							<td width="11%" >
								${ formatLang(partner['0'], currency_obj=company.currency_id)}
							</td>
							<td width="11%" >
								${formatLang(partner['total'], currency_obj=company.currency_id)}
							</td>
						</tr>
					%endfor

				%for not_partner in get_lines_with_out_partner(data['form']):
					<tr class="table_child_data">
						<td width="23%">
							${not_partner['name']}
						</td>
						<td width="11%" >
							${formatLang(not_partner['direction'], currency_obj=company.currency_id)}
						</td>
						<td width="11%" >
							${ formatLang(not_partner['4'], currency_obj=company.currency_id)}
						</td><td width="11%" >
							${ formatLang(not_partner['3'], currency_obj=company.currency_id)}
						</td>
						<td width="11%" >
							${ formatLang(not_partner['2'], currency_obj=company.currency_id)}
						</td>
						<td width="11%" >
							${ formatLang(not_partner['1'], currency_obj=company.currency_id)}
						</td>
						<td width="11%" >
							${ formatLang(not_partner['0'], currency_obj=company.currency_id)}
						</td>
						<td width="11%" >
							${formatLang(not_partner['total'], currency_obj=company.currency_id)}
						</td>
					</tr>
				%endfor
			%endif 

	  </table >
		%endfor

	</body>
</html>