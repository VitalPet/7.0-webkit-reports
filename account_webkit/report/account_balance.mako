<html>
    <head>
        <style type="text/css">
		
			table.mystyle{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-style: solid;
				text-align: center;
				border: 1px solid grey;
				font-size: 100%;}

			.mystyle td, .mystyle th{
				margin: 0;
				padding: 4px;
				text-align: center;
				border-width: 1px 1px 1px 1px;
				border-style: solid;
				border: 1px solid grey;
				font-size: 60%;}
				
			table.mystyleone{border-width: 0 0 0 0;
				border-spacing: 0;
				border-collapse: collapse;
				border-style: solid;
				font-size: 100%;}

			.mystyleone tr{
				margin: 0;
				padding: 4px;
				border-width: 0 0 1px 0;
				border-style: solid;
				font-size: 60%;}
		</style>
    </head>
    <body direction rtl;>
        <br/>
        <center><h2>Trail Balance </h2></center>
        <table cellspacing="0" class="mystyle" width="100%">
            <tr>
                <td class="cell td_f12" width="24%"><b>
                    %if data['model']=='account.account':
                        ${ _('Company') }
                    %endif
                    %if data['model']=='ir.ui.menu':
                        ${ _('Chart of Accounts') }
                    %endif</b>
                </td>
                <td class="cell td_f12" width="15%"><b>${ _('Fiscal Year') }</b></td>
                <td class="cell td_f12" width="19%"><b>${ _('Display Account') }</b></td>
                <td class="cell td_f12" width="25%"><b>${ _('Filter By') }
                    %if data['form']['filter']!='filter_no':
                        ${ get_filter(data) }
                    %endif</b>
                </td>
                <td class="cell td_f12" width="17%"><b>${ _('Target Moves') }</b></td>
            </tr>
            <tr>
                <td class="cell">${ get_account(data) or '' }</td>
                <td class="cell">${ get_fiscalyear(data) or '' }</td>
                <td class="cell">
                    %if data['form']['display_account']=='all':
                        ${ _('All') }
                    %elif data['form']['display_account']=='movement':
                        ${ _('With movements') }
                    %else:
                        ${ _('With balance is not equal to 0') }
                    %endif
                </td>
                <td class="cell"><center>
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
                    %endif</center>
                </td>
                <td class="cell">${ get_target_move(data) }</td>
            </tr>
        </table>
        </br>
        <table cellspacing="0" class="mystyleone" width="100%">
            <tr border-color="black">
                <td class="td_f12" width="15%"><b>${ _('Code') }</b></td>
                <td class="td_f12" width="40%"><b>${ _('Account') }</b></td>
                <td class="td_f12_right" width="15%"><b>${ _('Debit') }</b></td>
                <td class="td_f12_right" width="15%"><b>${ _('Credit') }</b></td>
                <td class="td_f12_right" width="15%"><b>${ _('Balance') }</b></td>
            </tr>
            %for a in lines(data['form']):
                %if a['code']:
                    <tr border-color="grey">
                        %if a['type']!='view':
                            <td class="td_f10"><i>${ a['code'] }</i></td>
                            <td class="td_f10">${'&nbsp;&nbsp;'*(a['level']-1) }${ a['name'] }</td>
                            <td class="td_f10_right">${ formatLang(a['debit']) }</td>
                            <td class="td_f10_right">${ formatLang(a['credit']) }</td>
                            <td class="td_f10_right">${ formatLang(a['balance'], currency_obj=company.currency_id) }</td>
                        %else:
                            <td class="td_f10"><i><b>${ a['code'] }</b></i></td>
                            <td class="td_f10"><b>${'&nbsp;&nbsp;'*(a['level']-1) }${ a['name'] }</b></td>
                            <td class="td_f10"><b>${ formatLang(a['debit']) }</b></td>
                            <td class="td_f10"><b>${ formatLang(a['credit']) }</b></td>
                            <td class="td_f10"><b>${ formatLang(a['balance'], currency_obj=company.currency_id) }</b></td>
                        %endif
                    </tr>
                %endif
            %endfor
        </table>
    </body>
</html>