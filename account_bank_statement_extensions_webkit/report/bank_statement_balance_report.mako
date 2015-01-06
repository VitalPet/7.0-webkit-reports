<html>
    <head>
         <style type="text/css">
            ${css}
        </style>
    </head>
<body>
    <br/>
    <table width="100%">
        <tr class ="report_header">
            <td align="center">
                <h4><b>
                  Bank Statement Balances Report
                  </b></h4>
             </td>
        </tr>
    </table>
     <br/>        <br/>   
     
    <table  border="0" class="tr_bottom_line_dark_black" >
        <tr>
            <td width="30%"> 
                ${_('Name')}
            </td>
            <td width="30%">
                ${_('Date')}
            </td>
            <td width="20%">
                ${_('Journal')}
            </td>
            <td width="20%" align="right">
                ${_('Closing Balance')}
            </td>
        </tr>
     </table>
     %for l in lines:
     <table border="0" class="tr_bottom_line_dark_grey">
        <tr >
            <td width="30%">
                ${ l['s_name'] }
            </td>
            <td width="30%">
                ${ l['s_date'] }
            </td>
            <td width="20%">
                ${ l['j_code'] }
            </td>
            <td width="20%" align="right">
                ${ (l['s_balance']) }
            </td>
        </tr>
   %endfor
   </table>
   <p style="page-break-after:always"></p>
</body>
</html>