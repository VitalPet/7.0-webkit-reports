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

class analytical_timesheet_employees(osv.osv_memory):
    _inherit = 'hr.analytical.timesheet.users'

    def print_report(self, cr, uid, ids, context=None):
        data = self.read(cr, uid, ids, context=context)[0]
        datas = {
             'ids': [],
             'model': 'hr.employee',
             'form': data
                 }
        return {
            'type': 'ir.actions.report.xml',
            'report_name': 'hr.analytical.timesheet_users.webkit',
            'datas': datas,
            }

analytical_timesheet_employees()

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
