<html>
<head>
    <style type="text/css">
        ${css}
    </style>
</head>
<body>
    <center><h2>Details of Sales<h2></center>
    <table class="basic_table">
        <tr>
            <td width="25%">
                <b>${_("Company")}</b>
            </td>
            <td width="25%">
                <b>${_("Print Date")}</b>
            </td>
            <td width="25%">
                <b>${_("Start Period")}</b>
            </td>
            <td width="25%">
                <b>${_("End Period")}</b>
            </td>
        </tr>
        <tr>
            <td>
                ${company.name}
            </td>
            <td>
                ${formatLang(time.strftime('%Y-%m-%d'),date=True)}
            </td>
            <td>
                ${'%s' % getstartperiod(objects)}
            </td>
            <td>
                ${'%s' % getendperiod(objects)}
            </td>
        </tr>
    </table>
    </br>
    <table class="list_table">
        <tr>
            <th width="40%">
                ${_("Mode of Taxes")}
            </th>
            <th width="60%"></th>
        </tr>
        %for p in gettaxamount(objects).items():
            <tr>
                <td width="50%">
                    ${p[0].name}
                </td>
                <td align="right" width="50%">
                    <b>${formatLang(p[1], currency_obj=company.currency_id)}</b>
                </td>
            </tr> 
        %endfor 
    </table>
    </br>
    <table class="list_table">
         <tr>
            <th width="60%">
                ${_("Mode of Payment")}
            </th>
            <th width="40%"></th>
         </tr>
         %for t in getpayments(objects).items():
            <tr>
                <td width="40%">
                    ${t[0].name}
                </td>
                <td align="right" width="60%">
                   <b> ${formatLang(t[1], currency_obj=company.currency_id)}</b>
                </td>
            </tr>
          %endfor
      </table>
      </br>
      <table class="list_table">
            <tr>
                <th width="40%" >
                    ${_("Summary")}
                </th>
                <th width="60%"></th>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Sales total")}</b>
                </td>
                <td align="right" width="60%">
                   <b> ${'%d' % getsalestotal(objects)}</b>
                </td>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Qty of product")}</b>
                </td>
                <td align="right" width="60%">
                    <b>${'%d' % getqtytotal(objects)}</b>
                </td>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Total invoiced")}</b>
                </td>
                <td align="right" width="60%">
                    <b>${formatLang(getsuminvoice(objects), currency_obj=company.currency_id)}</b>
                </td>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Total discount")}</b>
                </td>
                <td align="right" width="60%">
                    <b>${formatLang(getsumdisc(objects), currency_obj=company.currency_id)}</b>
                </td>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Total paid")}</b>
                </td>
                <td align="right" width="60%">
                    <b>${formatLang(getpaidtotal(objects), currency_obj=company.currency_id)}</b>
                </td>
            </tr>
             <tr>
                <td width="40%">
                    <b>${_("Total of the day")}</b>
                </td>
                <td align="right" width="60%">
                    <b>${formatLang(gettotalofthaday(objects), currency_obj=company.currency_id)}</b>
                </td>
            </tr>
    </table>
     <p style="page-break-after:always">
            </p>
</body>
</html>