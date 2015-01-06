<html>
    <head>
        <style type="text/css">
        ${css}
    </style>
    </head>
    <body>
        <center>
        %for o in objects:
        <table class="font">
            <tr>
                <td width="100%" style="font-family:"Courier-Bold;">
                    <b>${o.user_id.company_id.name or ''}</b>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    ${address and display_address(address) or ''}
                </td>
            </tr>
            <tr>
                <td width="100%">
                    Tel:${address and address.phone or ''}
                </td>
             </tr>
             <tr>
                <td width="100%">
                    User:${o.user_id.name or ''}
                </td>
             </tr>
             <tr>
                <td width="100%">
                    Shop:${o.shop_id.name or ''}
                </td>
             </tr>
             <tr>
                <td width="100%">
                    Date:${o.date_order or ''}
                </td>
             </tr>
        </table>
            </br>
            </br>
            </br>
            <h1>N° : ${o.name or ''}</h1>
           </center>
            <table class="list">
                <tr>
                    <th width="50%">${_("Description")}</th>
                    <th width="20%" align="right">${_("Qty")}</th>
                    <th align="right" width="30%">${_("Price")}</th>
                </tr>
                %for line in o.lines:
                <tr>
                    <td width="50%" style="padding-bottom:20px; ">
                        ${line.product_id.name}
                        %if line and line.discount == 0.0:
                            ${}
                        %else: 
                            <font face="Helvetica">With a ${ line and line.discount == 0.0 or '' } (${ '%.2f' % line.discount or ''}) % discount.</font>
                        %endif
                    </td>
                    <td  style="text-align:right;padding-bottom:20px; " width="20%">
                        ${o.state=='cancel' and o.statement_ids and '-' or ''} ${'%.f' % line.qty}
                    </td>
                    <td style="text-align:right;padding-bottom:20px; " width="30%">
                        ${o.state=='cancel' and o.statement_ids and '-' or ''} ${formatLang(net(line.id), currency_obj=company.currency_id)}
                         %if line and line.discount == 0.0:
                            ${}
                        %else: 
                         <font face="Helvetica">${ line and line.discount == 0.0 or '' } ${ formatLang(line.discount, currency_obj=company.currency_id) })</font>
                        %endif
                    </td>
                </tr>
                %endfor
                <tr>
                    <td colspan="2" style="text-align:right;">
                        Taxes :
                    </td>
                    <td style="border-top:2px solid black;text-align:right;" width="30%">
                        ${o.state=='cancel' and o.statement_ids and '-' or ''} ${formatLang(o.amount_tax, currency_obj=company.currency_id)}
                    </td>
                </tr>
                 <tr>
                    <td style="text-align:right;"  colspan="2">
                        <b>Total :</b>
                    </td>
                    <td style="text-align:right;"  width="30%" >
                        <b>${o.state=='cancel' and o.statement_ids and '-' or ''} ${formatLang(o.amount_total, currency_obj=company.currency_id)}</b>
                    </td>
                </tr>
            </table>
            </br>
            <table class="list_table">
                <tr>
                    <th style="font-family:"Courier-Bold;">
                        ${_("Payment Mode")}
                    </th>
                    <th align="right" style="font-family:"Courier-Bold;"> 
                        ${_("Amount")}
                    </th>
                </tr>
                %for d in get_journal_amt(o):
                <tr>
                    <td>
                        ${d['name']}
                    </td>
                    <td style="text-align:right">
                        ${formatLang(d['amt'] or 0, currency_obj=company.currency_id)}
                    </td>
                </tr>
                %endfor
             </table>
           
        %endfor
    </body>
</html>