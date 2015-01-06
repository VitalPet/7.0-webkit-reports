<html>
    <head>
        <style>
            ${css}
        </style>
    </head>
    
    <body >
        
        <table width="100%">
            <tr class ="report_header">
                <td align="center">
                    Tax Statement
                </td>
            </tr>
        </table>
        <p>
         <table  width="100%" cellspacing="0" cellpadding="0">
            <tr class="table_header">
                <td width="20%" align="center" class="top left">
                    <small><b>Chart of Tax</b></small>
                </td>
                <td width="20%" align="center" class="left top">
                    <small><b> Fiscal Year</small>   
                </td>
                <td width="40%" align="center" class="left top">
                    <small><b> Periods</small>   
                </td>
                <td width="20%" align="center" class="left top right">
                    <small><b>Based On</b></small>    
                </td>
            </tr>
            
             <tr class="table_child_data">
                <td width="20%" align="center" class="left top bottom">
                    <small> ${ get_account(data) or removeParentNode('para') }</small>
                </td>
                <td width="20%" align="center" class="left top bottom">
                    <small> ${ get_fiscalyear(data)  or '' }</small>   
                </td>
                <td width="40%" align="center" class="left top bottom">
                    <table width="100%" >
                        <tr class="table_parent_data">
                            <td width="50%" align="center" class="right">
                                <small><b> Start Period</small>
                            </td>
                            <td width="50%" align="center" >
                                <small><b> End Period Period</small>
                            </td>
                        </tr>
                        <tr class="table_child_data">
                            <td width="50%" align="center" class="right">
                                <small> ${get_start_period(data) or ''}</small>
                            </td>
                            <td width="50%" align="center">
                                <small> ${get_end_period(data) or ''}</small>
                            </td>
                        </tr>
                    </table>
                       
                </td >
                <td width="20%" align="center" class="left top right bottom">
                    <small>${get_basedon(data)  or ''}</small>    
                </td>
            </tr>
            
        </table>  
       <p>
       <p> 
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr class ="table_header">
                <td width="40%" align="left" class="head_bottom_border">
                    <small><b>Tax Name</b></small>
                </td>
                <td width="20%" align="right" class="head_bottom_border">
                    <small><b> Debit</small>   
                </td>
                <td width="20%" align="right" class="head_bottom_border">
                    <small><b> Credit</small>   
                </td>
                <td width="20%" align="right" class="head_bottom_border">
                    <small><b>Tax Amount</b></small>    
                </td>
            </tr>
        </table>
        
        <p>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            %for line in get_lines(data['form']['based_on'], data['form']['company_id']):

                %if len(line['level']) <=4:
                <tr class="table_parent_data">      
                    <td width="40%" class="bottom" > <font color="white">${ line['level'] } </font> ${line['code'] or ''}  ${ line['name'] or ''}  </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['debit']) } </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['credit']) } </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['tax_amount'], currency_obj=company.currency_id) } </td>
                </tr>
                %endif
                %if len(line['level']) > 4:
                <tr class="table_child_data">
                    <td width="40%" class="bottom"> <font color="white">${ line['level'] } </font> ${line['code'] or ''}  ${ line['name'] or ''}  </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['debit']) } </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['credit']) } </td>
                    <td width="20%" class="bottom" align="right"> ${ formatLang(line['tax_amount'], currency_obj=company.currency_id) } </td>
                </tr>
                %endif
            %endfor
          </table>
        
    </body>
</html>