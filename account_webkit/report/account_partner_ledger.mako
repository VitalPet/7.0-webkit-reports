<html>
    <head>
        <style type="text/css">
            ${css}
        </style>
    </head>
    <body direction: rtl; onload="subst()">
        %for p in objects:
            <% setLang(p.lang) %>
            </br>
            <center><h2>Partner Ledger</h2></center>
            <table cellspacing="0" class="cell">
                <tr>
                <td class="cell" width="15%" ><center><b>${_('Chart of Accounts')}</b></center></td>
                <td class="cell" width="15%"><center><b>${_('Fiscal Year')}</b></center></td>
                <td class="cell" width="15%"><center><b>${_('Journals')}</b></center></td>
                <td class="cell" width="25%"><center><b>${_('Filter By')} 
                        %if data['form']['filter'] not in ('filter_no','unreconciled'):
                            ${ get_filter(data) }
                        %endif
                    </b></center></td>
                    <td class="cell" width="15%"><center><b>${_("Partner's")}</b></center></td>
                    <td class="cell" width="15%"><center><b>${_('Target Moves')}</b></center></td>
                </tr>
                <tr>
                    <td class="cell"><center>
                        %if get_account(data):
                            ${ get_account(data) }
                        %endif
                    </center></td>
                    
                    <td class="cell"><center>
                        %if get_fiscalyear(data):
                            ${ get_fiscalyear(data) }
                        %endif
                    </center></td>
                    
                    <td class="cell"><center>${ ', '.join([ lt or '' for lt in get_journal(data) ]) }</center></td>
                    
                    <td class="cell"><center>
                        %if data['form']['filter'] in ('filter_no','unreconciled'):
                            ${ get_filter(data) }
                        %endif
                        %if data['form']['filter']=='filter_date':
                            ${ get_filter(data) }
                            %if data['form']['filter']=='filter_date':
                                <table class="cell">
                                    <tr>
                                        <td class="cell"><center><b>${_('Start Date')}</b></center></td>
                                        <td class="cell"><center><b>${_('End Date')}</b></center></td>
                                    </tr>
                                    <tr>
                                        <td class="cell"><center>${ formatLang(get_start_date(data),date=True) }</center></td>
                                        <td class="cell"><center>${ formatLang(get_end_date(data),date=True) }</center></td>
                                    </tr>
                                </table>
                            %endif
                        %endif    
                        %if data['form']['filter']=='filter_period':
                            ${ get_filter(data) }
                                <table class="cell">
                                    <tr>
                                        <td class="cell"><center><b>${_('Start Period')}</b></center></td>
                                        <td class="cell"><center><b>${_('End Period')}</b></center></td>
                                    </tr>
                                    <tr>
                                        <td class="cell"><center>
                                                ${ get_start_period(data) }
                                        </center></td>
                                        <td class="cell"><center>
                                                ${ get_end_period(data) }
                                         </center></td>
                                    </tr>
                                </table>
                            
                        %endif
                    </center></td>
                    <td class="cell"><center>${ get_partners() }</center></td>
                    <td class="cell"><center>${ get_target_move(data) }</center></td>
                </tr>
            </table>
            </br>
            <table class="tbl_header">
                %if display_currency(data) == False:
                    <tr>
                        <td class="td_f12" width="9%"><b>${_('Date')}</b></td>
                        <td class="td_f12" width="5%"><b>${_('JRNL')}</b></td>
                        <td class="td_f12" width="12%"><b>${_('Ref')}</b></td>
                        <td class="td_f12" width="12%"><b>${_('Account')}</b></td>
                        <td class="td_f12" width="24%"><b>${_('Entry Label')}</b></td>
                        <td class="td_f12_right" width="12%"><b>${_('Debit')}</b></td>
                        <td class="td_f12_right" width="12%"><b>${_('Credit')}</b></td>
                        <td class="td_f12_right" width="14%"><b>${_('Balance')}</b></td>
                    </tr><tr><td colspan="8"><table class="tr_bottom_line"></table></td></tr>
                    <tr>
                        <td colspan="5" class="td_f12"><b> ${p.ref or ''} - ${p.name or ''}</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_debit_partner(p))) }</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_credit_partner(p))) }</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_debit_partner(p) - sum_credit_partner(p)), currency_obj=company.currency_id) }</b></td>
                    </tr><tr><td colspan="5"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                    %if data['form']['initial_balance']==True:
                        <tr>
                            <td colspan="5" class="td_f12"><b>Initial Balance</b></td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][0]) }</td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][1]) }</td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][2], currency_obj=company.currency_id) }</td>
                        </tr><tr><td colspan="5"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                    %endif
                    %for line in lines(p):
                        <tr>
                            <td class="td_f10">${ formatLang(line['date'],date=True) }</td>
                            <td class="td_f10">${ line['code'] }</td>
                            <td class="td_f10">${ line['move_name'] }</td>
                            <td class="td_f10">${ line['a_code'] }</td>
                            <td class="td_f10">${ line['ref'] and strip_name(line['ref'],10) } - ${ strip_name(line['name'],15) }</td>
                            <td class="td_f10_right">${ formatLang((line['debit'])) }</td>
                            <td class="td_f10_right">${ formatLang((line['credit'])) }</td>
                            <td class="td_f10_right">${ formatLang((line['progress']), currency_obj=company.currency_id) }</td>
                        </tr><tr><td colspan="8"><table class="tr_bottom_line_light_grey"></table></td></tr>
                    %endfor
                %endif
                %if display_currency(data) == True:
                    <tr>
                        <td class="td_f12" width="9%"><b>${_('Date')}</b></td>
                        <td class="td_f12" width="5%"><b>${_('JRNL')}</b></td>
                        <td class="td_f12" width="12%"><b>${_('Ref')}</b></td>
                        <td class="td_f12" width="12%"><b>${_('Account')}</b></td>
                        <td class="td_f12" width="24%"><b>${_('Entry Label')}</b></td>
                        <td class="td_f12_right" width="12%"><b>${_('Debit')}</b></td>
                        <td class="td_f12_right" width="12%"><b>${_('Credit')}</b></td>
                        <td class="td_f12_right" width="7%"><b>${_('Balance')}</b></td>
                        <td class="td_f12_right" width="7%"><b>${_('Currency')}</b></td>
                    </tr><tr><td colspan="8"><table class="tr_bottom_line"></table></td></tr>
                    <tr>
                        <td colspan="5" class="td_f12"><b> ${p.ref or ''} - ${p.name or ''}</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_debit_partner(p))) }</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_credit_partner(p))) }</b></td>
                        <td class="td_f12_right"><b>${ formatLang((sum_debit_partner(p) - sum_credit_partner(p)), currency_obj=company.currency_id) }</b></td>
                        <td>&nbsp;</td>
                    </tr><tr><td colspan="5"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                     %if data['form']['initial_balance']==True:
                        <tr>
                            <td colspan="5" class="td_f12"><b>${_('Initial Balance')}</b></td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][0]) }</td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][1]) }</td>
                            <td class="td_f12_right">${ formatLang(get_intial_balance(p)[0][2], currency_obj=company.currency_id) }</td>
                            <td>&nbsp;</td>
                        </tr><tr><td colspan="5"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                    %endif
                    %for line in lines(p):
                        <tr>
                            <td class="td_f10">${ formatLang(line['date'],date=True) }</td>
                            <td class="td_f10">${ line['code'] }</td>
                            <td class="td_f10">${ line['move_name'] }</td>
                            <td class="td_f10">${ line['a_code'] }</td>
                            <td class="td_f10">${ line['ref'] and strip_name(line['ref'],10) } - ${ strip_name(line['name'],15) }</td>
                            <td class="td_f10_right">${ formatLang((line['debit'])) }</td>
                            <td class="td_f10_right">${ formatLang((line['credit'])) }</td>
                            <td class="td_f10_right">${ formatLang((line['progress']), currency_obj=company.currency_id) }</td>
                            <td class="td_f10_right">
                                %if (line['currency_id']==None or line['amount_currency']==None):
                                    ${ formatLang(line['amount_currency']) } ${ line['currency_code'] or '' }
                                %endif
                            </td>
                        </tr><tr><td colspan="8"><table class="tr_bottom_line_light_grey"></table></td></tr>
                    %endfor
                %endif
            </table>
            <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>