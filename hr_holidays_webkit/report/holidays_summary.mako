<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
        <center><h1>${_("Leave Summary")} ${header_date(data)[2] or '' |entity}</h1></center>
        <center> 
            ${_("Analyze from")} <u>${formatLang(header_date(data)[0].strftime("%Y-%m-%d"),date=True)}</u>
            ${_("to")} <u>${formatLang(header_date(data)[1].strftime("%Y-%m-%d"),date=True)}</u>
            ${_("of the")} <u>${header_date(data)[3] or '' |entity}</u>
            ${_("leaves.")}
        </center>
        <br/><br/><br/>
        <%
            t_width = 0
            t_width1 = 0
            t_width2 = 0
        %>
        <table class="list_table" width="100%">
                <tr>
                    <td width="8.3%" style="text-align=left;background-color:FFFFFF;font-size:10px;padding-left:5px;padding-bottom:7px;">
                        <b>${_("Month")}</b>
                    </td>
                %for month in range((header_date(data)[1].month - header_date(data)[0].month)):
                    %if month == 0:
                        <% col = (len(range(header_date(data)[0].day, lengthmonth(header_date(data)[0].year, header_date(data)[0].month)+1)))%>
                        <% temp = str(col - 0.9)+'%' %>
                        <td width= ${temp} style="text-align=center;background-color:FFFFFF;font-size:10px;">
                            <b>${month_name(header_date(data)[0].month) or '' |entity}</b>
                        </td>
                    %else:
                        <% t_width1 = len(range(1,lengthmonth(header_date(data)[0].year, header_date(data)[0].month +1)+1))%>
                        <% temp1 = str(t_width1)+'%' %>
                        <td width=${temp1} style="text-align=center;background-color:FFFFFF;font-size:10px; ">
                            <b>${month_name(header_date(data)[0].month+1) or '' |entity}</b>
                        </td>
                    %endif
                %endfor
                        <% t_width2 = len(range(1, 61-(col+t_width1)))%>
                        <% temp2 = str(t_width2)+'%' %>
                        <td width=${temp2} style="text-align=center;background-color:FFFFFF;font-size:10px;">
                            <b>${month_name(header_date(data)[1].month) or '' |entity}</b>
                        </td>
                        <td width="3%" style="text-align=center;background-color:FFFFFF;">
                        </td>
                </tr>
        </table>
        <table class="list_table" >
                <tr>
                    <td width="9%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                    </td>
                <% 
                    sum=0
                    total = 0 
                    total_a = 0
                %>
                
                %for month in range((header_date(data)[1].month - header_date(data)[0].month)):
                    %if month == 0:
                        %for x in range(header_date(data)[0].day, lengthmonth(header_date(data)[0].year, header_date(data)[0].month)+1):
                            %if get_day_name(header_date(data)[0].year,header_date(data)[0].month ,x) in ['Sat','Sun']:
                                <td width="1%" style="text-align=center;background-color:E1DEDE;padding-bottom:7px;">
                                    ${get_day_name(header_date(data)[0].year, header_date(data)[0].month ,x) or '' |entity}
                                </td>
                                <% total=total +1%>
                            %else:
                                <td width="1%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                                    ${get_day_name(header_date(data)[0].year, header_date(data)[0].month ,x) or '' |entity}
                                </td>
                                <% total=total +1%>
                            %endif
                        %endfor
                    %else:
                        %for x in range(1,lengthmonth(header_date(data)[0].year, header_date(data)[0].month +1)+1):
                             %if get_day_name(header_date(data)[0].year, header_date(data)[0].month+1 ,x) in ['Sat','Sun']:
                                <td  width="1%" style="text-align=center;background-color:E1DEDE;padding-bottom:7px;">
                                    ${get_day_name(header_date(data)[0].year, header_date(data)[0].month+1 ,x) or '' |entity}
                                </td>
                                <%total_a =total_a +1%>
                             %else:
                                 <td  width="1%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                                    ${get_day_name(header_date(data)[0].year, header_date(data)[0].month+1 ,x) or '' |entity}
                                    <% print get_day_name(header_date(data)[0].year,header_date(data)[0].month+1 ,x) %>
                                </td>
                                <%total_a =total_a +1%>
                             %endif
                        %endfor
                    %endif
                <% sum = total + total_a%>
                %endfor
                %for x in range(1, 61-sum):
                    %if get_day_name(header_date(data)[0].year, header_date(data)[1].month ,x) in ['Sat','Sun']:
                        <td  width="1%" style="text-align=center;background-color:E1DEDE;padding-bottom:7px;">
                            ${get_day_name(header_date(data)[0].year, header_date(data)[1].month ,x) or '' |entity}
                        </td>
                     %else:
                        <td  width="1%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                            ${get_day_name(header_date(data)[0].year, header_date(data)[1].month ,x) or '' |entity}
                        </td>
                     %endif
                %endfor
                        <td width="4%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                        </td>
                </tr>
                <tr>
                    <td width="10%" style="text-align=left;background-color:FFFFFF;font-size:8px;padding-left:5px;padding-right:10px;padding-bottom:7px;">
                        <b>${_("Departments and Employees")}</b>
                    </td>
                <% 
                    sum=0
                    total = 0 
                    total_a = 0
                %>
                %for month in range((header_date(data)[1].month - header_date(data)[0].month)):
                    %if month == 0:
                        %for x in range(header_date(data)[0].day, lengthmonth(header_date(data)[0].year, header_date(data)[0].month)+1):
                            %if get_day_name(header_date(data)[0].year,header_date(data)[0].month ,x) in ['Sat','Sun']:
                                <td width="1%" style="text-align=center;background-color:E1DEDE;">
                                    ${x}
                                </td>
                                <% total=total +1%>
                            %else:    
                                <td width="1%" style="text-align=center;background-color:FFFFFF;">
                                    ${x}
                                </td>
                                <% total=total +1%>
                            %endif
                        %endfor
                    %else:
                        %for x in range(1,lengthmonth(header_date(data)[0].year, header_date(data)[0].month +1)+1):
                            %if get_day_name(header_date(data)[0].year,header_date(data)[0].month ,x) in ['Sat','Sun']:
                                <td  width="1%" style="text-align=center;background-color:E1DEDE;">
                                    ${x}
                                </td>
                             %else:
                                <td  width="1%" style="text-align=center;background-color:FFFFFF;">
                                    ${x}
                                </td>
                             %endif
                        <%total_a =total_a +1%>
                        %endfor
                    %endif
                <% sum = total + total_a%>
                %endfor
                %for x in range(1, 61-sum):
                    %if get_day_name(header_date(data)[0].year,header_date(data)[0].month+1 ,x) in ['Sat','Sun']:
                        <td  width="1%" style="text-align=center;background-color:E1DEDE;">
                            ${x}
                        </td>
                    %else:
                        <td  width="1%" style="text-align=center;background-color:FFFFFF;">
                            ${x}
                        </td>
                    %endif
                    
                %endfor
                    <td width="4%" style="text-align=center;background-color:FFFFFF;">
                        <b>${_("Sum")}</b>
                    </td>
                </tr>
        %for leave in leave_info_emp(data):
                <tr>
                    <td width="10.9%" style="text-align=center;background-color:FFFFFF;padding-bottom:7px;">
                        ${leave['name'] or '' |entity}
                    </td>
                <% total_leave = 0.0%>
                <% display = emp_data(0,(header_date(data))[5],leave['id'], leave['name'], month_dates(data)[0], month_dates(data)[1]) %>
                    %if len(display) != 0 :
                        %for x in range(1,len(display)+1):
                            <% flag = True %>
                            %for l in range(0,len(leave_color())):
                                %if display[x] == leave_color()[l][0]:
                                    <% clr = str(leave_color()[l][2]) %>
                                        <td width="t_width %" style="text-align=center;background-color:${clr};">
                                        </td>
                                        <% flag= False%>
                                        <%total_leave = total_leave +1%>
                                %endif
                            %endfor
                            %if flag == True:
                                <td width="t_width %" style="text-align=center;background-color:FFFFFF;">
                                </td>
                            %endif
                        %endfor
                    %else:
                        %for x in range(1, 61):
                                <td width="t_width %" style="text-align=center;background-color:FFFFFF;">
                                </td>
                        %endfor
                    %endif
                        <td style="text-align=center;background-color:FFFFFF;">
                            ${total_leave or 0 |entity}
                        </td>
                </tr>
        %endfor
            %for dept in leave_info_dept(data)[1]:
                <tr>
                    <td width="10.9%" style="text-align=center;font-size:10px;padding-bottom:7px;">
                            <b>${dept['name'] or '' |entity}</b>
                    </td>
                    %for i in range(60):
                        <td style="text-align=center;background-color:FFFFFF;">
                        </td>
                    %endfor
                    <td style="text-align=center;background-color:FFFFFF;">
                    </td>
                </tr>
                    %for depts in leave_info_dept(data)[0]:
                    <tr>
                        %if dept['name'] == depts["department_id"][1]:
                        
                            <td width="t_width %" style="text-align=left;background-color:FFFFFF;font-size:8px;padding-bottom:7px;">
                                ${depts['name'] or '' |entity}
                            </td>
                        <% total_leave = 0.0%>  
                        <% display = emp_data(0,(header_date(data))[5],depts['id'], depts['name'], month_dates(data)[0], month_dates(data)[1]) %>       
                            %if len(display) != 0 :                 
                                %for x in range(1,len(display)+1):
                                    <% flag = True %>
                                    %for l in range(0,len(leave_color())):
                                        %if display[x] == leave_color()[l][0]:
                                            <% clr = str(leave_color()[l][2])%>
                                            <td width="t_width %" style="text-align=center;background-color:${clr};">
                                            </td>
                                            <% flag= False%>
                                            <%total_leave = total_leave +1%>
                                        %endif
                                    %endfor
                                    %if flag == True:
                                        <td width="t_width %" style="text-align=center;background-color:FFFFFF;">
                                        </td>
                                    %endif
                                %endfor
                                <td style="text-align=center;background-color:FFFFFF;">
                                    ${total_leave or 0 |entity}
                                </td>
                            %else:
                                %for x in range(1, 61):
                                    <td width="t_width %" style="text-align=center;background-color:FFFFFF;">
                                    </td>
                                %endfor
                            <td style="text-align=center;background-color:FFFFFF;">
                                ${total_leave or 0 |entity}
                            </td>
                            %endif
                        %endif
                %endfor 
                </tr>
        %endfor 
        </table>
        <br/><br/><br/>
        <center>
        <table class="color_table" width="16%">
                <tr>
                    <td width = "5%">
                        <b>${"Color"}</b>
                    </td>
                    <td width= "10%">
                        <b>${"Leave Type"}</b>
                    </td>
                </tr>
        %for l in range(0,len(leave_color())):
            <% clr = str(leave_color()[l][2])%>
                <tr>
                    <td style="text-align=center;background-color:${clr};">
                    </td>
                    <td width= "20%">
                        ${leave_color()[l][1]}
                    </td>
                </tr>
        %endfor
        </center>
</body>
</html>