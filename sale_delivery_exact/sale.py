# -*- coding: utf-8 -*-
##############################################################################
#
#	This module uses OpenERP, Open Source Management Solution Framework.
#	Copyright (C) 2012-Today Serpent Consulting Services Pvt. Ltd.(<http://www.serpentcs.com>)
#
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>
#
##############################################################################


from openerp.osv import fields, osv
from openerp import netsvc

import openerp.addons.decimal_precision as dp

class SaleOrderLine(osv.osv):
    
    _inherit = 'sale.order.line'
    
    _columns = {
        'shipped_qty': fields.float('Shipped Quantity', digits_compute= dp.get_precision('Product UoS'))
    }

SaleOrderLine()

class SaleOrder(osv.osv):

    _inherit = 'sale.order'
	
    def _prepare_order_line_move(self, cr, uid, order, line, picking_id, date_planned, context=None):
        res = super(SaleOrder, self)._prepare_order_line_move(cr, uid, order, line, picking_id, date_planned, context)
    	qty = line.product_uom_qty
        
        if line.product_uom_qty > line.product_id.qty_available:
    		qty = line.product_id.qty_available

        line.write({'shipped_qty':qty})
        res.update({'product_qty': qty})
        return res

    def _create_pickings_and_procurements(self, cr, uid, order, order_lines, picking_id=False, context=None):
    #		 res =super(sale_order, self)._create_pickings_and_procurements( cr, uid, order,order_lines, context)
    	move_obj = self.pool.get('stock.move')
    	picking_obj = self.pool.get('stock.picking')
    	inv_obj = self.pool.get('account.invoice')
    
    	for line in order_lines:
    		if line.state == 'done':
    			continue
    
    		date_planned = self._get_date_planned(cr, uid, order, line, order.date_order, context=context)
    
    		if line.product_id:
    			if line.product_id.type in ('product', 'consu'):
    				if not picking_id:
    					picking_id = picking_obj.create(cr, uid, self._prepare_order_picking(cr, uid, order, context=context))
    				move_id = move_obj.create(cr, uid, self._prepare_order_line_move(cr, uid, order, line, picking_id, date_planned, context=context))
                    
    			else:
    				# a service has no stock move
    				move_id = False
    			
    
    	wf_service = netsvc.LocalService("workflow")
    	if picking_id:
    		wf_service.trg_validate(uid, 'stock.picking', picking_id, 'button_confirm', cr)
    
    	val = {}
    	if order.state == 'shipping_except':
    		val['state'] = 'progress'
    		val['shipped'] = False
    
    		if (order.order_policy == 'manual'):
    			for line in order.order_line:
    				if (not line.invoiced) and (line.state not in ('cancel', 'draft')):
    					val['state'] = 'manual'
    					break
    	order.write(val)
    	return True
	
    def _make_invoice(self, cr, uid, order, lines, context=None):
    	 account_invoice_obj = self.pool.get('account.invoice')
    	 account_invoice_line_obj = self.pool.get('account.invoice.line')
    	 ret_rec = super(SaleOrder, self)._make_invoice(cr, uid, order, lines, context=context)
    	 invoice_rec = account_invoice_obj.browse(cr, uid, ret_rec, context=context)
    	 for line in invoice_rec.invoice_line:
    		 product_qty = line.product_id and line.product_id.qty_available or 0.0
    		 if line.quantity > product_qty:
    			account_invoice_line_obj.write(cr, uid, [line.id], {'quantity' : product_qty}, context=context)
    	 return ret_rec

SaleOrder()
