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


from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import datetime

from openerp.tools.translate import _
import time
from openerp import pooler
from openerp.report import report_sxw

def lengthmonth(year, month):
    if month == 2 and ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))):
        return 29
    return [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]

class employee_timesheet(report_sxw.rml_parse):

    def __init__(self, cr, uid, name, context):
        super(employee_timesheet, self).__init__(cr, uid, name, context=context)
        self.localcontext.update({
            'time': time,
            'get_month_name':self.get_month_name,
            'get_day_name':self.get_day_name,
            'lengthmonth':self.lengthmonth,
            'get_emp_data':self.get_emp_data,
            'get_emp_name':self.get_emp_name,
        })

    def lengthmonth(self,year, month):
        if month == 2 and ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))):
            return 29
        return [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]

    def get_month_name(self, month, context=None):
        _months = {1:_("January"), 2:_("February"), 3:_("March"), 4:_("April"), 5:_("May"), 6:_("June"), 7:_("July"), 8:_("August"), 9:_("September"), 10:_("October"), 11:_("November"), 12:_("December")}
        return _months[month]
    
    def get_day_name(self, year, month, day):
        days =[]
        name_of_day = datetime.datetime.weekday(datetime.date(year,month,day))
        if name_of_day == 0:
            return "Mon"
        elif name_of_day == 1:
            return "Tue"
        elif name_of_day == 2:
            return "Wed"
        elif name_of_day == 3:
            return "Thus"
        elif name_of_day == 4:
            return "Fri"
        elif name_of_day == 5:
            return "Sat"
        elif name_of_day == 6:
            return "Sun"

    def get_emp_name(self, data, context=None):
        # Get the user id from the selected employee record
        emp_id = data['form']['employee_id']
        emp_obj = pooler.get_pool(self.cr.dbname).get('hr.employee')
        user_id = emp_obj.browse(self.cr, self.uid, emp_id).user_id.id
        empl_name = emp_obj.browse(self.cr, self.uid, emp_id).name
        return empl_name
        
    def get_emp_data(self, data, context=None):
        emp_id = data['form']['employee_id']
        emp_obj = pooler.get_pool(self.cr.dbname).get('hr.employee')
        user_id = emp_obj.browse(self.cr, self.uid, emp_id).user_id.id
        # Computing the dates (start of month: som, and end of month: eom)
        som = datetime.date(data['form']['year'], data['form']['month'], 1)
        eom = som + datetime.timedelta(lengthmonth(som.year, som.month))
        # Sum attendence by account, then by day
        accounts = {}
        if user_id:
            # Computing the attendence by analytical account
            self.cr.execute(
                "select line.date, (unit_amount / unit.factor) as amount, account_id, account.name "\
                "from account_analytic_line as line, hr_analytic_timesheet as hr, "\
                "account_analytic_account as account, product_uom as unit "\
                "where hr.line_id=line.id and line.account_id=account.id "\
                "and product_uom_id = unit.id "\
                "and line.user_id=%s and line.date >= %s and line.date < %s "
                "order by line.date",
                (user_id, som.strftime('%Y-%m-%d'), eom.strftime('%Y-%m-%d')))
            for presence in self.cr.dictfetchall():
                day = int(presence['date'][-2:])
                account = accounts.setdefault((presence['account_id'], presence['name']), {})
                account[day] = account.get(day, 0.0) + presence['amount']
        tel = []
        name = []
        for account, telems in accounts.iteritems():
            aid, aname = account
            aname = pooler.get_pool(self.cr.dbname).get('account.analytic.account').name_get(self.cr, self.uid, [aid], context)
            name.append(aname[0][1])
            tel.append(telems)
        return name, tel

report_sxw.report_sxw('report.hr.analytical.timesheet.webkit', 'hr.employee','addons/hr_timesheet_webkit/report/user_timesheet.mako', parser=employee_timesheet, header='internal')


# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
