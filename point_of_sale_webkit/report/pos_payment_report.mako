<html>
    <head>
          <style type="text/css">
        ${css}
    </style>
    </head>
    <body>
        <center><h1>Payment For Sale</h1><center>
        <table class="basic_table">
            <tr>
                <td width="50%">
                    <b>${_("Company")}</b>
                </td>
                <td width="50%">
                    <b>${_("Print Date")}</b>
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
                <th width="50%">
                    ${_("Product")}
                </th>
                <th align="right" width="12%">
                    ${_("Qty")}
                </th>
                <th align="right" width="12%">
                    ${_("Disc.(%)")}
                </th>
                <th align="right" width="12%">
                    ${_("Unit Price")}
                </th>
                <th align="right" width="14%">
                    ${_("Total")}
                </th>
            </tr>
            %for o in objects:
            %for line_ids in pos_payment(o):
            <tr>
                <td>
                    [${ line_ids['code'] or '' }] ${line_ids['name']}
                </td>
                <td align="right">
                    ${formatLang(line_ids['qty'])} ${line_ids['uom']}
                </td>
                <td align="right">
                    ${formatLang(line_ids['discount'])}
                </td>
                <td align="right">
                    ${formatLang(line_ids['price_unit'])}
                </td>
                <td align="right">
                    ${formatLang(line_ids['total'], currency_obj = company.currency_id)}
                </td>
            </tr>
            %endfor
            <tr>
                <td colspan="3" style="border-bottom:0px;">
                </td>
                <td style="border-top:1px solid black;border-bottom:0px;">
                    <b>Net Total:</b>
                </td>
                <td style="border-top:1px solid black;text-align:right">
                   <b>${formatLang(pos_payment_total(o), currency_obj = company.currency_id) or ''}</b>
                </td>
            <tr>
            %endfor
        </table>
    </body>
</html>