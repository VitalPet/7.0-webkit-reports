<!DOCTYPE html SYSTEM "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <style type="text/css">
            ${css}
        </style>
        <title>Purchase for Requisitions.pdf</title>        
    </head>
    <body>
        %for requisition in objects:
            <table  width="100%" class="title">
                <tr>
                    <td><br/><br/>
                        <b> ${ _('Purchase for Requisitions') } ${requisition.name}</b><br/><br/>
                    </td>
                </tr>
            </table>
        
            <table class="basic_table" width="100%">
                <tr>
                    <td width="30%">
                        <b>${ _('Requisition Reference') }</b>
                    </td>
                    <td width="30%">
                        <b>${ _('Requisition Date') }</b>
                    </td>
                    <td width="20%">
                        <b>${ _('Type') }</b>
                    </td>
                    <td width="20%">
                        <b>${ _('Source') }</b>
                    </td>
                </tr>
            </table>
            
            <table class="basic_table" width="100%">
                <tr>
                    <td width="30%">
                        ${requisition.name}
                    </td>
                    <td width="30%">
                        ${formatLang(requisition.date_start,date_time='True')}
                    </td>
                    <td width="20%">
                        ${requisition.exclusive=='multiple' and 'Multiple Requisitions' or requisition.exclusive=='exclusive' and 'Purchase Requisitions (exclusive)'}
                    </td>
                    <td width="20%">
                        ${requisition.origin or ''}
                    </td>
                </tr>
            </table><br/>
            
            %if requisition.line_ids==[]:
            
            %else:
                <table  width="100%" class="title1">
                    <tr>
                        <td>
                            <b> ${ _('Product Detail') }</b><br/>
                        </td>
                    </tr>
                </table>
                </br>
                <table class="list_table1" width="100%">
                    <tr>
                        <td style="text-align:left ;padding-left:5px" width="60%">
                            <b>${ _('Description') }</b>
                        </td>
                        <td style="text-align:right;" width="20%">
                            <b>${ _('Qty') }</b>
                        </td>
                        <td style="text-align:center;"width="20%">
                            <b>${ _('Product UoM') }</b>
                        </td>
                    </tr>
                </table>
                
                %for line_ids in requisition.line_ids:
                    <table class="list_table" width="100%">
                        <tr>
                            <td style="text-align:left;padding-left:5px"width="60%">
                                [${line_ids.product_id and line_ids.product_id.code or ''}] ${line_ids.product_id and line_ids.product_id.name or ''}
                            </td>
                            <td style="text-align:right;"width="20%">
                                ${ formatLang(line_ids.product_qty) }
                            </td>
                            <td style="text-align:center;"width="20%">
                                ${line_ids.product_uom_id and line_ids.product_uom_id.category_id and line_ids.product_uom_id.category_id.name or ''}
                            </td>
                        </tr>
                </table><br/>
                %endfor
            %endif
            
            %if requisition.purchase_ids ==[]:
            
            %else:
                <table  width="100%" class="title1">
                    <tr>
                        <td>
                            <b> ${ _('Quotation Detail') }</b><br/>
                        </td>
                    </tr>
                </table>
                </br>
                <table class="list_table1" width="100%">
                    <tr>
                        <td style="text-align:left ;padding-left:5px"width="60%">
                            <b>${ _('Supplier') }<b/>
                        </td>
                        <td style="text-align:center;"width="20%">
                            <b>${ _('Date Ordered') }<b/>
                        </td>
                        <td style="text-align:center;"width="20%">
                            <b>${ _('Order Reference') }<b/>
                        </td>
                    </tr>
                </table>
                
                %for purchase_ids in requisition.purchase_ids:
                    <table class="list_table " width="100%">
                        <tr>
                            <td style="text-align:left; padding-left:5px" width="60%">
                                ${purchase_ids.partner_id and purchase_ids.partner_id.name or ''}
                            </td>
                            <td style="text-align:center;"width="20%">
                                ${formatLang(purchase_ids.date_order,date='True')}
                            </td>
                            <td style="text-align:center;"width="20%">
                                ${purchase_ids.name}
                            </td>
                        </tr>
                    </table>
                %endfor
            %endif
            
            <p style="page-break-after:always"></p>
        %endfor
    </body>
</html>