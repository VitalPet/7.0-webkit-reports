<html>
    <head>
        <style type="text/css">
             ${css}
         </style>       
    </head>
<body>
   %for o in objects:
      <br/>
      <br/>
          <table width="100%">
             <tr class ="report_header">
                 <td align="center">
                     <b>Centralized Journal</b>
                 </td>
             </tr>
          </table>
      <br/>
      <%
        if data['model']=='account.journal.period':
            account_info = 'Company'
        endif
                             
        if data['model']=='ir.ui.menu':
                        account_info = 'Chart of Accounts'
        endif  
      %>
            
            <table  width="100%" cellspacing="0" cellpadding="0">
                <tr class="table_parent_data" >
                    <td  align="center" class="left top" width="16%">
                        <small> ${_(account_info) }</small>
                    </td>
                    <td  align="center" class="left top" width="16%">
                        <small><b> ${_('Fiscal Year')}</small>   
                    </td>
                    <td  align="center" class="left top" width="16%">
                        <small><b> ${_('Journal')}</small>   
                    </td>
                    <td  align="center" class="left top" width="20%">
                        <small><b>${_('Filter By')}</b></small>    
                    </td>
                    <td  align="center" class="left top right" width="16%">
                        <small><b>${_('Target Moves')}</b></small>    
                    </td>
                </tr>
                <tr class="table_child_data" >
                        <td  align="center" class="left top bottom" width="16%">
                            <small> ${ get_account(data) or '' }</small>
                        </td>
                        <td  align="center" class="left top bottom" width="16%">
                            <small> ${ get_fiscalyear(data) or '' }</small>   
                        </td>
                        <td  align="center" class="left top bottom" width="16%">
                            <small> ${ o.journal_id.name }</small>   
                        </td>
                        <td  align="center" class="left top bottom" width="16%">
                        
                        %if data['form']['filter']=='filter_no':
                            ${ get_filter(data) }
                        %endif
                        %if data['form']['filter']=='filter_date':
                            <table>
                                <tr class="table_parent_data">
                                    <td ><center><b>${_('Start Date')}</b></center></td>
                                    <td class="left"><center><b>${_('End Date')}</b></center></td>
                                </tr>
                                <tr class="table_child_data">
                                    <td ><center>${ formatLang(get_start_date(data),date=True) }</center></td>
                                    <td class="left"><center>${ formatLang(get_end_date(data),date=True) }</center></td>
                                </tr>
                            </table>
                        %endif
                        %if data['form']['filter']=='filter_period':
                            <table >
                                <tr class="table_parent_data">
                                    <td ><center><b>${_('Start Period')}</b></center></td>
                                    <td class="left"><center><b>${_('End Period')}</b></center></td>
                                </tr>
                                <tr class="table_child_data">
                                    <td ><center>
                                        %if get_start_period(data):
                                            ${ get_start_period(data) }
                                        %endif
                                    </center></td>
                                    <td class="left"><center>
                                        %if get_end_period(data):
                                            ${ get_end_period(data) }
                                        %endif
                                     </center></td>
                                </tr>
                            </table>
                        %endif  
                        </td>
                        <td  align="center" class="left top bottom right" width="20%">
                            ${get_target_move(data)}    
                        </td>
                   </tr>
            </table>
            <p>
            
            %if display_currency(data)==False:
                    
                    <table  width="100%" cellspacing="0" cellpadding="0">
                        <tr class="table_header" >
                            <td  align="center" class="head_bottom_border" width="20%">
                                <small> ${_('A/C No.') }</small>
                            </td>
                            <td  align="center" class="head_bottom_border" width="35%">
                                <small><b> ${_('Account Name')}</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small><b> ${_('Debit')}</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small><b>${_('Credit')}</b></small>    
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small><b>${_('Balance')}</b></small>    
                            </td>
                        </tr>
                         <tr class="table_header" >
                            <td  align="center" class="head_bottom_border" width="20%">
                                <small> ${ _('Total:') }</small>
                            </td>
                            <td  align="center" class="head_bottom_border" width="35%">
                                <small> </small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small> ${ formatLang( sum_debit(o.period_id.id, o.journal_id.id)) }</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small> ${ formatLang( sum_credit(o.period_id.id, o.journal_id.id)) }</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="15%">
                                <small> ${ formatLang( sum_credit(o.period_id.id, o.journal_id.id)-sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id ) }</small>   
                            </td>
                         </tr>
                   </table>
                      
                   <table  width="100%" cellspacing="0" cellpadding="0">   
                   %for line in lines(o.period_id.id,o.journal_id.id):
                        <tr class="table_child_data" >
                            <td  align="center" class="bottom" width="20%">
                                <small> ${ line['code'] }</small>
                            </td>
                            <td  align="center" class="bottom" width="35%">
                                <small> ${ line['name'] }</small>
                            </td>
                            <td  align="center" class="bottom" width="15%">
                                <small> ${ formatLang(line['debit']) }</small>
                            </td>
                            <td  align="center" class="bottom" width="15%">
                                <small> ${ formatLang(line['credit']) }</small>
                            </td>
                            <td  align="center" class="bottom" width="15%">
                                <small> ${ formatLang(line['credit']-line['debit'], currency_obj=company.currency_id ) }</small>
                            </td>
                          </tr>
                   %endfor
                   </table>
            %endif    
            
            %if display_currency(data):
            
                <table  width="100%" cellspacing="0" cellpadding="0">
                        <tr class="table_header" >
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> ${_('A/C No.') }</small>
                            </td>
                            <td  align="center" class="head_bottom_border" width="20%">
                                <small><b> ${_('Account Name')}</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small><b> ${_('Debit')}</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small><b>${_('Credit')}</b></small>    
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small><b>${_('Balance')}</b></small>    
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small><b>${_('Currency')}</b></small>    
                            </td>
                        </tr>
                        
                         <tr class="table_header" >
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> ${ _('Total:') }</small>
                            </td>
                            <td  align="center" class="head_bottom_border" width="20%">
                                <small> </small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> ${ formatLang( sum_debit(o.period_id.id, o.journal_id.id)) }</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> ${ formatLang( sum_credit(o.period_id.id, o.journal_id.id)) }</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> ${ formatLang( sum_credit(o.period_id.id, o.journal_id.id)-sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id ) }</small>   
                            </td>
                            <td  align="center" class="head_bottom_border" width="16%">
                                <small> </small>   
                            </td>
                         </tr>
                
                    <table  width="100%" cellspacing="0" cellpadding="0">   
                        %for line in lines(o.period_id.id,o.journal_id.id):
                            <tr class="table_child_data" >
                                <td  align="center" class="bottom" width="16%">
                                    <small> ${ line['code'] }</small>
                                </td>
                                <td  align="center" class="bottom" width="20%">
                                    <small> ${ line['name'] }</small>
                                </td>
                                <td  align="center" class="bottom" width="16%">
                                    <small> ${ formatLang(line['debit']) }</small>
                                </td>
                                <td  align="center" class="bottom" width="16%">
                                    <small> ${ formatLang(line['credit']) }</small>
                                </td>
                                <td  align="center" class="bottom" width="16%">
                                    <small> ${ formatLang(line['credit']-line['debit'], currency_obj=company.currency_id ) }</small>
                                </td>
                                %if line['currency_id']!=None or line['amount_currency']!=None :
                                    <td  align="center" class="bottom" width="16%">
                                        <small> ${ formatLang(line['amount_currency'] )} ${line['currency_code'] or '' }</small>
                                    </td>
                                %endif
                          </tr>
                        %endfor
                    </table>
            %endif
           <p style="page-break-after:always;">
           </p>
        %endfor
    </body>
</html>