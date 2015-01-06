<html>
    <head>
        <style type="text/css">
             ${css}
         </style>       
    </head>
<body>
    </br>
    </br>
    </br>
    <table cellspacing="0" width="100%">
                <tr>
                    <td width="80%" >
                        <table class="td_f12 tr_bottom_line_dark" width="40%" >
                            <tr>
                                <td width="25%">Phone</td>
                                <td>:&nbsp;${ company.phone or ''}</td>
                            </tr>
                            <tr>
                                <td>Mail</td>
                                <td>:&nbsp;${ company.email or '' }</td>
                            </tr>
                        </table>
                     </td>
                     <td width="20%">
                     </td>
                   </tr>
                   <tr>
                    <td width="80%"></td>
                    <td width="20%" class="td_f12">                        
                        ${user.name} </br>
                        ${user.login}</br>  
                        ${user.email} </br>
                    </td>
                </tr>
            </table>
    </br>
    <h1><b>Lunch Order</b></h1>
    
    <table width="100%" class="list_table">
        <tr>
            <td width="30%">
                ${_('Name/Date')}
            </td>
            <td width="25%">
                ${_('Order')}
            </td>
            <td width="25%">
                ${_('Description')}
            </td>
            <td width="20%" align="right">
                ${_('Unit Price')}
            </td>
          </tr>
    </table>
    %for o in get_users(objects):
        <table width="100%" >
              <tr>
                  <td width="60%" style="border-bottom: 1px solid grey ; font-size:12px;font-weight: bold;">
                        ${ o.name }
                  </td>
                  <td width="20%">
                    
                  </td>
                  <td width="20%" align="right" style=" font-size:12px;font-weight: bold;">
                    
                        <u>${ formatLang(get_total(o,objects)) } ${ (o.company_id and o.company_id.currency_id and o.company_id.currency_id.symbol) or '' }</u>
                    
                  </td>
            </tr>
        </table> 
        %for lines in get_lines(o,objects):
        <table width="100%" class="td_line_grey">
            <tr>
                <td width="30%" style=" padding-left:10px;">
                    ${ formatLang(lines.date,date=True)}
                </td>
                <td width="25%">
                    ${ (lines.product_id and lines.product_id.name) or '' }
                </td>
                <td width="25%">
                    ${ lines.note}
                </td>
                <td width="20%" align="right" >
                    ${ lines.price } ${ (o.company_id and o.company_id.currency_id and o.company_id.currency_id.symbol) or '' }
                </td>
          </tr>
        </table>
        %endfor
       %endfor  
       
        <table width="100%">
            <tr>
                <td width="30%" >
                    
                </td>
                <td width="30%" >
                </td>
                <td width="20%" >
                   
                </td>
                <td width="20%" class="top" >
                    <table width="100%">
                        <tr>
                            <td width="50%">
                                Total:
                            </td>
                            <td width="50%" align="right">
                                ${ formatLang(get_nettotal()) } ${ (o.company_id and o.company_id.currency_id and o.company_id.currency_id.symbol) or '' }
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
     <p style="page-break-after:always">
        </p>

</body>
