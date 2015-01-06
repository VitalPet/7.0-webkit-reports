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
                        ${get_title(voucher.type)}
                    </td>
                </tr>
            </table>
            <table class="tbl_grey_line">
                <tr>
                    <td width="20%"><b>
                        ${_('Journal:')}</b>
                    </td>
                    <td colspan="3" width="30%">
                        ${ voucher.type} 
                    </td>
                    <td width="20%">
                        <b>${_('Number:')}</b>
                    </td>
                    <td width="30%">
                        ${ voucher.number }
                    </td>
                  </tr>
                  <tr>
                    <td>
                        <b> ${_('Status:')} </b>
                    </td>
                    <td width="10%">
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
                    <td width="10%">
                        <b>${_('Ref. :')}</b>
                    </td>
                    <td width="10%">
                       ${ voucher.reference or '' } 
                    </td>
                    <td>
                        <b>${_('Date:')}</b>
                    </td>
                    <td>
                        ${ formatLang(voucher.date , date=True) or '' }
                    </td>
                </tr>
            </table>
            </br>
            <table class="tbl_line">
                <tr>
                    <td  width="50%">
                        ${_('Particulars')}
                    </td>
                    <td width="25%" align="right">
                        ${_('Debit')}
                    </td>
                    <td width="25%" align="right">
                        ${_('Credit')}
                    </td>
                </tr>
            </table>
            <table class="font">
                %for move_ids in voucher.move_ids:
                    <tr>
                        <td style="padding-left:5px" width="50%">
                            <b> ${ (move_ids.partner_id and move_ids.partner_id.name) or 'Account' }</b>
                        </td>
                        <td style="padding-left:15px" width="25%" align="right">
                            ${ formatLang(move_ids.debit) }
                        </td>
                        <td style="padding-left:15px" width="25%" align="right">
                            ${ formatLang(move_ids.credit) }
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-left:15px">
                            ${ move_ids.account_id.name }
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-left:15px" width="25%">
                            <i>${ move_ids.name } - ${ get_ref(voucher.id,move_ids) }</i>
                        </td>
                    </tr>
                 %endfor
                    <tr>
                        <td colspan="3">
                            <b>${_('Through :')} 
                        </td>
                      </tr>
                      <tr>
                        <td colspan="3" style="padding-left:15px" >
                            ${ voucher.narration or ''}
                        </td>
                      </tr>
                      <tr>
                        <td colspan="3" >
                            <b>${_('On Account of : ')}</b>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="3" style="padding-left:15px >
                            ${  voucher.name or ''}
                        </td>
                      </tr>
                      <tr >
                        <td colspan="3">
                           <b> ${_('Amount (in words) :') }</b>
                        </td>
                      </tr>
                      <tr>
                        <td style="padding-left:15px">
                            ${  convert(voucher.amount,voucher.currency_id.name) or '' }
                        </td>
                        <td></td><td></td>
                    </tr>
            </table>
            <table class="tbl_line">
                <tr>
                    <td width="50%">
                     
                    </td>
                    <td width="25%" align="right" >
                       ${ debit(voucher.move_ids)}
                    </td>
                    <td width="25%" align="right">
                       ${ credit(voucher.move_ids)} 
                    </td>
                  </tr>
            <table>
            </br>
            <table class="tbl_header">
                <tr>
                    <td width="50%">
                        Receiver's Signature
                </td>
                <td align="right" width="50%">
                    Authorised Signatory
                </td>
              </tr>
            </table>
            <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>