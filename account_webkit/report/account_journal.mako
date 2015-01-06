<html>
    <head>
         <style type="text/css">
            ${css}
        </style>
    </head>
    
    <body>
    
    
        <br/>
        <br/>
        <table width="100%">
            <tr class ="report_header">
                <td align="center">
                    Journal 
                </td>
            </tr>
        </table>
        <%
            if data['model']=='account.journal.period':
                account_info = 'Company'
            endif
        
            if data['model']=='ir.ui.menu':
                account_info = 'Chart of Accounts'
            endif  
        %>
        %for o in objects:
         <table  width="100%" cellspacing="0" cellpadding="0" class="cell">
            <tr class="table_parent_data" >
                <td  align="center" class="cell">
                    <small> ${ _(account_info) }</small>
                </td>
                <td  align="center" class="cell">
                    <small><b> ${_('Fiscal Year')}</small>   
                </td>
                <td  align="center" class="cell">
                    <small><b> ${_('Journal')}</small>   
                </td>
                <td  align="center" class="cell">
                    <small><b> ${_('Periods')}</small>   
                </td>
                <td  align="center" class="cell">
                    <small><b>${_('Entries Sorted By')}</b></small>    
                </td>
                <td  align="center" class="cell">
                    <small><b>${_('Target Moves')}</b></small>    
                </td>
            </tr>
            <tr class="table_child_data" >
                <td  align="center" class="cell">
                    <small> ${ get_account(data) or '' }</small>
                </td>
                <td  align="center" class="cell">
                    <small> ${ get_fiscalyear(data) or '' }</small>   
                </td>
                <td  align="center" class="cell">
                    <small> ${ o.journal_id.name or ''}</small>   
                </td>
                <td  align="center" class="cell">
                    <small> ${ o.period_id.name or '' }</small>   
                </td>
                <td  align="center" class="cell">
                    <small>${ get_sortby(data) }</small>    
                </td>
                <td  align="center" class="cell">
                    <small>${ get_target_move(data) }</b></small>    
                </td>
           </tr>
            
        </table>
        <p>
        
        %if display_currency(data) == False: 
        
            <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_child_data" >
                <td  class="head_bottom_border" width="16%">
                    <small> ${ _('Move') }</small>
                </td>
                <td  class="head_bottom_border" width="16%">
                    <small><b> ${_('Date')}</small>   
                </td>
                <td  class="head_bottom_border" width="16%">
                    <small><b> ${_('Account')}</small>   
                </td>
                <td   class="head_bottom_border" width="16%">
                    <small><b> ${_('Partner')}</small>   
                </td>
                <td   class="head_bottom_border" width="16%">
                    <small><b>${_('Label')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Debit')}</b></small>    
                </td>
                 <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Credit')}</b></small>    
                </td>
            </tr>
            <%
                counter = 0 
            %>          

            %for line in lines(o.period_id.id, o.journal_id.id):
                
                <% counter  += 1 %>
            
                <table  width="100%" cellspacing="0" cellpadding="0">
                    <tr class="table_child_data">
                        <td width="16%" >
                        <%
                            if line.move_id.name <> '/': 
                                name = line.move_id.name
                            else:
                                name = ('*'+str(line.move_id.id))
                        %>
                            ${_(name)}
                        </td>
                        <td width="16%" >
                            ${formatLang(line.date,date=True)}
                        </td >
                        <td width="16%" >
                            ${line.account_id.code}
                        </td>
                        <td width="16%" >
                            ${line.partner_id and strip_name(line.partner_id.name,15)}
                        </td>
                        <td width="16%" >
                            ${strip_name(line.name,25)}
                        </td>
                        <td width="10%" align="right" >
                            ${formatLang(line.debit, currency_obj=company.currency_id)}
                        </td>
                        <td width="10%" align="right" >
                            ${formatLang(line.credit, currency_obj=company.currency_id)}
                        </td>
                    </tr>
                    
                </table>
                %if counter % 2==0:

                    <table width="100%">
                        <tr>
                            <td class="tr_bottom_line_light_grey">
                            </td>
                        </tr>
                    </table>
                %endif
            %endfor
            <table width="100%">
                <tr>
                    <td width="100%" colspan="2"></td>
                </tr>
                <tr>
                    <td width="70%"></td>
                    <td width="30%" class="tr_bottom_line_black" align="right"></td>
                </tr>
            </table>

            <table  width="100%" cellspacing="0" cellpadding="0">
                <tr class="table_parent_data" >
                    <td width="57%"></td>
                    <td width="11%">
                        ${_('Total')}:
                    </td>
                    <td width="11%" align="right">
                        ${formatLang(sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </td>
                    <td width="11%" align="right">
                        ${formatLang(sum_credit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </td>
                </tr>
            </table>
        %endif
        
        %if display_currency(data): 
        
            <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_child_data" >
                <td  class="head_bottom_border" width="12%">
                    <small> ${ _('Move') }</small>
                </td>
                <td  class="head_bottom_border" width="12%">
                    <small><b> ${_('Date')}</small>   
                </td>
                <td  class="head_bottom_border" width="12%">
                    <small><b> ${_('Account')}</small>   
                </td>
                <td   class="head_bottom_border" width="12%">
                    <small><b> ${_('Partner')}</small>   
                </td>
                <td   class="head_bottom_border" width="20%">
                    <small><b>${_('Label')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="11%" align="right">
                    <small><b>${_('Debit')}</b></small>    
                </td>
                 <td  class="head_bottom_border" width="11%" align="right">
                    <small><b>${_('Credit')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Currency')}</b></small>    
                </td>
            </tr>

            <%
                counter1 = 0 
            %>          

            %for line in lines(o.period_id.id, o.journal_id.id):

                <% counter1 += 1 %>

                <table  width="100%" cellspacing="0" cellpadding="0">
                    <tr class="table_child_data">
                        <td width="12%" >
                        <%
                            if line.move_id.name <> '/': 
                                name = line.move_id.name
                            else:
                                name = ('*'+str(line.move_id.id))
                        %>
                            ${_(name)}
                        </td>
                        <td width="12%" >
                            ${formatLang(line.date,date=True)}
                        </td >
                        <td width="12%" >
                            ${line.account_id.code}
                        </td>
                        <td width="12%" >
                            ${line.partner_id and strip_name(line.partner_id.name,12)}
                        </td>
                        <td width="20%" >
                            ${strip_name(line.name,16)}
                        </td>
                        <td width="11%" align="right" >
                            ${formatLang(line.debit, currency_obj=company.currency_id)}
                        </td>
                        <td width="11%" align="right" >
                            ${formatLang(line.credit, currency_obj=company.currency_id)}
                        </td>
                        <td width="10%" align="center" >
                            ${line.currency_id and formatLang(line.amount_currency, currency_obj=line.currency_id) or ''}
                        </td>
                    </tr>
                    
                </table>
                %if counter1 % 2 ==0:
                    <table width="100%">
                        <tr>
                            <td class="tr_bottom_line_light_grey">
                            </td>
                        </tr>
                    </table>
                %endif
            %endfor
            
            <table width="100%">
                <tr>
                    <td width="100%" colspan="2"></td>
                </tr>
                <tr>
                    <td width="60%"></td>
                    <td width="40%" class="tr_bottom_line_black" align="right"></td>
                </tr>
            </table>

            <table  width="100%" cellspacing="0" cellpadding="0">
                <tr class="table_parent_data" >
                    <td width="57%"></td>
                    <td width="11%" align="center">
                        ${_('Total')}:
                    </td>
                    <td width="11%" align="right">
                        ${formatLang(sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </td>
                    <td width="11%" align="right">
                        ${formatLang(sum_credit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </td>
                    <td width="10%"></td>
                </tr>
            </table>
        %endif
        
        <p style="page-break-after:always">
        </p>
        
    %endfor  
    </body>
</html>