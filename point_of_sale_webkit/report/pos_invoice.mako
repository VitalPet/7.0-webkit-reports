<html>
    <head>
        <style type="text/css">
            ${css}
        </style>
    </head>
    <body >
      
        %for o in objects:
            <% setLang(o.partner_id.lang) %>
            </br></br></br>
            <table cellspacing="0" width="100%">
                <tr>
                    <td width="70%" >
                        
                    </td>
                    <td width="30%" class="title">
                        ${ (o.partner_id and o.partner_id.title and o.partner_id.title.name) or '' }${ (o.partner_id and o.partner_id.name) or '' }</br>
                        ${ o.partner_id.parent_id.name or '' }</br>
                        ${ o.partner_id.street or '' }</br>
                        ${ o.partner_id.city or '' }&nbsp;${ o.partner_id.zip or '' }</br>
                        ${ o.partner_id.country_id.name or '' }</br>
                        </br>
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
            </br>
            <h2>
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
            </h2>
            </br>
            <table class="basic_table">
                <tr>
                    <td width="25%"><b>${_('Description')}</b></td>
                    <td  width="25%"><b>${_('Invoice Date')}</b></td>
                    <td  width="25%"><b>${_('Source')}</b></td>
                    <td  width="25%"><b>${_('Customer Code')}</b></td>
                </tr>
                <tr>
                    <td >${ o.name or '' }</td>
                    <td >${ formatLang(o.date_invoice,date=True) }</td>
                    <td >${ o.origin or '' }</td>
                    <td >${ o.partner_id.ref or '' }</td>
                </tr>
            </table>
            </br>
            <table class="list_table" cellspacing="0">
                <tr>
                    <th  width="35%"><b>${_('Description')}</b></th>
                    <th  width="13%"><center><b>${_('Taxes')}</b></center></th>
                    <th  width="15%" style="text-align:right"><b>${_('Quantity')}</b></th>
                    <th  width="11%" style="text-align:right"><b>${_('Unit Price')}</b></th>
                    <th  width="10%" style="text-align:right"><b>${_('Disc.(%)')}</b></th>
                    <th  width="16%" style="text-align:right"><b>${_('Price')}</b></th>
                </tr>
                <% rec = len(o.invoice_line) %>
                <% i = 1 %>
                %for l in o.invoice_line:
                    <tr>
                        <td >${ format(l.name) }</b></td>
                        <td ><center>${ ', '.join([ lt.name or '' for lt in l.invoice_line_tax_id ]) }</center></td>
                        <td style="text-align:right">${ formatLang(l.quantity) } ${ (l.uos_id and l.uos_id.name) or '' }</td>
                        <td style="text-align:right">${ formatLang(l.price_unit) }</td>
                        <td style="text-align:right">${ formatLang(l.discount, dp='Account') }</td>
                        <td style="text-align:right">${ formatLang(l.price_subtotal, dp='Account', currency_obj=o.currency_id) }</td>
                    </tr>
                   
                %endfor
                <tr>
                    <td colspan="3" style="border-bottom:0px;"></td>
                    <td  colspan="2" style="border-top:1px solid black;border-bottom:0px;">${ _('Net Total:') }</td>
                    <td style="border-top:1px solid black;text-align:right">${ formatLang(o.amount_untaxed, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</td>
                </tr>
                <tr>
                    <td style="border-bottom:0px;border-top:0px;" colspan="3"></td>
                    <td style="border-top:0px;border-bottom:0px" colspan="2">${ _('Taxes:') }</td>
                    <td align="right" style="border-top:0px;font-weight:none;text-align:right;">${ formatLang(o.amount_tax, dp='Account', currency_obj=o.currency_id) }</td>
                </tr>
                <tr>
                    <td colspan="3" style="border-bottom:0px;border-top:0px;"></td>
                    <td  colspan="2" style="border-bottom:0px;border-top:1px solid black;"><b>${ _('Total:') }</b></td>
                    <td style="border-bottom:0px;border-top:1px solid black;text-align:right;" ><b>${ formatLang(o.amount_total, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</b></td>
                </tr>
            </table>
            </br>
            %if o.tax_line!=[]:
                <table class="list_table" cellspacing="0">
                    <tr>
                        <th  width="39%"><b>${_('Tax')}</b></th>
                        <th  width="13%"><b>${_('Base')}</b></th>
                        <th  width="13%"><b>${_('Amount')}</b></th>
                        <th  width="35%"><b>${_('')}</b></th>
                    </tr>
                    %for t in o.tax_line:
                        %if not (t.tax_code_id and t.tax_code_id.notprintable):
                            <tr>
                                <td  width="39%">${ t.name }</td>
                                <td  width="13%">${ formatLang(t.base, dp='Account', currency_obj=o.currency_id) }</td>
                                <td  width="13%">${ formatLang(t.amount, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</td>
                                <td  width="35%">${_('')}</td>
                            </tr>
                        %endif
                    %endfor
                </table>
            %endif
            <p class="title">
                %if o.comment:
                    ${ format(o.comment) }
                %endif
            </p>
            </br>
            <p class="title">
                %if o.payment_term and o.payment_term.note:
                    ${ format(o.payment_term and o.payment_term.note) }
                %endif
            </p>
            <p style="page-break-after:always;"></p>
        %endfor
    </body>
</html>