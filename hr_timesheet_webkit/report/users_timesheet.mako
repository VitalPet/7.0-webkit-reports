<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
		<br/>
		<center><h2> ${_("Employees Timesheet")} </h2></center>
		
		<br/><br/>

		<table class="list_table">
			<tr>
				<td width="8%" style="background-color:FFFFFF;text-align:left;">${data['form']['year']}</td>
				%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
					%if get_day_name(data['form']['year'],data['form']['month'],month+1) in ['Sat','Sun']:
						<td width="2.5%" style="background-color:E1DEDE;"><b>${get_day_name(data['form']['year'],data['form']['month'],month+1)}</b></td>
					%else:
						<td width="2.5%"><b>${get_day_name(data['form']['year'],data['form']['month'],month+1)}</b></td>
					%endif
				%endfor
					<td width="8%" style="background-color:FFFFFF;"><b></b></td>
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
			<% sum = 0.0 %>
			%for user in users_data(data):
				<tr>
					<% 
						counter = 0
						total=0.0
					%>
					<td width="8%" style="background-color:FFFFFF;text-align:left;">${user_name(data, user)}</td>
					%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
					    <%
					       print "MONTH       ",month
					    %>
						%if month + 1 in  (emp_data(data, user)[0]):
							<td width="2.5%" style="background-color:FFFFFF; color:#DF0101">${(emp_data(data, user)[1])[counter]}</td>
						<%
                            total = total + (emp_data(data, user)[1])[counter]
                            counter = counter +1 
                            print "counter",counter
						%>
						%else:	
							<td width="2.5%" style="background-color:FFFFFF;color:#DF0101"">${0}</td>
						%endif
					%endfor
					<td width="8%" style="background-color:FFFFFF;">${total}</td>
				</tr>
			<%sum =sum +total%>
			%endfor
				<tr>
					<% 
						counter = 0
						grand_total = sum
					%>
					<td width="8%" style="background-color:FFFFFF;text-align:left;">${_("Sum")}</td>
					%for month in range(lengthmonth(data['form']['year'],data['form']['month'])):
						%if month +1 in  (emp_data(data, user)[0]):
 							<td width="2.5%" style="background-color:FFFFFF;">${(emp_data(data, user)[1])[counter]}</td>
						%else:
							<td width="2.5%" style="background-color:FFFFFF;">${0}</td>
						%endif
					%endfor
					<td width="8%" style="background-color:FFFFFF;">${grand_total}</td>
				</tr>
		</table>
</body>
</html>