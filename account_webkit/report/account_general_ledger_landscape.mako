<html>
    <head>
        <style type="text/css">
            ${css}
        </style>
    </head>
    <body direction: rtl;>
        %for a in objects:
            </br>
            <center><h2>General Ledger</h2></center>
            <table cellspacing="0" class="cell" >
                <tr>
                    <td class="cell td_f12" width="14%"><b>
                        %if data['model']=='account.account':
                            ${ _('Company') }
                        %endif
                        %if data['model']=='ir.ui.menu':
                            ${ _('Chart of Accounts') }
                        %endif</b>
                    </td>
                    <td class="cell td_f12" width="14%"><b>${ _('Fiscal Year') }</b></td>
                    <td class="cell td_f12" width="14%"><b>${ _('Journals') }</b></td>
                    <td class="cell td_f12" width="14%"><b>${ _('Display Account') }</b></td>
                    <td class="cell td_f12" width="14%"><b>${ _('Filter By') }
                        %if data['form']['filter']!='filter_no':
                            ${ get_filter(data) }
                        %endif</b>
                    </td>
                    <td class="cell td_f12" width="17%"><b>${ _('Entries Sorted By') }</b></td>
                    <td class="cell td_f12" width="13%"><b>${ _('Target Moves') }</b></td>
                </tr>
                <tr>
                    <td class="cell">
                        %if get_account(data):
                            ${ get_account(data) }
                        %endif
                    </td>
                    <td class="cell">${ get_fiscalyear(data) or '' }</td>
                    <td class="cell">${ ', '.join([ lt or '' for lt in get_journal(data) ]) }</td>
                    <td class="cell">
                        %if data['form']['display_account']=='all':
                            ${ _('All') }
                        %elif data['form']['display_account']=='movement':
                            ${ _('With movements') }
                        %else:
                            ${ _('With balance is not equal to 0') }
                        %endif
                    </td>
                    <td class="cell">
                        %if data['form']['filter']=='filter_no':
                            ${ get_filter(data) }
                        %endif
                        %if data['form']['filter']=='filter_date':
                            <table cellspacing="0" class="cell">
                                <tr>
                                    <td class="cell">${ _('Start Date') }</td>
                                    <td class="cell">${ _('End Date') }</td>
                                </tr>
                                <tr>
                                    <td class="cell">${ formatLang(get_start_date(data),date=True) }</td>
                                    <td class="cell">${ formatLang(get_end_date(data),date=True) }</td>
                                </tr>
                            </table>
                        %endif
                        %if data['form']['filter']=='filter_period':
                            <table cellspacing="0" class="cell">
                                <tr>
                                    <td class="cell">${ _('Start Period') }</td>
                                    <td class="cell">${ _('End Period') }</td>
                                </tr>
                                <tr>
                                    <td class="cell">${ get_start_period(data) }</td>
                                    <td class="cell">${ get_end_period(data) }</td>
                                </tr>
                            </table>
                        %endif
                    </td>
                    <td class="cell">${ get_sortby(data) }</td>
                    <td class="cell">${ get_target_move(data) }</td>
                </tr>
            </table>
            %if data['form']['amount_currency'] == True:
                </br>
                <table class="tbl_header">
                    <tr>
                        <td class="td_f12" width="6%"><b>${ _('Date') }</b></td>
                        <td class="td_f12" width="5%"><b>${ _('Period') }</b></td>
                        <td class="td_f12" width="4%"><b>${ _('JRNL') }</b></td>
                        <td class="td_f12" width="12%"><b>${ _('Partner') }</b></td>
                        <td class="td_f12" width="8%"><b>${ _('Ref') }</b></td>
                        <td class="td_f12" width="7%"><b>${ _('Move') }</b></td>
                        <td class="td_f12" width="13%"><b>${ _('Entry Label') }</b></td>
                        <td class="td_f12" width="9%"><b>${ _('Counterpart') }</b></td>
                        <td class="td_f12_right" width="8%"><b>${ _('Debit') }</b></td>
                        <td class="td_f12_right" width="8%"><b>${ _('Credit') }</b></td>
                        <td class="td_f12_right" width="10%"><b>${ _('Balance') }</b></td>
                        <td class="td_f12_right" width="10%"><b>${ _('Currency') }</b></td>
                    </tr><tr><td colspan="12"><table class="tr_bottom_line"></table></td></tr>
                    %for o in get_children_accounts(a):
                        <tr>
                            <td class="td_f12" colspan="8"><b>${ '  '*(o.level-1) } ${ o.code } ${ o.name }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_debit_account(o), digits=get_digits(dp='Account')) }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_credit_account(o), digits=get_digits(dp='Account')) }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_balance_account(o), digits=get_digits(dp='Account')) }</b></td>
                            <td class="td_f12_right"><b>
                                %if o.currency_id:
                                    ${ formatLang(sum_currency_amount_account(o), digits=get_digits(dp='Account'),currency_obj=o.currency_id) or '' }
                                %endif</b>
                            </td>
                        </tr><tr><td colspan="12"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                        %for line in lines(o):
                            <tr height="5.5mm">
                                <td class="td_f10"><div class="nobrk">${ formatLang(line['ldate'],date=True) }</div></td>
                                <td class="td_f10"><div class="nobrk">${ line['period_code'] }</div></td>
                                <td class="td_f10"><div class="nobrk">${ line['lcode'] }</div></td>
                                <td class="td_f10"><div class="nobrk">${ strip_name(line['partner_name'] or '',20) }</div></td>
                                <td class="td_f10"><div class="nobrk">${ line['lref'] and strip_name(line['lref'],17) }</div></td>
                                <td class="td_f10"><div class="nobrk">${ line['move'] }</div></td>
                                <td class="td_f10"><div class="nobrk">${ strip_name(line['lname'],22) }</div></td>
                                <td class="td_f10"><div class="nobrk">${ strip_name(line['line_corresp'],18) }</div></td>
                                <td class="td_f10_right"><div class="nobrk">${ formatLang(line['debit'], digits=get_digits(dp='Account')) }</div></td>
                                <td class="td_f10_right"><div class="nobrk">${ formatLang(line['credit'], digits=get_digits(dp='Account')) }</div></td>
                                <td class="td_f10_right"><div class="nobrk">${ formatLang(line['progress'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }</div></td>
                                <td class="td_f10_right"><div class="nobrk">
                                    %if not (line.has_key('currency_id') and line['currency_id']==None or line['amount_currency']==None):
                                        ${ formatLang(line['amount_currency']) } ${ line['currency_code'] or '' }
                                    %endif
                                </div></td>
                            </tr><tr><td colspan="12"><div class="nobrk"><table class="tr_bottom_line_light_grey"></table></div></td></tr>
                        %endfor
                    %endfor
                </table>
            %endif
            %if data['form']['amount_currency'] == False:
                </br>
                <table class="tbl_header">
                    <tr>
                        <td class="td_f12" width="7%"><b>${ _('Date') }</b></td>
                        <td class="td_f12" width="6%"><b>${ _('Period') }</b></td>
                        <td class="td_f12" width="5%"><b>${ _('JRNL') }</b></td>
                        <td class="td_f12" width="13%"><b>${ _('Partner') }</b></td>
                        <td class="td_f12" width="9%"><b>${ _('Ref') }</b></td>
                        <td class="td_f12" width="8%"><b>${ _('Move') }</b></td>
                        <td class="td_f12" width="13%"><b>${ _('Entry Label') }</b></td>
                        <td class="td_f12" width="10%"><b>${ _('Counterpart') }</b></td>
                        <td class="td_f12_right" width="9%"><b>${ _('Debit') }</b></td>
                        <td class="td_f12_right" width="9%"><b>${ _('Credit') }</b></td>
                        <td class="td_f12_right" width="11%"><b>${ _('Balance') }</b></td>
                    </tr><tr><td colspan="11"><table class="tr_bottom_line"></table></td></tr>
                    %for o in get_children_accounts(a):
                        <tr>
                            <td class="td_f12" colspan="8"><b>${ '  '*(o.level-1) } ${ o.code } ${ o.name }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_debit_account(o), digits=get_digits(dp='Account')) }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_credit_account(o), digits=get_digits(dp='Account')) }</b></td>
                            <td class="td_f12_right"><b>${ formatLang(sum_balance_account(o), digits=get_digits(dp='Account')) }</b></td>
                        </tr><tr><td colspan="11"><table class="tr_bottom_line_dark_grey"></table></td></tr>
                        %for line in lines(o):
                            <tr height="5.5mm">
                                <td class="td_f10">${ formatLang(line['ldate'],date=True) }</td>
                                <td class="td_f10">${ line['period_code'] }</td>
                                <td class="td_f10">${ line['lcode'] }</td>
                                <td class="td_f10">${ strip_name(line['partner_name'] or '',20) }</td>
                                <td class="td_f10">${ line['lref'] and strip_name(line['lref'],17) }</td>
                                <td class="td_f10">${ line['move'] }</td>
                                <td class="td_f10">${ strip_name(line['lname'],22) }</td>
                                <td class="td_f10">${ strip_name(line['line_corresp'],18) }</td>
                                <td class="td_f10_right">${ formatLang(line['debit'], digits=get_digits(dp='Account')) }</td>
                                <td class="td_f10_right">${ formatLang(line['credit'], digits=get_digits(dp='Account')) }</td>
                                <td class="td_f10_right">${ formatLang(line['progress'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }</td>
                            </tr><tr><td colspan="11"><table class="tr_bottom_line_light_grey"></table></td></tr>
                        %endfor
                    %endfor
                </table>
            %endif
            <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>
