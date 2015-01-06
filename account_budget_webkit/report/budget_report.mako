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
 %for o in objects: 
    <br/>
    <table width="100%">
             <tr>
                 <td align="center">
                    <h4>
                     <b> Budget </b></h4>
                 </td>
             </tr>
    </table>
    <table width="100%" class="line">
        <tr>
            <td width="1%"></td>
            <td width="49%">
              <b>Currency:</b>${ company.currency_id.name }
            </td>
            <td width="49%" align="right">
            Printed at: ${ formatLang(time.strftime('%Y-%m-%d'),date=True) } at ${ time.strftime('%H:%M:%S') }
            </td>
            <td width="1%"></td>
      </tr>
      <tr>
            <td></td>
            <td>
            <b>Analysis from</b> ${ formatLang(data['form']['date_from'],date=True) } to ${ formatLang(data['form']['date_to'],date=True) }
            </td>
            <td align="right">
              <b>Budget :</b> <font color="Blue">${ o.name }</font>
              
            </td>
             <td></td>
      </tr>
    </table>
    <br/>
    <br/>
    <table width="100%" class="list_table">
        
        <tr >
            <td width="40%" >
                <b>
                    ${_('Description')}
                </b>
            </td>
            <td width="15%" align="right">
                <b>
                    ${_('Theoretical Amt')}
                </b>
            </td>
            <td width="12%" align="right">
                <b>
                    ${_('Planned Amt')}
                </b>
            </td>
            <td width="13%" align="right">
                <b>
                    ${_('Practical Amt')}
                 </b>
            </td>
            <td width="10%"  align="right">
               <b>
                    ${_('Perc(%)')}
               </b>
            </td>
        </tr>
       </table>
        
        %for a in funct(o,data['form']):
        <table width="100%" style="border-bottom: 1px solid #ccc !important;text-align:left;font-size:12;">
        <tr>           
            <td width="40%">
                 %if  a['status'] == 1 :                 
                    ${a['name']}                
                 %endif
                 %if a['status'] == 2:
                    <p style="padding-left:12px;">${a['name']} </p>
                 %endif
            </td>
            <td align="right" width="15%">
                ${formatLang(a['theo'], digits=get_digits(dp='Account'), currency_obj=company.currency_id)}
            </td>
            <td align="right" width="12%">
                ${formatLang(a['pln'], digits=get_digits(dp='Account'), currency_obj=company.currency_id)}
            </td>
            <td align="right" width="13%">
                ${formatLang(a['prac'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }
            </td>
            <td width="10%" align="right">
                ${formatLang(a['perc'], digits=2) }
            </td>  
           
        </tr>
       
    </table>
     %endfor
    %for b in funct_total(data['form']):
    <table width="100%" class="top">
        <tr>
          <td width="40%">
                Total:
        </td>
        <td width="15%" align="right">
                ${ formatLang(b['tot_theo'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }
        </td>
        <td width="12%" align="right">
                ${ formatLang(b['tot_pln'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }
        </td>
        <td width="13%" align="right">
                ${ formatLang(b['tot_prac'], digits=get_digits(dp='Account'), currency_obj=company.currency_id) }
        </td>
        <td width="10%" align="right">
                ${ formatLang(b['tot_perc'], digits=2) }%
        </td>
        </tr>
   </table>
    %endfor   
    <p style="page-break-after:always">
        </p> 
    
%endfor
</body>
</html>