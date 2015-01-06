<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
    %for statement in objects:
        </br>
        </br>
        <center><h1>Today's Closed Cashbox</h1></center>
        <table class="basic_table">
            <tr>
                <td width="50%">
                    <b>${_("Company")}</b>
                </td>
                <td>
                    <b>${_("User")}</b>
                </td>
            </tr>
            <tr>
                <td width="50%">
                    ${company.name}
                </td>
                <td>
                    ${user.name}
                </td>
            </tr>
        </table>
        </br>
        <table class="list_table">
            <tr>
                <th width="18%">
                    ${_("St.Name")}
                </th>
                <th width="16%">
                    ${_("Journal")}
                </th>
                <th width="16%">
                    ${_("Opening Date")}
                </th>
                <th width="16%">
                    ${_("Closing Date")}
                </th>
                <th  width="18%" style="text-align:right;">
                    ${_("Starting Balance")}
                </th>
                <th style="text-align:right;" width="16%">
                    ${_("Ending Balance")}
                </th>
            </tr>
            <tr>
                <td>
                    <b>Total:</b>
                </td>
                <td colspan="4" align="right">
                    <u>${formatLang(get_net_total_starting(user)[1], currency_obj = company.currency_id)}</u>
                </td>
                <td align="right">
                    <u>${formatLang(get_net_total(user), currency_obj = company.currency_id)}</u>
                </td>
            </tr>
            %for statement in get_data(user.id):
             <tr>
                <td>
                    ${statement['statement']}
                </td>
                <td>
                    ${statement['journal']}
                </td>
                <td>
                    ${statement['date']}
                </td>
                <td>
                    ${statement['closing_date']}
                </td>
                <td align="right">
                    <u>${formatLang(get_bal(statement), currency_obj = company.currency_id)}</u>
                </td>
                <td align="right">
                    <u>${formatLang(get_sub_total(user,statement['journal_id'],statement['date']), currency_obj = company.currency_id)}</u>
                </td>
            </tr>
            %endfor
            %for line_ids in get_lines(statement):
            <tr>
                <td>
                    ${line_ids['name']}
                </td>
                <td>
                    ${get_partner(line_ids) or ''}
                </td>
                <td>
                    ${get_user(line_ids) or ''}
                </td>
                <td colspan="3" align="right">
                    ${formatLang(line_ids['amount'], currency_obj = company.currency_id)}
                </td>
            </tr>
            %endfor    
        </table>
        <p style="page-break-after:always">
        </p>
    %endfor
      
</body>
</html>