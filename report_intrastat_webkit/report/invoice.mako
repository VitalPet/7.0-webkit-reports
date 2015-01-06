<html>
    <head>
        <style type="text/css">
                ${css}
            </style>
    </head>
    <body>
        %for o in objects:
            <% setLang(o.partner_id.lang) %>
            <table width="100%" class="td_f12">
                <tr>
                    <td width="60%">
                     
                    </td>
                    <td width="40%">
                        ${ (o.partner_id.title and o.partner_id.title.name) or '' } ${ (o.partner_id and o.partner_id.name) or '' }</br>
                        ${ o.partner_id.parent_id.name or '' }</br>
                        ${ o.partner_id.street or '' }</br>
                        ${ o.partner_id.city or '' }&nbsp;${ o.partner_id.zip or '' }</br>
                        ${ o.partner_id.country_id.name or '' }</br>
                        %if (o.partner_id.phone):
                            Tel. : ${ o.partner_id.phone or '' }</br>
                        %endif
                        %if o.partner_id.fax:
                            Fax : ${ o.partner_id.fax or '' }</br>
                        %endif
                        %if o.partner_id.vat:
                            ${ o.partner_id.vat or '' }
                        %endif
                    </td>
                </tr>
            </table>
            <b><h1>
            <p style="padding-top:20px;padding-bottom:20px">
               %if (o.type == 'out_invoice' and (o.state == 'open' or o.state == 'paid')):
                    ${ _('Invoice')} ${ o.number }
                %endif
                %if (o.type == 'out_invoice' and o.state == 'proforma2'):
                    ${ _('PRO-FORMA') }
                %endif
                %if (o.type == 'out_invoice' and o.state == 'draft'):
                    ${ _('Draft Invoice') }
                %endif
                %if (o.type == 'out_invoice' and o.state == 'cancel'):
                    ${ _('Cancelled Invoice') } ${ o.number }
                %endif
                %if o.type=='out_refund':
                    ${ _('Refund') } ${ o.number }
                %endif
                %if o.type=='in_refund':
                    ${ _('Supplier Refund') } ${ o.number }
                %endif
                %if o.type=='in_invoice':
                    ${ _('Supplier Invoice') } ${ o.number }
                %endif
            </p></h1>
            </b>
            <table  class="basic_table">
                <tr>
                    <td width="35%">
                        <b>${_('Document')}</b>
                    </td>
                    <td width="30%">
                        <b>${_('Invoice Date')}</b>
                    </td>
                    <td width="35%">
                        <b>${_('Partner Ref.')}</b>
                    </td>
                </tr>
                <tr>
                    <td width="35%">
                      ${ o.name or ' '} 
                    </td>
                    <td width="30%">
                      ${ formatLang(o.date_invoice,date=True) }
                    </td>
                    <td width="35%">
                      ${ (o.partner_id.ref) or ' ' }
                    </td>
                </tr>
            </table>
            </br>
            <table class="list_table">
                <tr>
                    <td width="23%">
                        ${_('Description')}
                    </td>
                    <td width="10%">
                        ${_('Taxes')}
                    </td>
                    <td width="12%">
                        ${_('Intrastat')}
                    </td>
                    <td width="9.5%">
                        ${_('Weight')}
                    </td>
                    <td align="right" width="12%">
                        ${_('Quantity')}
                    </td>
                    <td align="right" width="7.5%">
                        ${_('Unit Price')}
                    </td>
                    <td align="right" width="12%">
                        ${_('Disc. (%)')}
                    </td>
                    <td align="right" width="14%">
                        ${_('Price')}
                    </td>
                </tr>
            </table>
            %for l in o.invoice_line:
            <table class="tr_bottom_line_dark_grey">
                <tr>
                  <td width="23%">
                        ${  l.name }
                  </td>
                  <td width="10%">
                        ${  ', '.join([lt.name for lt in l.invoice_line_tax_id]) }
                  </td>
                  <td width="12%">
                        ${ l.product_id and l.product_id.intrastat_id and l.product_id.intrastat_id.name or ''}
                  </td>
                  <td width="9.5%">
                        ${ l.product_id and l.product_id.weight or ''}
                  </td>
                  <td align="right" width="12%">
                        ${ formatLang(l.quantity) } ${ (l.uos_id and l.uos_id.name) or '' }
                  </td>
                  <td align="right" width="7.5%">
                        ${ formatLang(l.price_unit) }
                  </td>
                  <td align="right" width="12%">
                        ${ l.discount and formatLang (l.discount) or '' }
                  </td>
                  <td align="right" width="14%">
                        ${ formatLang(l.price_subtotal, currency_obj=o.currency_id) }
                  </td>
                </tr>
                <tr>
                  <td>
                   
                  </td>
                </tr>
            </table>
            %endfor
            <table width="100%">
                <tr>
                    <td width="70%"></td>
                    <td width="30%">
                        <table class="tr_top">
                            <tr>
                                <td>
                                </td>
                                <td>
                                    ${_('Total (excl. taxes):')}
                                </td>
                                <td align="right">
                                    ${ formatLang(o.amount_untaxed, currency_obj=o.currency_id) }
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    ${_('Taxes:')} 
                                </td>
                                <td align="right">
                                    ${ formatLang(o.amount_tax, currency_obj=o.currency_id) }
                                </td>
                            </tr>
                         </table>
                         <table class="tr_top">
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <b>${_('Total (inclu. taxes):')}</b>
                                </td>
                                <td align="right">
                                    <b>${ (formatLang(o.amount_total, currency_obj=o.currency_id)) }</b>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="70%">
                        %for t in o.tax_line:
                            <table  class="list_table">
                                 <tr>
                                    <td width="60%">
                                        Tax 
                                    </td>
                                    <td width="20%">
                                        Base
                                    </td>
                                    <td width="20%">
                                        Amount
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                            <table class="tr_bottom_line_dark_grey">
                                <tr>
                                  <td width="60%">
                                        ${  t.name }
                                  </td>
                                  <td width="20%">
                                        ${ formatLang(t.base, digits=get_digits(dp=Account), currency_obj = o.currency_id) }
                                  </td>
                                  <td width="20%">
                                     ${ (t.tax_code_id and t.tax_code_id.notprintable)} ${ formatLang(t.amount, digits=get_digits(dp=Account), currency_obj=o.currency_id) }
                                  </td>
                                  <td>
                                  </td>
                                </tr>
                            </table>
                        %endfor
                    </td>
                </tr>
            </table>
            </br>
            <p class="td_f12">
                %if o.comment:
                    ${ (o.comment and format(o.comment )) }</p>
                %endif
                %if o.payment_term.note:
                    <p class="td_f12"> ${ (o.payment_term and o.payment_term.note and format(o.payment_term and o.payment_term.note))}</p>
                %endif
            %if o.fiscal_position.note: 
            <table class="td_f12">
              <tr>
                <td>
                    
                     Fiscal Position Remark : 
                </td>
                <td>
                    ${ (o.fiscal_position and o.fiscal_position.note and (o.fiscal_position.note)) }
                </td>
              </tr>
            </table>
            %endif
            <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>