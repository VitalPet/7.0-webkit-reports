<html>
    <head>
        <style type=text/css>
            ${css}
        </style>
    </head>
    <body>
                </br>
                </br>
                <center><h1>Sales Report</h1></center>
            
            <table class="basic_table">
                <tr>
                    <td width="50%">
                        ${_("Company")}
                    </td>
                    <td width="50%">
                        ${_("Print Date")}
                    </td>
                </tr>
                <tr>
                    <td>
                        ${company.name}
                    </td>
                    <td>
                        ${formatLang(time.strftime('%Y-%m-%d'),date = True)}
                    </td>
                </tr>
            </table>
            </br>
            <table class="list_table">
                <tr>
                    <th width="20%">
                        ${_("Name")}
                    </th>
                    <th width="25%">
                        ${_("Date Order")}
                    </th>
                    <th width="20%">
                        ${_("User")}
                    </th>
                    <th width="15%">
                        ${_("Status")}
                    </th>
                    <th width="20%" align="right">
                        ${_("Company")}
                    </th>
                </tr>
                %for line_ids in get_data(data['form']):
                <tr>
                    <td>
                        ${line_ids['pos']}
                    </td>
                    <td>
                        ${formatLang(line_ids['date_order'],date_time = True)}
                    </td>
                    <td>
                        ${ line_ids['user']}
                    </td>
                    <td>
                        ${ line_ids['state']}
                    </td>
                    <td align="right">
                        ${line_ids['name']}
                    </td>
                </tr>
                %endfor
            </table>
    </body>
</html>