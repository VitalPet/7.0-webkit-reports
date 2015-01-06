<html>
<head>
    <style type="text/css">
            ${css}
        </style>
</head>
<body>
</br>
        </br>
        </br>
       
    %for o in objects:    
         </br>
        <table class="td_f12 tr_bottom_line_dark" width="40%" >
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
                <td width="3%"></td>
                <td class="td_f12" >
                    <b>${_('Shipping address :')}</b></br>
                    ${(o.dest_address_id and o.dest_address_id.name) or (o.warehouse_id and o.warehouse_id.name) or ''}</br>
                    ${(o.dest_address_id and display_address(o.dest_address_id)) or (o.warehouse_id and display_address(o.warehouse_id.partner_id)) or ''}</br>
                    </br>
                    
                    
                </td>
                <td class="td_f12" >
                    ${o.partner_id and o.partner_id and o.partner_id.name or '' }</br>
                    ${o.partner_id.street}</br>
                    ${o.partner_id.city or '' }&nbsp;${o.partner_id.zip or '' }</br>
                    ${o.partner_id.country_id.name or ''}
                </td>
                <td> </td>
            </tr>
        </table>
        </br>
        </br>
            %if o.state =='draft':
                <h1><b>Purchase Order Confirmation N° ${ o.name }</b></h1>
            %endif
            %if o.state <>'draft':
               <h1><b> Request for Quotation N° ${ o.name } </b></h1>
            %endif
        </br>
        </br>
        <table class="basic_table">
            <tr>
                <td width="25%">
                  <b>${_('Our Order Reference')}</b>
                </td>
                <td width="25%">
                  <b>${_('Your Order Reference')}</b>
                </td>
                <td width="25%">
                  <b>${_('Order Date')}</b>
                </td>
                <td width="25%">
                  <b>${_('Validated By')}</b>
                 </td>
              </tr>
              <tr>
                    <td>
                        ${ o.name or '' }
                    </td>
                    <td>
                        ${ o.partner_ref or '' }
                    </td>
                    <td>
                        ${ o.date_order }
                    </td>
                    <td>
                        ${ (o.validator and o.validator.name) or '' }
                    </td>
                </tr>
        </table>
        </br>
        </br>
        <table class="tr_bottom_line">
            <tr>
                <td width="34%">
                    <b>${_('Description')}</b>
                </td>
                <td width="10%">
                    <b>${_('Taxes')}</b>
                </td>
                <td width="15%">
                    <b>${_('Date Req.')}</b>
                </td>
                <td width="15%" align="right">
                    <b>${_('Qty')}</b>
                </td>
                <td width="13%" align="right">
                    <b>${_('Unit Price')}</b>
                </td>
                <td width="13%" align="right">
                    <b>${_('Net Price')}</b>
                </td>
              </tr>
        </table>
        %for line in o.order_line:
        <table class="tr_bottom_line_dark_grey">
            <tr>
              <td width="34%">
                    ${ line.name }
              </td>
              <td width="10%">
                    ${ ', '.join(map(lambda x: x.name, line.taxes_id)) }
              </td>
              <td width="15%">
                    ${ formatLang( line.date_planned, date=True)}
              </td>
              <td width="15%" align="right">
                    ${ formatLang(line.product_qty )} ${ line.product_uom.name }
              </td>
              <td width="13%" align="right">
                    ${ formatLang(line.price_unit, digits=get_digits(dp='Product Price') ) }
              </td>
              <td width="13%" align="right">
                    ${ formatLang(line.price_subtotal, digits=get_digits(dp='Account'), currency_obj=o.pricelist_id.currency_id ) }
              </td>
            </tr>
        </table>
         %endfor
         <table width="100%">
            <tr>
                <td width="70%">
                </td>
                <td width="30%">
                    <table class="tr_top">
                        <tr>                
                            <td>
                                Net Total :
                            </td>
                            <td>
                            </td>
                            <td align="right">
                                ${ formatLang(o.amount_untaxed, digits=get_digits(dp='Account'), currency_obj=o.pricelist_id.currency_id ) }
                            </td>
                       </tr>
                       <tr>
                           <td>
                              Taxes :
                           </td>
                           <td>
                           </td>
                           <td align="right">
                                ${ formatLang(o.amount_tax, dp='Account', currency_obj=o.pricelist_id.currency_id) }
                           </td>
                       </tr>
                    </table>
                    <table class="tr_top">
                        <tr>
                            <td>
                                <b>Total :</b>
                            </td>
                            <td>
                            </td>
                            <td>
                            <td align="right">
                                 <b>${ formatLang(o.amount_total, digits=get_digits(dp='Account') , currency_obj=o.pricelist_id.currency_id ) }</b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </br>
        <table>
              <tr>
                <td>
                    
                    ${ (o.notes or '') }
                </td>
              </tr>
        </table>
        <p style="page-break-after:always">
        </p>
    %endfor
</body>
</html>