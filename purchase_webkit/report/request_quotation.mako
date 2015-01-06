<html>
<head>
    <style type="text/css">
            ${css}
        </style>
    <title>requestforquotation.pdf</title>
</head>
<body>
    %for order in objects:
        </br>
        </br>
        </br>
        </br>
        <table class="td_f12" width="40%" >
            <tr>
                <td width="25%">Phone</td>
                <td>:&nbsp;${ company.phone or ''}</td>
            </tr>
            <tr>
                <td>Mail</td>
                <td>:&nbsp;${ company.email or '' }</td>
            </tr>
        </table>
        </br>
        </br>     
        <table width="100%">
            <tr>
                <td width="70%">
                  <table width="100%" class="td_f12">
                    <tr>
                      <td>
                        <b>Expected Delivery address:</b></br>
                        ${ (order.dest_address_id and order.dest_address_id.name) or (order.warehouse_id and order.warehouse_id.name) or ''}</br>
                        ${ order.dest_address_id and display_address(order.dest_address_id) }</br></br>
                      </td>
                    </tr>
                  </table>
                </td>
                <td>
                </td>
                <td width="70%" class="td_f12">
                  ${ (order .partner_id and order.partner_id.title and order.partner_id.title.name) or '' } ${ (order .partner_id and order.partner_id.name) or '' }</br>
                  ${ order.partner_id and display_address(order .partner_id) }</br>
                  Tel.: ${ (order.partner_id and order.partner_id.phone) or '' }</br>
                  Fax: ${ (order.partner_id and order.partner_id.fax) or ''}</br>
                  TVA: ${ (order.partner_id and order.partner_id.vat) or '' }</br>
                </td>
              </tr>
        </table>
        </br>
        <b>Request for Quotation : ${ order.name }</b>
        <table class="tr_bottom_line">
            <tr>
                <td width="65%">
                  <b>${_('Description')}</b>
                </td>
                <td width="20%">
                  <b>${_('Expected Date')}</b>
                </td>
                <td width="15%">
                  <b>${_('Qty')}</b>
                </td>
              </tr>
        </table>
        %for  order_line in  order.order_line:
        <table  class="tr_bottom_line_dark_grey">
            <tr>
          <td width="65%">
                ${ order_line.name }
          </td>
          <td width="20%">
                ${ formatLang(order_line.date_planned, date = True) }
          </td>
          <td width="15%" align="right">
                ${ formatLang(order_line.product_qty )}
                <i>${ (order_line.product_uom and order_line.product_uom.name) or '' }</i>
          </td>
        </tr>
        </table>
         %endfor
        </br>
        <p class="td_f12">
        ${ order.notes or '' }</br>
        ${_('Regards,')}
        </br>
        ${ user.signature or ''}</br>
        </p>
        
       <p style="page-break-after:always">
        </p>
       
    %endfor
</body>
</html>