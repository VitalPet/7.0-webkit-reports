<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
    %for statement in objects:
        </br>
        <center><h1>Statement<h1></center>
        <table class="basic_table">
            <tr>
                <td width="25%">
                    <b>${_("Statement Name")}</b>
                </td>
                <td width="25%">
                    <b>${_("Journal")}</b>
                </td>
                <td width="25%">
                    <b>${_("Company")}</b>
                </td>
                <td width="25%">
                    <b>${_("User")}</b>
                </td>
            </tr>
            <tr>
                <td>
                    ${ statement.name }
                </td>
                <td>
                    ${statement.journal_id.name}
                </td>
                <td>
                    ${statement.company_id.name}
                </td>
                <td>
                    ${statement.user_id.name }
                </td>
            </tr>
        </table>
        </br>
        <table class="basic_table">
            <tr>
                <td width="25%">
                    <b>${_("Opening Date")}</b>
                </td>
                <td width="25%">
                    <b>${_("Closing Date")}</b>
                </td>
                <td width="25%">
                    <b>${_("Starting Balance")}</b>
                </td>
                <td width="25%">
                    <b>${_("Ending Balance")}</b>
                </td>
            </tr>
            <tr>
                <td>
                    ${formatLang(statement.date,date=True)}
                </td>
                <td>
                    ${formatLang(statement.closing_date,date_time=True)}
                </td>
                <td>
                    ${formatLang(statement.balance_start, dp='Account', currency_obj = company.currency_id)}
                </td>
                <td>
                    ${formatLang(statement.balance_end_real, dp='Account', currency_obj = company.currency_id)}
                </td>
            </tr>
        </table>
        </br>
        <table class="list_table">
            <tr>
                <th width="15%">
                    ${_("Name")}
                </th>
                <th width="70%">
                    ${_("Partner")}
                </th>
                <th width="15%" align="right">
                    ${_("Amount")}
                </th>
            </tr>
        %for line_ids in statement.line_ids or get_data(statement):
                 <tr>
                        <td>
                            ${line_ids.name}
                        </td>
                        <td>
                            ${line_ids.partner_id.name}
                        </td>
                        <td align="right">
                            ${formatLang(line_ids.amount, dp='Account', currency_obj=company.currency_id)}
                        </td>
                    </tr>
        %endfor
        </table>
        <table width="100%">
            <tr>
                <td width="70%">
                </td>
                <td width="30%" style="padding-top:0px">
                    <table class="top" width="100%">
                        <tr>
                            <td width="50%" align="left">
                                <b>Total:</b>
                            </td>
                            <td align="right" width="50%">
                                ${formatLang(get_total(statement.line_ids), dp='Account', currency_obj = company.currency_id)} 
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <p style="page-break-after:always">
        </p>
    %endfor
</body>
</html>