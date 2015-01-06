<html>
<head>
    <style type="text/css">
        ${css}
    </style>
    <title>Crossoverred Analytic.pdf</title>
    
</head>
<body>
    <table  width="100%">
            <tr>
                <td style="text-align:center;">
                    <h3><b> Crossovered Analytic</b></h3>
                </td>
            </tr>
        </table>
    <table  width="100%" class="cell_extended">
        <tr>
            <td style="text-align:center;" class="cell_extended"><b>${ _('From Date') }</b></td>
            <td style="text-align:center;" class="cell_extended"><b>${ _('To Date') }</b></td>
            <td style="text-align:center;" class="cell_extended"><b>${ _('Company') }</b></td>
            <td style="text-align:center;" class="cell_extended"><b>${ _('Currency') }</b></td>
            <td style="text-align:center;" class="cell_extended"><b>${ _('Printing date') }</b></td>
        </tr>
        <tr>
            <td style="text-align:center;" class="cell_extended">${ data['form']['date1'] }</td>
            <td style="text-align:center;" class="cell_extended">${ data['form']['date2'] } </td>
            <td style="text-align:center;" class="cell_extended">${ company.name }</td>
            <td style="text-align:center;" class="cell_extended">${ company.currency_id.name }</td>
            <td style="text-align:center;" class="cell_extended">${ time.strftime('%Y-%m-%d')} at ${ time.strftime('%H:%M:%S') }</td>
        </tr>        
        </table>
        <br/>
   
     <table width="100%" >
        <tr>
            <td>
                <h4><b>Analytic Account Reference:</b></h4>
            </td>
        </tr>
      </table>
      <table width="100%" style="font-weight: bold ;font-size: 12px ;border-bottom:1px solid black;">  
        <tr>
            <td width="60%">
                ${_('Account Name') }
            </td>
            <td width="10%">
                ${_('Code') }
            </td>
            <td width="10%">
                ${_('Quantity') }
            </td>
            <td width="10%">
                ${_('Amount') }
            </td>
            <td width="10%">
                ${_('Perc(%)') }
            </td>            
        </tr>
        </table>
        %for k in ref_lines(data['form']):     
        <table width="100%" class="list_table1">
            <tr>
                <td width="60%">${k['ref_name']}</td>
                <td width="10%" >${k['ref_code']}</td>
                <td width="10%" style="text-align:right;">${k['ref_qty']}</td>
                <td width="10%" style="text-align:right;">${k['ref_amt']}</td>
                <td width="10%" style="text-align:right;">100.00%</td>
            </tr>
        </table>
    %endfor
    
   <br/>
     <table width="100%" >
        <tr>
            <td>
                <h4><b>Analytic Account :</b></h4>
            </td>
        </tr>
      </table>
      <table width="100%" style="font-weight: bold ;font-size: 12px ;border-bottom:1px solid black;">  
        <tr>
            <td width="60%">
                ${_('Account Name') }
            </td>
            <td width="10%">
                ${_('Code') }
            </td>
            <td width="10%">
                ${_('Quantity') }
            </td>
            <td width="10%" >
                ${_('Amount') }
            </td>
            <td width="10%">
                ${_('Percentage') }
            </td>            
        </tr>
        </table>
        %for account in lines(data['form']):
        <table width="100%" class="list_table1">
            <tr>
                <td width="60%" >${account['acc_name']}</td>
                <td width="10%" >${account['code']}</td>
                <td width="10%" style="text-align:right;">${account['qty']}</td>
                <td width="10%" style="text-align:right;">${account['amt']}</td>
                <td width="10%" style="text-align:right;">${account['perc']}%</td>
            </tr>
        </table>
        <p style="page-break-after:always">
        </p>
    %endfor    
</body>
</html>   