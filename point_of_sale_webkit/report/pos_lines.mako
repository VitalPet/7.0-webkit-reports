<html>
    <head>
        <style type="text/css">
        ${css}
    </style>
    </head>
    <body>
        %for o in objects:
        </br>
        </br>
        <% setLang(o.partner_id.lang) %>
        <center><h2>Sales lines</h2></center>
        <table class="basic_table">
            <tr>
                <td width="35%">
                    <b>${_("Company")}</b>
                </td>
                <td width="30%">
                    <b>${_("Print Date")}</b>
                </td>
                <td width="35%">
                    <b>${_("No. Of Articles")}</b>
                </td>
            </tr>
            <tr>
                <td>
                    ${company.name}
                </td>
                <td>
                    ${formatLang(time.strftime('%Y-%m-%d'),date = True)}
                </td>
                <td>
                    ${formatLang(total_quantity(o))}
                </td>
            </tr>
        </table>
        </br>
        <table class="list_table">
            <tr>
                <th width="40%">
                    <b>${_("Description")}</b>
                </th>
                <th width="10%">
                    <b>${_("Tax")}</b>
                </th>
                <th width="8%" align="left">
                    <b>${_("Quantity")}</b>
                </th>
                <th width="7%" align="left">
                    <b>${_("Unit Price")}</b>
                </th>
                <th width="10%" align="left">
                    <b>${_("Disc.(%)")}</b>
                </th>
                <th width="10%" align="right">
                    <b>${_("Price")}</b>
                </th>
            </tr>
            %for l in o.lines:
            <tr>
                <td width="40%"> 
                    [ ${ l.product_id.code or ''}  ] ${ l.product_id.name  or ''}
                </td>
                <td width="10%">
                %if taxes(l) :
                    ${ taxes(l) or ''|entity }
                %endif
                </td>
                <td width="8%" align="left">
                    ${ formatLang(l.qty) } ${ l.product_id.uom_id.name }
                </td>
                <td width="8%" >
                    ${ formatLang(l.price_unit) }
                </td>
                <td width="10%">
                    ${ formatLang(l.discount) }
                </td>
                <td width="10%" style="text-align:right">
                    ${ formatLang(l.price_subtotal, currency_obj=o.pricelist_id.currency_id) }
                </td>
             </tr>
            %endfor
            <tr>
                    <td colspan="3" style="border-bottom:0px;"></td>
                    <td  colspan="2" style="border-top:1px solid black;border-bottom:0px;">${ _('Net Total:') }</td>
                    <td style="border-top:1px solid black;text-align:right">${ formatLang(o.amount_total, currency_obj=o.pricelist_id.currency_id) }</td>
                </tr>
                <tr>
                    <td style="border-bottom:0px;border-top:0px;" colspan="3"></td>
                    <td style="border-top:0px;border-bottom:0px" colspan="2">${ _('Taxes:') }</td>
                    <td align="right" style="border-top:0px;font-weight:none;text-align:right;">${ formatLang(o.amount_tax, currency_obj=o.pricelist_id.currency_id) }</td>
                </tr>
                <tr>
                    <td colspan="3" style="border-bottom:0px;border-top:0px;"></td>
                    <td  colspan="2" style="border-bottom:0px;border-top:1px solid black;"><b>${ _('Total:') }</b></td>
                    <td style="border-bottom:0px;border-top:1px solid black;text-align:right;" ><b>${ formatLang(o.amount_total + o.amount_tax, currency_obj=o.pricelist_id.currency_id) }</b></td>
                </tr>
        </table>
        <p style="page-break-after:always">
        </p>
        %endfor
        
    </body>
</html>