<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
    
    <center><h2>Details of Sales</h2></center>
    <table class="basic_table"> 
        <tr>
            <td width="20%"> 
                <b>${_("Company")}</b>
            </td>
            <td width="20%">
                <b>${_("Users")}</b>
            </td>
            <td width="20%">
                <b>${_("Print Date")}</b>
            </td>
            <td width="20%">
                <b>${_("Start Period")}</b>
            </td>
            <td width="20%">
                <b>${_("End Period")}</b>
            </td>
        </tr>
        <tr>
            <td>
                ${company.name}
            </td>
            <td>
                ${get_user_names(data['form']['user_ids']) or 'All'}
            </td>
            <td>
                ${formatLang(time.strftime('%Y-%m-%d'),date=True)}
            </td>
            <td>
                ${formatLang(data['form']['date_start'],date=True)}
            </td>
            <td>
                ${formatLang(data['form']['date_end'],date=True)}
            </td>
        </tr>
    </table>
    </br>
    <table class="list_table">
        <tr>
            <th width="20%">
                ${_("Date")}
            </th>
            <th width="10%">
                ${_("Order")}
            </th>
            <th width="30%" >
                ${_("Product")}
            </th>
            <th width="10%" align="right">
                ${_("Price")}
            </th>
            <th width="10%" align="right">
                ${_("Qty")}
            </th>
            <th width="10%" align="right">
                ${_("Disc(%)")}
            </th>
            <th width="10%" align="right"> 
                ${_("Invoiced")}
            </th>
        </tr>
        %for line_ids in pos_sales_details(data['form']):
        <tr>
            <td>
                ${formatLang(line_ids['date_order'],date_time = True)}
            </td>
            <td>
                ${line_ids['pos_name']}
            </td>
            <td>
                ${line_ids['code']} ${line_ids['name']}
            </td>
            <td>
                ${formatLang(line_ids['price_unit'], dp='Sale Price', currency_obj = company.currency_id)}
            </td>
            <td>
                ${formatLang(line_ids['qty'])} ${line_ids['uom']}
            </td>
            <td>
                ${formatLang(line_ids['discount'], dp='Sale Price')}
            </td>
            <td>
                ${getinvoice(line_ids['invoice_id']) or ''}
            </td>
        </tr>
        %endfor
        </table>
        </br>
        <table width="100%">
            <tr>
                <td width="3%">
                </td>
                <td width="94%">
                    <table class="list_table">
                        <tr>
                            <th width="50%">
                                ${_("Taxes")}
                            </th>
                            <th  width="50%"></th>
                        </tr>
                        %for p in gettaxamount(data['form']):
                        <tr>
                             <td width="50%" style="border-bottom:1px solid lightGrey;">
                                    <b>${p['name'] or ''}</b>
                                </td>
                                <td align="right" width="50%" style="border-bottom:1px solid lightGrey;">
                                    <b>${formatLang(p['amount'], currency_obj = company.currency_id) or ''}</b>
                                </td>
                        </tr>
                        %endfor
                    </table>
                    </br>
                    <table class="list_table">
                        <tr>
                            <th  width="50%">
                                ${_("Payment")}
                            </th>
                            <th  width="50%"></th>
                        </tr>
                        %for p in getpayments(data['form']):
                        <tr>
                             <td width="50%">
                                    ${p['name'] or ''}
                                </td>
                                <td align="right" width="50%">
                                    ${formatLang(p['sum'], dp='Account', currency_obj = company.currency_id) or ''}
                                </td>
                        </tr>
                        %endfor
                     </table>
                     </br>
                     <table class="list_table">
                        <tr>
                            <th  width="50%">
                                ${_("Summary")}
                            </th>
                            <th  width="50%"></th>
                        </tr>
                        <tr>
                             <td width="50%">
                                    <b>${_("Sales total(Revenue)")}</b>
                                </td>
                                <td align="right" width="50%">
                                    <b>${formatLang(getsalestotal2(), dp='Sale Price', currency_obj = company.currency_id)}</b>
                                </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <b>${_("Qty of product")}</b>
                            </td>
                            <td align="right" width="50%">
                                <b>${formatLang(getqtytotal2())}</b>
                            </td>
                        </tr>
                         <tr>
                            <td width="50%">
                                <b>${_("Total invoiced")}</b>
                            </td>
                            <td align="right" width="50%">
                                <b>${formatLang(getsuminvoice2(data['form']), dp='Sale Price', currency_obj = company.currency_id)}</b>
                            </td>
                        </tr>
                         <tr>
                            <td width="50%">
                                <b>${_("Total discount")}</b>
                            </td>
                            <td align="right" width="50%">
                                <b>${formatLang(getsumdisc(data['form']), dp='Sale Price', currency_obj =  company.currency_id)}</b>
                            </td>
                        </tr>
                         <tr>
                            <td width="50%">
                                <b>${_("Total paid")}</b>
                            </td>
                            <td align="right" width="50%">
                                <b>${formatLang(getpaidtotal2(), dp='Sale Price', currency_obj = company.currency_id)}</b>
                            </td>
                        </tr>
                         <tr>
                            <td width="50%">
                                <b>${_("Total of the day")}</b>
                            </td>
                            <td align="right" width="50%">
                                <b>${formatLang(gettotalofthaday(data['form']), dp='Sale Price', currency_obj = company.currency_id)}</b>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="3%">
                </td>
            </tr>
        </table>
        
     <p style="page-break-after:always">
        </p>
</body>
</html>