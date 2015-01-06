<html>
    <head>
        <style type="text/css">
		
			table.mystyle{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-style: solid;
				border: 1px solid grey;
				font-size: 100%;}

			.mystyle td, .mystyle th{
				margin: 0;
				padding: 4px;
				border-width: 1px 1px 1px 1px;
				border-style: solid;
				border: 1px solid grey;
				font-size: 70%;}
				
			table.mystyleone{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-color: black;
				border-style: solid;
				font-size: 100%;}

			.mystyleone tr{
				margin: 0;
				padding: 4px;
				border-width: 0 0 1px 0;
				border-color: black;
				border-style: solid;
				font-size: 70%;}
		</style>
    </head>
    <body>
        <center><h2>${ data['form']['account_report_id'][1] }</h2></center>
        <table cellspacing="0" class='mystyle' width="100%">
            <tr>
                <td class="cell td_f12" width="33%" align="center"><b>${ _('Chart of Accounts') }</b></td>
                <td class="cell td_f12" width="33%" align="center"><b>${ _('Fiscal Year') }</b></td>
                <td class="cell td_f12" width="34%" align="center"><b>${ _('Filter By') }
                    %if data['form']['filter']!='filter_no':
                        ${ get_filter(data) }
                    %endif</b>
                </td>
            </tr>
            <tr>
                <td class="cell" align="center">
                    %if get_account(data):
                        ${ get_account(data) }
                    %endif
                </td>
                <td class="cell" align="center">${ get_fiscalyear(data) or '' }</td>
                <td class="cell" align="center">
                    %if get_filter(data)=='No Filters':
                        ${ get_filter(data) }
                    %endif
                    %if get_filter(data)=='Date':
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
                    %if get_filter(data)=='Periods':
                        <table cellspacing="0" class="cell tbl_header">
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
            </tr>
        </table>
        <br/>
        %if data['form']['debit_credit'] == 1:
            <table class="mystyleone" width="100%">
                <tr>
                    <td class="td_f12" width="44%"><b>${ _('Name') }</b></td>
                    <td class="td_f12_right" width="11%"><b>${ _('Debit') }</b></td>
                    <td class="td_f12_right" width="11%"><b>${ _('Credit') }</b></td>
                    <td class="td_f12_right" width="14%"><b>${ _('Balance') }</b></td>
                </tr>
                </table>
                <table width="100%">
                %for a in get_lines(data):
                    %if a.get('level') != 0:
                        <tr>
                            <td class="font${ min(6,a.get('level'))} padding${ min(6,a.get('level'))}" width="44%" style="font-size: 70%;"><b>${ a.get('name') }</b></td>
                            <td class="font${ min(6,a.get('level'))} right" width="11%">${ formatLang(a.get('debit',0.0), currency_obj = company.currency_id) }</td>
                            <td class="font${ min(6,a.get('level'))} right" width="11%">${ formatLang(a.get('credit',0.0), currency_obj = company.currency_id) }</td>
                            <td class="font${ min(6,a.get('level'))} right" width="14%">
                                %if (a.get('account_type') =='view' and a.get('level') != 1):
                                    <u>${ formatLang(a.get('balance'), currency_obj = company.currency_id) }</u>
                                %endif
                                %if (a.get('account_type') !='view' or a.get('level') == 1):
                                    ${ formatLang(a.get('balance'), currency_obj = company.currency_id) }
                                %endif
                            </td>
                        </tr>
                        %if a.get('level')==1:
                            <tr></tr>
                        %endif
                    %endif
                %endfor
            </table>
        %endif
        %if (not data['form']['enable_filter'] and not data['form']['debit_credit']):
            <table class="mystyleone" width="100%">
                <tr>
                    <td class="td_f12" width="80%"><b>${ _('Name') }</b></td>
                    <td class="td_f12_right" width="20%"><b>${ _('Balance') }</b></td>
                </tr><tr></tr>
                %for a in get_lines(data):
                    %if a.get('level') != 0:
                        <tr>
                            <td class="font${ min(6,a.get('level'))} padding${ min(6,a.get('level'))}">${ a.get('name') }</td>
                            <td class="font${ min(6,a.get('level'))} right">
                                %if (a.get('account_type') =='view' and a.get('level') != 1):
                                    <u>${ formatLang(a.get('balance'), currency_obj = company.currency_id) }</u>
                                %endif
                                %if (a.get('account_type') !='view' or a.get('level') == 1):
                                    ${ formatLang(a.get('balance'), currency_obj = company.currency_id) }
                                %endif
                            </td>
                        </tr>
                        %if a.get('level')==1:
                            <tr></tr>
                        %endif
                    %endif
                %endfor
            </table>
        %endif
        %if (data['form']['enable_filter'] == 1 and not data['form']['debit_credit']):
            <table class="mystyleone" width="100%">
                <tr>
                    <td class="td_f12" width="56%"><b>${ _('Name') }</b></td>
                    <td class="td_f12_right" width="22%"><b>${ _('Balance') }</b></td>
                    <td class="td_f12_right" width="22%"><b>${ data['form']['label_filter'] }</b></td>
                </tr>
                %for a in get_lines(data):
                    %if a.get('level') != 0:
                        <tr>
                            <td class="font${ min(6,a.get('level'))} padding${ min(6,a.get('level'))}">${ a.get('name') }</td>
                            <td class="font${ min(6,a.get('level'))} right">
                                %if (a.get('account_type') =='view' and a.get('level') != 1):
                                    <u>${ formatLang(a.get('balance'), currency_obj = company.currency_id) }</u>
                                %endif
                                %if (a.get('account_type') !='view' or a.get('level') == 1):
                                    ${ formatLang(a.get('balance'), currency_obj = company.currency_id) }
                                %endif
                            </td>
                            <td class="font${ min(6,a.get('level'))} right">
                                %if (a.get('account_type') =='view' and a.get('level') != 1):
                                    <u>${ formatLang(a.get('balance_cmp'), currency_obj = company.currency_id) }</u>
                                %endif
                                %if (a.get('account_type') !='view' or a.get('level') == 1):
                                    ${ formatLang(a.get('balance_cmp'), currency_obj = company.currency_id) }
                                %endif
                            </td>
                        </tr>
                        %if a.get('level')==1:
                            <tr></tr>
                        %endif
                    %endif
                %endfor
            </table>
        %endif
    </body>
</html>