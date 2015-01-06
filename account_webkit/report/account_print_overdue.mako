<html>
    <head>
        <style type="text/css">
            ${css}
        </style>
    </head>
    <body direction: rtl; onload="subst()">
        %for o in objects:
            </br></br></br>
            <table cellspacing="0" width="100%">
                <tr>
                    <td width="80%" >
                        <table class="td_f12 tr_bottom_line_dark" width="40%" >
                        <tr>
                            <td width="25%">Phone</td>
                            <td>:&nbsp;${ company.phone or ''}</td>
                        </tr>
                        <tr><u>
                            <td>Mail</td>
                            <td>:&nbsp;${ company.email or '' }</td></u>
                        </tr>
                        </table>
                    </td>
                    <td width="20%" class="td_f12">
                        ${ o.title.name or '' }&nbsp;${ o.name }</br>
                        ${ o.street or '' }</br>
                        ${ o.city or '' }&nbsp;${ o.zip or '' }</br>
                        ${ o.country_id.name or '' }</br>
                        </br>
                        %if o.vat:
                            ${ o.vat or '' }
                        %endif
                    </td>
                </tr>
            </table>
            </br>
            <p>Document: Customer account statement</p>
            <p>Date: ${ formatLang(time.strftime('%Y-%m-%d'),date=True) }</p> 
            <p>Customer Ref: ${ o.ref or ' '}</p>
            <br/>
            %if getLines(o):
                %for message_line in message(o, company):
                    <p class="td_f12">${ message_line }</p>
                %endfor
               
                <table class="tbl_header">
                    <tr>
                        <td width="11%" class="td_f12"><b>${ _('Date') }</b></td>
                        <td width="27%" class="td_f12"><b>${ _('Description') }</b></td>
                        <td width="10%" class="td_f12"><b>${ _('Ref') }</b></td>
                        <td width="14%" class="td_f12"><b>${ _('Maturity date') }</b></td>
                        <td width="11%" class="td_f12_right"><b>${ _('Due') }</b></td>
                        <td width="11%" class="td_f12_right"><b>${ _('Paid') }</b></td>
                        <td width="13%" class="td_f12_right"><b>${ _('Maturity') }</b></td>
                        <td width="3%" class="td_f12"><b>${ _('Li.') }</b></td>
                    </tr><tr><td colspan="8"><table class="tr_bottom_line"></table></td></tr>
                    <% rec = len(getLines(o)) %>
                    <% i = 1 %>
                    %for line in getLines(o):
                        <tr>
                            <td class="td_f10">${ formatLang(line['date'],date=True) }</td>
                            <td class="td_f10">${ line['name'] }</td>
                            <td class="td_f10">${ line['ref'] }</td>
                            <td class="td_f10">
                                %if line['date_maturity']:
                                    ${ formatLang(line['date_maturity'],date=True) or '' }
                                %endif
                            </td>
                            <td class="td_f10_right">
                                %if line['account_id']['type'] == 'receivable':
                                    ${ formatLang(line['debit']) or 0 }
                                %elif line['account_id']['type'] == 'payable':
                                    ${ formatLang(line['credit'] * -1) or 0 }
                                %endif
                            </td>
                            <td class="td_f10_right">
                                %if line['account_id']['type'] == 'receivable':
                                    ${ formatLang(line['credit']) or 0 }
                                %elif line['account_id']['type'] == 'payable':
                                    ${ formatLang(line['debit'] * -1) or 0 }
                                %endif
                            </td>
                            <td class="td_f10_right">
                                %if (time.strftime('%Y-%m-%d') > line['date_maturity']):
                                    ${ formatLang(line['debit'] - line['credit'], currency_obj = company.currency_id) }
                                %endif
                            </td>
                            <td class="td_f10">
                                %if line['blocked']:
                                    ${_('X')}
                                %else:
                                    ${_('')}
                                %endif
                            </td>
                        </tr>
                        %if i != rec:
                            <tr><td colspan="8"><table class="tr_bottom_line_light_grey"></table></td></tr>
                        %else:
                            <tr><td colspan="3"><table class="tr_bottom_line_light_grey"></table></td><td colspan="5"><table class="tr_bottom_line"></table></td></tr>
                        %endif
                        <% i=i+1 %>
                    %endfor
                    <tr>
                        <td colspan="3">&nbsp;</td>
                        <td class="td_f12"><b>${ _('Sub Total :') }</b></td>
                        <td class="td_f10_right">${ formatLang((reduce(lambda x, y: x + ((y['account_id']['type'] == 'receivable' and y['debit'] or 0) or (y['account_id']['type'] == 'payable' and y['credit'] * -1 or 0)), getLines(o), 0))) }</td>
                        <td class="td_f10_right">${ formatLang((reduce(lambda x, y: x + ((y['account_id']['type'] == 'receivable' and y['credit'] or 0) or (y['account_id']['type'] == 'payable' and y['debit'] * -1 or 0)), getLines(o), 0))) }</td>
                        <td class="td_f10_right">${ formatLang((reduce(lambda x, y: x + (y['debit'] - y['credit']), filter(lambda x: x['date_maturity'] < time.strftime('%Y-%m-%d'), getLines(o)), 0)), currency_obj=company.currency_id) }</td>
                        <td></td>
                    </tr><tr><td colspan="3"></td><td colspan="5"><table class="tr_bottom_line"></table></td></tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                        <td class="td_f12"><b>${ _('Balance :') }</b></td>
                        <td class="td_f12_right"><b>${ formatLang((reduce(lambda x, y: x +(y['debit'] - y['credit']), getLines(o), 0)), currency_obj = company.currency_id) }</b></td>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                </table>
                <p class="td_f12">Total amount due: ${ formatLang((reduce(lambda x, y: x + (y['debit'] - y['credit']), getLines(o), 0)), currency_obj=company.currency_id) }</p>
            %endif
            %if not getLines(o):
                ${ _('There is nothing due with this customer.') }
            %endif
            <p style="page-break-after:always;"></p>
        %endfor
    </body>
</html>