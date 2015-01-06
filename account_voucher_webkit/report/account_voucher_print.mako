<html>
    <head>
        <style type="text/css">
             ${css}
         </style>
    </head>
    <body>
        %for voucher in objects:
            <table class="title">
                <tr>
                    <td>
                        ${ get_title(voucher.type) }
                    </td>
                </tr>
            </table>
            <table class="tbl_header">
                <tr>
                    <td width="10%">
                        <b>${_('Number:')}</b>
                    </td>
                    <td width="40%">
                        ${_('voucher.number')} 
                    <td align="right" width="40%">
                        <b>${_('Date:')}</b>
                    </td>
                    <td align="right" width="10%">
                        ${ formatLang(voucher.date , date=True) or '' }
                    </td>
               </tr>
               <tr>
                    <td  width="10%">
                       <b> ${_('Status:')}</b>
                    </td>
                    <td width="40%">
                      %if voucher.state == 'proforma':
                                PRO-FORMA 
                      %endif
                      %if voucher.state == 'draft':
                                Draft      
                      %endif
                      %if voucher.state == 'cancel':
                                Canceled
                      %endif
                      %if voucher.state == 'posted':
                            Posted      
                      %endif
                    </td>
                    <td align="right" width="40%">
                        <b>${_('Currency:')}</b> 
                    </td>
                    <td align="right"  width="10%">
                        ${ voucher.currency_id.symbol }
                    </td>
              </tr>
            </table>
            </br>
            <table class="tbl_line">
                <tr width="70%">
                    <td>
                      ${_('Particulars')}
                    </td>
                    <td width="30%" align="right">
                        ${_('Amount')}
                    </td>
                </tr>
            </table>
            
            <table class="font">
                %for p in get_lines(voucher):
                <tr>
                    <td width="70%" style="padding-left:5px"><b>
                        ${_('Account :')}</b>
                    </td>
                </tr>
                
                <tr>
                    <td style="padding-left:10px">
                        ${ p['pname'] }
                    </td>
                    <td align="right">
                        ${ formatLang(p['amount'], currency_obj=voucher.currency_id) }
                    </td>
                </tr>
               
                <tr>
                    <td style="padding-left:10px">
                            ${ p['ref'] }
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px">
                            ${_('Account :')} ${ p['aname']}     
                    </td>
                </tr>
                %endfor
                <tr>
                    <td style="padding-left:5px">
                            <b>${_('Through :')}</b>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px">
                        ${ voucher.journal_id.name or '' }
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:5px">
                        <b>${_('On Account of :')}</b>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px">
                        ${ get_on_account(voucher) }
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:5px">
                        <b>Amount (in words) :</b>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:10px">
                        ${ convert(voucher.amount,voucher.currency_id.name) }
                    </td>
                 </tr>
            </table>
            
            <table class="tbl_line">
                <tr>
                    <td width="70%">
                    </td>
                    <td align="right" width="30%">
                        ${ formatLang(voucher.amount, currency_obj=voucher.currency_id) }
                    </td>
                </tr>
            </table>
             <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>