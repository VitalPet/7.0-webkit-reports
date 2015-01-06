<html>
<head>
    <style type="text/css">
        ${css}
    </style>
    <title>Price List.pdf</title>
    
</head>
   <body>
        <table  width="100%">
            <tr>
                <td style="text-align:center;"><br/><br/><br/>
                    <h2><b> Price List</b></h2>
                </td>
            </tr>
        </table>
        <table width="100%" class="cell_extended">
            <tr>
                <td style="text-align:center;" class="cell_extended">
                <b>${ _('Price List Name') }</b>
                </td>
                <td style="text-align:center;" class="cell_extended">
                <b>${ _('Currency') }</b>
                </td>
                <td style="text-align:center;" class="cell_extended">
                <b>${ _('Printing Date') }</b>
                </td>
            </tr>
            <tr>
                <td style="text-align:center;" class="cell_extended">   

                ${get_pricelist(data['form']['price_list'])}
                </td>
                <td style="text-align:center;" class="cell_extended">
                ${get_currency ( data['form']['price_list'])}
                </td>
                <td style="text-align:center;" class="cell_extended">
                ${formatLang(time.strftime('%Y-%m-%d'), date=True)}
                </td><br/><br/>
            </tr>
        </table>

         %for k in get_titles(data['form']):
            <table width="100%" class="under_line1">
                <tr><br/>
                    <td width="45%"><b>
                    Description${ _('Description') }</b>
                    </td>
                    <td width="11%"><b>
                        ${(k.has_key('qty1') and k['qty1']) or ''}</b>
                    </td>
                    <td width="11%"><b>
                        ${(k.has_key('qty2') and k['qty2']) or ''}</b>
                    </td>
                    <td width="11%"><b>
                        ${(k.has_key('qty3') and k['qty3']) or ''}</b>
                    </td>
                    <td width="11%"><b>
                        ${(k.has_key('qty4') and k['qty4']) or ''}</b>
                    </td>
                    <td width="11%"><b>
                        ${(k.has_key('qty5') and k['qty5']) or ''}</b>
                    </td>
                </tr>
            </table>
       %endfor
       
       %for c in get_categories(objects,data['form']):
            <table width="100%">
                <tr>
                    <td class="under_line" width="45%" ><br/>
                     <b>   ${c['name']} </b>
                    </td> 
                     <td></td>                  
                </tr>
            </table>
           
                %for p in c['products']:
                    <table width="100%" class="list_table1">
                        <tr>
                            <td width="45%">
                                ${p['code'] and '[' + p['code'] + '] ' or '' } ${p['name']}
                            </td>
                            <td width="11%" >
                                ${(p.has_key('qty1') and p['qty1']) or ''}
                            </td>
                            <td width="11%" >
                                ${(p.has_key('qty2') and p['qty2']) or ''}
                            </td>
                            <td width="11%" >
                                ${(p.has_key('qty3') and p['qty3']) or ''}
                            </td>
                            <td width="11%" >
                                ${(p.has_key('qty4') and p['qty4']) or ''}
                            </td>
                            <td width="11%">
                                ${(p.has_key('qty5') and p['qty5']) or ''}
                            </td>
                        </tr>
                    </table>
                %endfor
            
                
            </table>
       %endfor
       <p style="page-break-after:always">
        </p>
       
</body>
</html>