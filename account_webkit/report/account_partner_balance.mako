<html>
    <head>
        <style type="text/css">
            ${css}
        </style>
    </head>
    <body direction: rtl;>
        <center><h2>Partner Balance</h2></center>
        <table cellspacing="0" class="cell">
            <tr>
                <td class="cell" width="15%" ><center><b>${_('Chart of Accounts')}</b></center></td>
                <td class="cell" width="15%"><center><b>${_('Fiscal Year')}</b></center></td>
                <td class="cell" width="15%"><center><b>${_('Journals')}</b></center></td>
                <td class="cell" width="25%"><center><b>${_('Filter By')} 
                    %if data['form']['filter']!='filter_no' and get_filter(data):
                        ${ data['form']['filter']!='filter_no' and get_filter(data) }
                    %endif
                </b></center></td>
                <td class="cell" width="15%"><center><b>${_("Partner's")}</b></center></td>
                <td class="cell" width="15%"><center><b>${_('Target Moves')}</b></center></td>
            </tr>
            <tr>
                <td class="cell" "><center>
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
                    %if data['form']['filter']=='filter_no':
                        ${ get_filter(data) }
                    %endif
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
                    %if data['form']['filter']=='filter_period':
                        <table class="cell">
                            <tr>
                                <td class="cell"><center><b>${_('Start Period')}</b></center></td>
                                <td class="cell"><center><b>${_('End Period')}</b></center></td>
                            </tr>
                            <tr>
                                <td class="cell"><center>
                                    %if get_start_period(data):
                                        ${ get_start_period(data) }
                                    %endif
                                </center></td>
                                <td class="cell"><center>
                                    %if get_end_date(data):
                                        ${ get_end_date(data) }
                                    %endif
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
            <tr>
                <td align="center"><b>${_('Code')}</b></td>
                <td align="center"><b>${_('Partner Name/Account Name')}</b></td>
                <td align="right"><b>${_('Debit')}</b></td>
                <td align="right"><b>${_('Credit')}</b></td>
                <td align="right"><b>${_('Balance')}</b></td>
                <td align="right"><b>${_('In dispute')}</b></td>
            </tr>
            <tr><td colspan="6"><table class="tr_bottom_line"></table></td></tr>
            <tr>
                <td align="center"><b>${_('Total:')}</b></td>
                <td align="center"><b></b></td>
                <td align="right"><b><u>${ formatLang(sum_debit()) }</u></b></td>
                <td align="right"><b><u>${ formatLang(sum_credit()) }</u></b></td>
                <td align="right"><b><u>${ formatLang((sum_debit()-sum_credit()), currency_obj=company.currency_id) }</u></b></td>
                <td align="right"><b><u>${ formatLang(sum_litige(), currency_obj=company.currency_id) }</u></b></td>
            </tr>
            <tr><td colspan="6"><table class="tr_bottom_line"></table></td></tr>
            %for a in lines():
                <tr class="tr_bottom_line">
                    %if a['type']==3:
                        <td align="center"><b>${ a['ref'] or '' } ${ a['type']==3 and a['code'] or '' }</b></td>
                        <td align="center"><b>${ a['name'] }</b></td>
                        <td align="right"><b>${ formatLang(a['debit']) }</b></td>
                        <td align="right"><b>${ formatLang(a['credit']) }</b></td>
                        <td align="right"><b>${ formatLang(a['balance'],currency_obj=company.currency_id) }</b></td>
                        <td align="right"><b>${ formatLang(a['enlitige'] or 0.0,currency_obj=company.currency_id) }</b></td>
                    %elif a['type']!=3:
                        <td align="center">${ a['ref'] or '' } ${ a['type']==3 and a['code'] or '' }</td>
                        <td align="center">${ a['name'] }</td>
                        <td align="right">${ formatLang(a['debit']) }</td>
                        <td align="right">${ formatLang(a['credit']) }</td>
                        <td align="right">${ formatLang(a['balance'],currency_obj=company.currency_id) }</td>
                        <td align="right">${ formatLang(a['enlitige'] or 0.0,currency_obj=company.currency_id) }</td>
                    %endif
                </tr><tr><td colspan="6"><table class="tr_bottom_line"></table></td></tr>
            %endfor
        </table>
    </body>
</html>