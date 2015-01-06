<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
		<br/>
		<center><h2> ${_("Timesheet by Employee")} </h2></center>
		<br/><br/>
		<table>
			<tr>
			<td style="color:0040FF;"><i>${get_emp_name(data)}</i> </td>
			</tr>
		<table>
		<br/>
		<br/>		
		<table class="list_table">
			<tr>
				<td width="8%" style="background-color:FFFFFF;text-align:left;">${data['form']['year']}</td>
				%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
					%if get_day_name(data['form']['year'],data['form']['month'],month+1) in ['Sat','Sun']:
						<td width="2.5%" style="background-color:E1DEDE;">${get_day_name(data['form']['year'],data['form']['month'],month+1)}</td>
					%else:
						<td width="2.5%">${get_day_name(data['form']['year'],data['form']['month'],month+1)}</td>
					%endif
				%endfor
					<td width="8%" style="background-color:FFFFFF;"></td>
			</tr>
			<tr>
				<td width="8%" style="background-color:FFFFFF;text-align:left;">${get_month_name(data['form']['month'])}</td>
				%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
					%if get_day_name(data['form']['year'],data['form']['month'],month+1) in ['Sat','Sun']:
						<td width="2.5%" style="text-align=center; background-color:E1DEDE;">${month +1 }</td>
					%else:
						<td width="2.5%" style="text-align=center;">${month +1 }</td>
					%endif
				%endfor
				<td width="8%" style="background-color:FFFFFF;"><b>${_("Total")}</b></td>
			</tr>
			<%
				sum = 0.0
			%>
			%for acc in range(len(get_emp_data(data)[0])):
				<tr>
					<td width="8%" style="background-color:FFFFFF;text-align:left;">${get_emp_data(data)[0][acc]}</td>
					<% 
						k = (get_emp_data(data)[1])[acc].values() 
						v = (get_emp_data(data)[1])[acc].keys()
						counter = 0
						total=0.0
					%>
					%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
    					%if get_day_name(data['form']['year'],data['form']['month'],month+1) in ['Sat','Sun']:
    						%if month+1 in v:
    								%if v > counter:
    									<td width="2.5%" style="background-color:E1DEDE;">${k[counter]}</td>
    									<%
    										total = total + k[counter]
    										counter = counter +1
    									%>
    								%endif
    							%else:
    								<td width="2.5%" style="background-color:FFFFFF;"></td>
    							%endif
    				    %else:
    				        %if month+1 in v:
                                    %if v > counter:
                                        <td width="2.5%" style="background-color:FFFFFF;">${k[counter]}</td>
                                        <%
                                            total = total + k[counter]
                                            counter = counter +1
                                        %>
                                    %endif
                                %else:
                                    <td width="2.5%" style="background-color:FFFFFF;"></td>
                                %endif
                         %endif
					%endfor
					<td width="8%" style="background-color:FFFFFF;text-align:left;padding-top:0px;">${total}</td>
				</tr>
				<% sum = sum + total%>
			%endfor
			%for acc in range(len(get_emp_data(data)[0])):
				<% grand_total  = sum %>
				<tr>
					<td width="8%" style="background-color:FFFFFF;text-align:left;"><b>${_("Sum")}</b></td>
						<% sum = 0.0 %>
						%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
						     %if get_day_name(data['form']['year'],data['form']['month'],month+1) in ['Sat','Sun']: 
								<td width="2.5%" style="background-color:E1DEDE; color:red">0</td>
							 %else:
							    <td width="2.5%" style="background-color:FFFFFF;color:red">0</td> 
							 %endif
						%endfor
					<td width="2.5%" style="background-color:FFFFFF;"><b>${grand_total}</b></td>
				<tr>
		  %endfor
		</table>
</body>
</html>