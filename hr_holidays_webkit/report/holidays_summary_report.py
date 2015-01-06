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

from openerp.osv import fields, osv
from openerp.report.interface import report_rml
from openerp.report.interface import toxml

from openerp import pooler
import time
from openerp.report import report_sxw
from openerp.tools import ustr
from openerp.tools.translate import _
from openerp.tools import to_xml

#def lengthmonth(year, month):
#    if month == 2 and ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))):
#        return 29
#   return [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]

def strToDate(dt):
    if dt:
        dt_date=datetime.date(int(dt[0:4]),int(dt[5:7]),int(dt[8:10]))
        return dt_date
    else:
        return

class employee_holidays_summary(report_sxw.rml_parse):
    def __init__(self, cr, uid, name, context):
        super(employee_holidays_summary, self).__init__(cr, uid, name, context=context)
        self.localcontext.update({
            'time': time,
            'header_date':self.header_date,
            'lengthmonth':self.lengthmonth,
            'strToDate':self.strToDate,
            'month_name':self.month_name,
            'get_day_name':self.get_day_name,
            'leave_info_emp':self.leave_info_emp,
            'emp_data':self.emp_data,
            'month_dates':self.month_dates,
            'leave_info_dept':self.leave_info_dept,
            'leave_color':self.leave_color,
            
        })
    def emp_data(self,dept, holiday_type, empid, name, som, eom):
        display={}
        if dept==0:
            count=0
            p_id=pooler.get_pool(self.cr.dbname).get('hr.holidays').search(self.cr, self.uid, [('employee_id','in',[empid,False]), ('type', '=', 'remove')])
            ids_date = pooler.get_pool(self.cr.dbname).get('hr.holidays').read(self.cr, self.uid, p_id, ['date_from','date_to','holiday_status_id','state'])
    
            for index in range(1,61):
                diff=index-1
                current=som+datetime.timedelta(diff)
                for item in ids_date:
                    if current >= strToDate(item['date_from']) and current <= strToDate(item['date_to']):
                        if item['state'] in holiday_type:
                            display[index]=item['holiday_status_id'][0]
                            count=count +1
                        else:
                            display[index]=' '
                        break
                    else:
                        display[index]=' '
        else:
             for index in range(1,61):
                  display[index]=' '
                  count=''
        return display    
    
    
    def month_name(self, month):    
        month2name = [0, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']    
        return month2name[month]
            
    def lengthmonth(self, year, month):
        if month == 2 and ((year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0))):
            return 29
        return [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]

    def strToDate(self, dt):
        if dt:
            dt_date=datetime.date(int(dt[0:4]),int(dt[5:7]),int(dt[8:10]))
            return dt_date
        else:
            return

    def get_day_name(self, year, month, day):
        days =[]
        name_of_day = datetime.datetime.weekday(datetime.datetime(year,month,day))
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

    def header_date(self, data):
        obj_emp = pooler.get_pool(self.cr.dbname).get('hr.employee')
        date_today=time.strftime('%Y-%m-%d %H:%M:%S')
        today=datetime.datetime.today()
        first_date=data['form']['date_from']
        self.cr.execute("SELECT id, name, color_name FROM hr_holidays_status ORDER BY id")
        legend=self.cr.fetchall()
        som = strToDate(first_date)
        eom = som+datetime.timedelta(59)
        day_diff=eom-som
        name = ''
        if len(data['form'].get('emp', ())) == 1:
            name = obj_emp.read(self.cr, self.uid, data['form']['emp'][0], ['name'])['name']
            
        if data['form']['holiday_type']!='both':
            type=data['form']['holiday_type']
            if data['form']['holiday_type']=='Confirmed':
                holiday_type=('confirm')
            else:
                holiday_type=('validate')
        else:
            type="Confirmed and Approved"
            holiday_type=('confirm','validate')
        return som, eom, name, type, day_diff,holiday_type
    
    def month_dates(self,data):
        first_date=data['form']['date_from']
        som = strToDate(first_date)
        eom = som+datetime.timedelta(59)
        return som,eom
        
    def leave_info_emp(self,data, context=None):
        obj_dept = pooler.get_pool(self.cr.dbname).get('hr.department')
        obj_emp = pooler.get_pool(self.cr.dbname).get('hr.employee')
        first_date=data['form']['date_from']
        som = strToDate(first_date)
        eom = som+datetime.timedelta(59)
        depts=[]
        emp_id={}
        emp_rec = []
#        done={}
        rpt_obj = pooler.get_pool(self.cr.dbname).get('hr.holidays')
        if data['model']=='hr.employee':
            for id in data['form']['emp']:
                 items = obj_emp.read(self.cr, self.uid, id, ['id','name'])
                 emp_rec.append(items)
        return emp_rec

    def leave_color(self):
        self.cr.execute("SELECT id, name, color_name FROM hr_holidays_status ORDER BY id")
        legend=self.cr.fetchall()
        return legend

    def leave_info_dept(self,data, context=None):
        obj_dept = pooler.get_pool(self.cr.dbname).get('hr.department')
        obj_emp = pooler.get_pool(self.cr.dbname).get('hr.employee')
        first_date=data['form']['date_from']
        som = strToDate(first_date)
        eom = som+datetime.timedelta(59)
        depts=[]
        emp_id={}
        emp_rec = []
        if data['model']=='ir.ui.menu':
            for id in data['form']['depts']:
                dept = obj_dept.browse(self.cr, self.uid, id, context=context)
                self.cr.execute("""SELECT id FROM hr_employee \
                WHERE department_id = %s""", (id,))
                emp_ids = [x[0] for x in self.cr.fetchall()]
                if emp_ids==[]:
                    continue
                for item in obj_emp.read(self.cr, self.uid, emp_ids, ['id', 'name','department_id']):
                    emp_rec.append(item)
                depts.append(dept)
        return emp_rec,depts
#                print "emp_ids",emp_ids 
report_sxw.report_sxw('report.holidays.summary.webkit', 'hr.holidays', 'addons/hr_holidays_webkit/report/holidays_summary.mako', parser=employee_holidays_summary, header='internal')
# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:

