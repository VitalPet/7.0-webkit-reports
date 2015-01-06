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
import time
from openerp import pooler
from openerp.tools.translate import _
from openerp.report import report_sxw
from openerp.tools import ustr


def lengthmonth(year, month):
    if month == 2 and ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))):
        return 29
    return [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]

#def emp_data(cr, id, som, eom, emp):
#    # Computing the attendence by analytical account
#    cr.execute(
#        "select line.date, (unit_amount / unit.factor) as amount "\
#        "from account_analytic_line as line, hr_analytic_timesheet as hr, "\
#        "product_uom as unit "\
#        "where hr.line_id=line.id "\
#        "and product_uom_id = unit.id "\
#        "and line.user_id=%s and line.date >= %s and line.date < %s "
#        "order by line.date",
#        (id, som.strftime('%Y-%m-%d'), eom.strftime('%Y-%m-%d')))
#
#    # Sum by day
#    month = {}
#    days = [] 
#    amounts =[]
#    for presence in cr.dictfetchall():
#        day = int(presence['date'][-2:])
#        month[day] = month.get(day, 0.0) + presence['amount']
#    for day, amount in month.iteritems():
#        days.append(day)
#        amounts.append(amount)
#    return days, amounts,emp


class users_timesheet(report_sxw.rml_parse):

    def __init__(self, cr, uid, name, context):
        super(users_timesheet, self).__init__(cr, uid, name, context=context)
        self.localcontext.update({
            'time': time,
            'get_month_name':self.get_month_name,
            'get_day_name':self.get_day_name,
            'users_data':self.users_data,
            'lengthmonth':self.lengthmonth,
            'emp_data':self.emp_data,
            'user_name':self.user_name,
            'total_amt':self.total_amt,
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
        _day = {0:_('Mon'), 1:_('Tue'), 2:_('Wed'), 3:_('Thu'), 4:_('Fri'), 5:_('Sat'), 6:_('Sun')}
        return _day[name_of_day] 

    def users_data(self, data, context=None):

        # Computing the dates (start of month: som, and end of month: eom)
        print "DATA     ",data
        som = datetime.date(data['form']['year'], data['form']['month'], 1)
        eom = som + datetime.timedelta(lengthmonth(som.year, som.month))
        emp_obj = pooler.get_pool(self.cr.dbname).get('hr.employee')
        user_ids = []
        emp_names = []
        for id in data['form']['employee_ids']:
            user = emp_obj.browse(self.cr, self.uid, id).user_id.id
            empl_name = emp_obj.browse(self.cr, self.uid, id).name
            if user:
                user_ids.append(user)
                emp_names.append(empl_name)
        return user_ids
    
    def user_name(self, data, id, context=None):
        emp_obj = pooler.get_pool(self.cr.dbname).get('hr.employee')
        if id in data['form']['employee_ids']:
#            user = emp_obj.browse(self.cr, self.uid, id).user_id.id
            empl_name = emp_obj.browse(self.cr, self.uid, id).name
        return empl_name

    def emp_data(self, data, id, context=None):
        # Computing the attendence by analytical account
        
        som = datetime.date(data['form']['year'], data['form']['month'], 1)
        eom = som + datetime.timedelta(lengthmonth(som.year, som.month))

        self.cr.execute(
            "select line.date, (unit_amount / unit.factor) as amount "\
            "from account_analytic_line as line, hr_analytic_timesheet as hr, "\
            "product_uom as unit "\
            "where hr.line_id=line.id "\
            "and product_uom_id = unit.id "\
            "and line.user_id=%s and line.date >= %s and line.date < %s "
            "order by line.date",
            (id, som.strftime('%Y-%m-%d'), eom.strftime('%Y-%m-%d')))
    
        # Sum by day
        month = {}
        days = [] 
        amounts =[]
        for presence in self.cr.dictfetchall():
            day = int(presence['date'][-2:])
            month[day] = month.get(day, 0.0) + presence['amount']
        for day, amount in month.iteritems():
            days.append(day)
            amounts.append(amount)
            
            
#        print "DAYS      ",days, "       AMOUNTS ",amounts,"     MONTH            ",month
        return days, amounts, month
    
    def total_amt(self, data):
        som = datetime.date(data['form']['year'], data['form']['month'], 1)
        eom = som + datetime.timedelta(lengthmonth(som.year, som.month))

        print "day",days
        print "amounts",amounts
#        total = []
#        line = 0.0
        for day in days:
            print day
#            for amt in amounts:
#                line = line + amt 
#        print amounts

report_sxw.report_sxw('report.hr.analytical.timesheet_users.webkit', 'hr.employee','addons/hr_timesheet_webkit/report/users_timesheet.mako', parser=users_timesheet, header='internal')
# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:

