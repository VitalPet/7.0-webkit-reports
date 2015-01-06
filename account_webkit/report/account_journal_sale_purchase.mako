<html>
    <head>
         <style type="text/css">
            ${css}
        </style>
    </head>
    <body>
    

        </br>
        </br>
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
         <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_parent_data" >
                <td  align="center" class="left top">
                    <small> ${ _(account_info) }</small>
                </td>
                <td  align="center" class="left top">
                    <small><b> ${_('Fiscal Year')}</small>   
                </td>
                <td  align="center" class="left top">
                    <small><b> ${_('Journal')}</small>   
                </td>
                <td  align="center" class="left top">
                    <small><b> ${_('Periods')}</small>   
                </td>
                <td  align="center" class="left top">
                    <small><b>${_('Entries Sorted By')}</b></small>    
                </td>
                <td  align="center" class="left top right">
                    <small><b>${_('Target Moves')}</b></small>    
                </td>
            </tr>
            <tr class="table_child_data" >
                <td  align="center" class="left top bottom">
                    <small> ${ get_account(data) or '' }</small>
                </td>
                <td  align="center" class="left top bottom">
                    <small> ${ get_fiscalyear(data) or '' }</small>   
                </td>
                <td  align="center" class="left top bottom">
                    <small> ${ o.journal_id.name or ''}</small>   
                </td>
                <td  align="center" class="left top bottom">
                    <small> ${ o.period_id.name or '' }</small>   
                </td>
                <td  align="center" class="left top bottom">
                    <small>${ get_sortby(data) }</small>    
                </td>
                <td  align="center" class="left top bottom right">
                    <small>${ get_target_move(data) }</b></small>    
                </td>
           </tr>
            
        </table>
        <p>
        
        %if display_currency(data) == False: 
        
            <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_child_data" >
                <td  class="head_bottom_border" width="11%">
                    <small> ${ _('Move') }</small>
                </td>
                <td  " class="head_bottom_border" width="11%">
                    <small><b> ${_('Date')}</small>   
                </td>
                <td  class="head_bottom_border" width="11%">
                    <small><b> ${_('Account')}</small>   
                </td>
                <td   class="head_bottom_border" width="11%">
                    <small><b> ${_('Partner')}</small>   
                </td>
                <td   class="head_bottom_border" width="11%">
                    <small><b>${_('Label')}</b></small>    
                </td>
                <td   class="head_bottom_border" width="11%">
                </td>
                <td   class="head_bottom_border" width="11%">
                    <small><b>${_('Tax')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="11%" align="right">
                    <small><b>${_('Debit')}</b></small>    
                </td>
                 <td  class="head_bottom_border" width="12%" align="right">
                    <small><b>${_('Credit')}</b></small>    
                </td>
            </tr>
          
            %for line in lines(o.period_id.id, o.journal_id.id):
            
                <table  width="100%" cellspacing="0" cellpadding="0">
                    <tr class="table_child_data">
                        <td width="11%" ><div class="nobrk">
                        <%
                            if line.move_id.name <> '/': 
                                name = line.move_id.name
                            else:
                                name = ('*'+str(line.move_id.id))
                        %>
                            ${_(name)}
                        </div></td>
                        <td width="11%" ><div class="nobrk">
                            ${formatLang(line.date,date=True)}
                        </div></td >
                        <td width="11%" ><div class="nobrk">
                            ${line.account_id.code}
                        </div></td>
                        <td width="11%" ><div class="nobrk">
                            ${line.partner_id and strip_name(line.partner_id.name,15)}
                        </div></td>
                        <td width="11%" ><div class="nobrk">
                            ${strip_name(line.name,25)}
                        </div></td>
                        <td width="11%" ><div class="nobrk">
                            %if line.tax_code_id:
                                 %if line.tax_code_id.code:
                                     ${ line.tax_code_id.code + ':' }
                                 %endif
                            %endif
                        </div></td>
                        <td width="11%" ><div class="nobrk">
                            ${line.tax_amount and formatLang(line.tax_amount, currency_obj=company.currency_id)}
                        </div></td>
                        <td width="11%" align="right" ><div class="nobrk">
                            ${formatLang(line.debit, currency_obj=company.currency_id)}
                        </div></td>
                        <td width="12%" align="right" ><div class="nobrk">
                            ${formatLang(line.credit, currency_obj=company.currency_id)}
                        </div></td>
                    </tr>
                    
                </table>
            %endfor
            <table  width="100%" cellspacing="0" cellpadding="0">
                <tr class="table_parent_data" >
                    <td width="11%"><div class="nobrk"></div></td>
                    <td width="11%"><div class="nobrk"></div></td>
                    <td width="11%"><div class="nobrk"></div></td>
                    <td width="11%"><div class="nobrk"></div> </td>
                    <td width="11%"><div class="nobrk"></div></td>
                    <td width="11%"><div class="nobrk"></div></td>
                    <td width="11%" class="head_bottom_border"><div class="nobrk">
                        ${_('Total')}:
                    </div></td>
                    <td width="11%" align="right" class="head_bottom_border"><div class="nobrk">
                        ${formatLang(sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </div></td>
                    <td width="12%" align="right" class="head_bottom_border"><div class="nobrk">
                        ${formatLang(sum_credit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </div></td>
                </tr>
            </table>
        %endif
        
        %if display_currency(data): 
        
            <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_child_data" >
                <td  class="head_bottom_border" width="10%">
                    <small> ${ _('Move') }</small>
                </td>
                <td  " class="head_bottom_border" width="10%">
                    <small><b> ${_('Date')}</small>   
                </td>
                <td  class="head_bottom_border" width="10%">
                    <small><b> ${_('Account')}</small>   
                </td>
                <td   class="head_bottom_border" width="10%">
                    <small><b> ${_('Partner')}</small>   
                </td>
                <td   class="head_bottom_border" width="10%">
                    <small><b>${_('Label')}</b></small>    
                </td>
                <td   class="head_bottom_border" width="10%">
                </td>
                <td   class="head_bottom_border" width="10%">
                    <small><b>${_('Tax')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Debit')}</b></small>    
                </td>
                 <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Credit')}</b></small>    
                </td>
                <td  class="head_bottom_border" width="10%" align="right">
                    <small><b>${_('Currency')}</b></small>    
                </td>
            </tr>
          
            %for line in lines(o.period_id.id, o.journal_id.id):
            
                <table  width="100%" cellspacing="0" cellpadding="0">
                    <tr class="table_child_data">
                        <td width="10%" ><div class="nobrk">
                        <%
                            if line.move_id.name <> '/': 
                                name = line.move_id.name
                            else:
                                name = ('*'+str(line.move_id.id))
                        %>
                            ${_(name)}
                        </div></td>
                        <td width="10%" ><div class="nobrk">
                            ${formatLang(line.date,date=True)}
                        </div></td >
                        <td width="10%" ><div class="nobrk">
                            ${line.account_id.code}
                        </div></td>
                        <td width="10%" ><div class="nobrk">
                            ${line.partner_id and strip_name(line.partner_id.name,12)}
                        </div></td>
                        <td width="10%" ><div class="nobrk">
                            ${strip_name(line.name,16)}
                        </div></td>
                        <td width="10%" ><div class="nobrk">
                            %if line.tax_code_id:
                                 %if line.tax_code_id.code:
                                     ${ line.tax_code_id.code + ':' }
                                 %endif
                            %endif
                        </div></td>
                        
                        <td width="10%" ><div class="nobrk">
                            ${line.tax_amount and formatLang(line.tax_amount, currency_obj=company.currency_id)}
                        </div></td>
                        <td width="10%" align="right" ><div class="nobrk">
                            ${formatLang(line.debit, currency_obj=company.currency_id)}
                        </div></td>
                        <td width="10%" align="right" ><div class="nobrk">
                            ${formatLang(line.credit, currency_obj=company.currency_id)}
                        </div></td>
                        <td width="10%" align="center" ><div class="nobrk">
                            ${line.currency_id and formatLang(line.amount_currency, currency_obj=line.currency_id) or ''}
                        </div></td>
                    </tr>
                    
                </table>
            %endfor
            
            <table  width="100%" cellspacing="0" cellpadding="0">
                <tr class="table_parent_data" >
                    <td width="20%"><div class="nobrk"></div></td>
                    <td width="20%"><div class="nobrk"></div></td>
                    <td width="10%"><div class="nobrk"></div></td>
                    <td width="20%" align="center"><div class="nobrk">
                        ${_('Total')}:
                    </div></td>
                    <td width="10%" align="right"><div class="nobrk">
                        ${formatLang(sum_debit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </div></td>
                    <td width="10%" align="right"><div class="nobrk">
                        ${formatLang(sum_credit(o.period_id.id, o.journal_id.id), currency_obj=company.currency_id)}
                    </div></td>
                    <td width="10%"><div class="nobrk"></div></td>
                </tr>
            </table>
        %endif
        <p>
        <table width="100%" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td width="25%" class="head_bottom_border"> Tax Declaration</td>
                <td width="25%" class="head_bottom_border"></td>
                <td width="25%" class="head_bottom_border"></td>
                <td width="25%" class="head_bottom_border"></td>
            </tr>
        </table>
        <table width="100%" cellspacing="0" cellpadding="0" align="center">
            
            <tr>
                %for t in (tax_codes(o.period_id.id,o.journal_id.id)):  
                    <td width="40%>
                       %if t.code:
                            ${ t.code + ': ' }
                       %endif
                    </td>
                    <td width="10%>${ formatLang(sum_vat( o.period_id.id, o.journal_id.id, t.id)) }</td>
                    <td width="20%></td>
                    <td width="30%> ${ t.name }</td>
                %endfor
          </tr>
        </table>
        </p>
        <p style="page-break-after:always">
        </p>        

    %endfor
   
    </body>
</html>