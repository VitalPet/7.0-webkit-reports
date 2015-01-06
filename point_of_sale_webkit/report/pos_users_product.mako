<html>
    <head>
        <style type=text/css>
            ${css}
        </style>
    </head>
    <body>
        %for statement in objects:
            </br>
            </br>
            <center><h1>User's Product</h1></center>
            <table class="basic_table">
                <tr>
                    <td width="20%"> 
                        ${_("User")}
                    </td>
                    <td width="20%">
                        ${_("Company")}
                    </td>
                    <td width="20%">
                        ${_("Print Date")}
                    </td>
                    <td width="20%">
                        ${_("Starting Date")}
                    </td>
                    <td width="20%">
                        ${_("Ending Date")}
                    </td>
                </tr>
                <tr>
                    <td>
                        ${get_user(statement)}
                    </td>
                    <td>
                        ${company.name}
                    </td>
                    <td>
                        ${formatLang(time.strftime('%Y-%m-%d'),date = True)}
                    </td>
                    <td>
                        ${formatLang(statement.date,date = True)}
                    </td>
                    <td>
                        ${formatLang(statement.closing_date,date_time = True)}
                    </td>
                </tr>
            </table>
            </br>
            <table  class="list_table">
                <tr>
                    <th width="60%">
                        ${_("Product")}
                    </th>
                    <th width="10%" style="text-align:right;">
                        ${_("Qty")}
                    </th>
                    <th width="20%"  style="text-align:right;">
                        ${_("Amount")}
                    </th>
                </tr>
                %for line_ids in get_data(statement):
                <% print "line_ids",line_ids %>
                <tr>
                    <td>
                        [${ line_ids['code'] or '' }] ${line_ids['name']}
                    </td>
                    <td align="right">
                        ${formatLang(line_ids['qty'])} ${line_ids['uom']}
                    </td>
                    <td align="right">
                        ${formatLang(line_ids['amt'], currency_obj = company.currency_id)}
                    </td>
                </tr>
                %endfor
                <tr>
                    <td style="border-bottom:0px;border-top:0px">
                    </td>
                    <td  style="border-top:2px solid black;border-bottom:0px;text-align:right;">
                        <b>${_("Total :")}</b>
                    </td>
                    <td style="border-top:2px solid black;border-bottom:0px;text-align:right;">
                        <b>${formatLang(get_total(statement), currency_obj = company.currency_id)}</b>
                    </td>
                </tr>
            </table>
            <p style="page-break-after:always"> 
            </p>
        %endfor
    </body>
</html>