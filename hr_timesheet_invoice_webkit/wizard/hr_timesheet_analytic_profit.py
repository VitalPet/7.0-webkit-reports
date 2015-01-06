# -*- coding: utf-8 -*-
##############################################################################
#
#    OpenERP, Open Source Management Solution
#    Copyright (C) 2011-2013 Serpent Consulting Services (<http://www.serpentcs.com>)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
############################################################################
import datetime

from openerp.osv import fields, osv
from openerp.tools.translate import _

class account_analytic_profit(osv.osv_memory):
    _inherit = 'hr.timesheet.analytic.profit'
    _description = 'Print Timesheet Profit'

    def print_report(self, cr, uid, ids, context=None):
        line_obj = self.pool.get('account.analytic.line')
        data = {}
        data['form'] = self.read(cr, uid , ids, [], context=context)[0]
        ids_chk = line_obj.search(cr, uid, [
                ('date', '>=', data['form']['date_from']),
                ('date', '<=', data['form']['date_to']),
                ('journal_id', 'in', data['form']['journal_ids']),
                ('user_id', 'in', data['form']['employee_ids']),
                ], context=context)
        if not ids_chk:
            raise osv.except_osv(_('Insufficient Data!'), _('No record(s) found for this report.'))

        data['form']['journal_ids'] = [(6, 0, data['form']['journal_ids'])] # Improve me => Change the rml/sxw so that it can support withou [0][2]
        data['form']['employee_ids'] = [(6, 0, data['form']['employee_ids'])]
        datas = {
             'ids': ids,
             'model': 'account.analytic.line',
             'form': data['form']
             }
        return {
            'type': 'ir.actions.report.xml',
            'report_name': 'account.analytic.profit.webkit',
            'datas': datas,
             }

account_analytic_profit()

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
