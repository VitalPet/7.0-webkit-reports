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
            <table cellspacing="0" width="100%">
                <tr>
                    <td width="80%" >
                        
                    </td>
                    <td width="20%" class="td_f12">
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
            <table class="tbl_header" cellspacing="0">
                <tr>
                    <td class="cell" width="25%"><b>${_('Description')}</b></td>
                    <td class="cell" width="25%"><b>${_('Invoice Date')}</b></td>
                    <td class="cell" width="25%"><b>${_('Source')}</b></td>
                    <td class="cell" width="25%"><b>${_('Customer Code')}</b></td>
                </tr>
                <tr>
                    <td class="tb_f10 cell">${ o.name or '' }</td>
                    <td class="tb_f10 cell">${ formatLang(o.date_invoice,date=True) }</td>
                    <td class="tb_f10 cell">${ o.origin or '' }</td>
                    <td class="tb_f10 cell">${ o.partner_id.ref or '' }</td>
                </tr>
            </table>
            </br>
            <table class="tbl_header" cellspacing="0">
                <tr>
                    <td class="tb_f12" width="35%"><b>${_('Description')}</b></td>
                    <td class="tb_f12" width="13%"><center><b>${_('Taxes')}</b></center></td>
                    <td class="tb_f12_right" width="15%"><b>${_('Quantity')}</b></td>
                    <td class="tb_f12_right" width="11%"><b>${_('Unit Price')}</b></td>
                    <td class="tb_f12_right" width="09%"><b>${_('Disc.(%)')}</b></td>
                    <td class="tb_f12_right" width="16%"><b>${_('Price')}</b></td>
                </tr><tr><td colspan="6"><table class="tr_bottom_line"></table></td></tr>
                <% rec = len(o.invoice_line) %>
                <% i = 1 %>
                %for l in o.invoice_line:
                    <tr>
                        <td class="tb_f10">${ format(l.name) }</b></td>
                        <td class="tb_f10"><center>${ ', '.join([ lt.name or '' for lt in l.invoice_line_tax_id ]) }</center></td>
                        <td class="tb_f10">${ formatLang(l.quantity) } ${ (l.uos_id and l.uos_id.name) or '' }</td>
                        <td class="tb_f10">${ formatLang(l.price_unit) }</td>
                        <td class="tb_f10">${ formatLang(l.discount, dp='Account') }</td>
                        <td class="tb_f10">${ formatLang(l.price_subtotal, dp='Account', currency_obj=o.currency_id) }</td>
                    </tr>
                    %if i != rec:
                        <tr><td colspan="6"><table class="tr_bottom_line_light_grey"></table></td></tr>
                    %else:
                        <tr><td colspan="3"><table class="tr_bottom_line_light_grey"></table></td><td colspan="3"><table class="tr_bottom_line"></table></td></tr>
                    %endif
                    <% i=i+1 %>
                %endfor
                <tr>
                    <td colspan="3"></td>
                    <td class="tb_f12" colspan="2">${ _('Net Total:') }</td>
                    <td class="tb_f12">${ formatLang(o.amount_untaxed, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</td>
                </tr>
                <tr>
                    <td colspan="3"></td>
                    <td class="tb_f12" colspan="2">${ _('Taxes:') }</td>
                    <td class="tb_f12">${ formatLang(o.amount_tax, dp='Account', currency_obj=o.currency_id) }</td>
                </tr><tr><td colspan="3"></td><td colspan="3"><table class="tr_bottom_line"></table></td></tr>
                <tr>
                    <td colspan="3"></td>
                    <td class="tb_f12" colspan="2"><b>${ _('Total:') }</b></td>
                    <td class="tb_f12"><b>${ formatLang(o.amount_total, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</b></td>
                </tr>
            </table>
            </br>
            %if o.tax_line!=[]:
                <table class="tbl_header" cellspacing="0">
                    <tr>
                        <td class="tb_f12" width="39%"><b>${_('Tax')}</b></td>
                        <td class="tb_f12" width="13%"><b>${_('Base')}</b></td>
                        <td class="tb_f12" width="13%"><b>${_('Amount')}</b></td>
                        <td class="tb_f12" width="35%"><b>${_('')}</b></td>
                    </tr><tr><td colspan="3"><table class="tr_bottom_line"></table></td></tr>
                    %for t in o.tax_line:
                        %if not (t.tax_code_id and t.tax_code_id.notprintable):
                            <tr>
                                <td class="tb_f12" width="39%">${ t.name }</td>
                                <td class="tb_f12" width="13%">${ formatLang(t.base, dp='Account', currency_obj=o.currency_id) }</td>
                                <td class="tb_f12" width="13%">${ formatLang(t.amount, digits=get_digits(dp='Account'), currency_obj=o.currency_id) }</td>
                                <td class="tb_f12" width="35%">${_('')}</td>
                            </tr><tr><td colspan="3"><table class="tr_bottom_line_light_grey"></table></td></tr>
                        %endif
                    %endfor
                </table>
            %endif
            <p class="tb_f10">
                %if o.comment:
                    ${ format(o.comment) }
                %endif
            </p>
            </br>
            <p class="tb_f10">
                %if o.payment_term and o.payment_term.note:
                    ${ format(o.payment_term and o.payment_term.note) }
                %endif
            </p>
            <p style="page-break-after:always;"></p>
        %endfor
    </body>
</html>