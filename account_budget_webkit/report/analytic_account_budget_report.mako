<html>
    <head>
        <style type="text/css">
             ${css}
         .basic_table{
            text-align:center;
            border:1px solid lightGrey;
            border-collapse: collapse;
            }
         </style>       
    </head>
<body>
</br>
</br>
</br>
      %for o in objects: 
      </br>
    <table width="100%">
             <tr>
                 <td align="center">
                    <h4>
                     <b>Analytic Budget </b></h4>
                 </td>
             </tr>
    </table>
<br/>
    <table width="100%" class="basic_table">
        <tr >
            <td width="40%"><b>
                ${_('Analysis from')}   
            </td></b>
            <td width="40%"><b>
                ${_('Analytic Account')}</b>                
            </td>
            <td width="20%">
                <b>
                ${_('Currency')} </b>
            </td></b>
        </tr>
  
        <tr>
            <td>
                ${formatLang(data['form']['date_from'],date=True)} to ${formatLang(data['form']['date_to'],date=True)}
            </td>
            <td>
                ${o.name}
            </td>
            <td>
                ${company.currency_id.name}
            </td>
        </tr>

    </table>
    <br/>
    <table width="100%" class="list_table">
        <tr >
            <td width="40%"><b>
                ${_('Description')}</b>
            </td>
            <td width="15%"><b>
                ${_('Theoretical Amt')}</b>
            </td>
            <td width="12%"><b>
                ${_('Planned Amt')}</b>
            </td>
            <td width="13%"><b>
                ${_('Practical Amt')}</b>
            </td>
            <td width="10%" align="right"><b>
                ${_('Perc(%)')}</b>
            </td>
        </tr>
        %for a in funct(o,data['form']):
        <tr>
            <td>
                   ${a['name']}
            </td>
            <td>    
                   ${formatLang(a['theo'], currency_obj=company.currency_id) }
            </td>
            <td>
                ${ formatLang(a['pln'], currency_obj=company.currency_id) }
            </td>
            <td>
               ${ formatLang(a['prac'], currency_obj=company.currency_id) }
            </td>
            <td>
              ${ formatLang(a['perc']) }%
            </td>            
        </tr>
         %endfor
        </table> 
        %for b in funct_total(data['form']):
         <table width="100%">
         
         <tr>
            <td width="40%"><b><h5>
            ${ } Total:</h5></b>
        </td>
        <td width="15%" align="right"><h5>
            <b>${ formatLang(b['tot_theo'], currency_obj=company.currency_id) }</b></h5>
        </td>
        <td width="12%" align="right"><b><h5>
          ${ formatLang(b['tot_pln'], currency_obj=company.currency_id) }</b></h5>
        </td>
        <td width="13%" align="right"><b><h5>
          ${ formatLang(b['tot_prac'], currency_obj=company.currency_id) }</h5></b>
        <td width="10%" align="right"><b><h5>
          ${ formatLang(b['tot_perc']) }%</h5></b>
        </td>
         </tr></h5>
         %endfor
    </table>
    <p style="page-break-after:always">
        </p> 
    
%endfor
</body>
</html>