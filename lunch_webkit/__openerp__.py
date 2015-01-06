# -*- coding: utf-8 -*-
##############################################################################
#
#    OpenERP, Open Source Management Solution
#    Copyright (C) 2011-2013 Serpent Consulting Services Pvt. Ltd. (<http://www.serpentcs.com>)
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


{
    'name': 'Lunch Orders Webkit',
    'author': 'Serpent Consulting Services Pvt. Ltd.',
    'version': '1.0',
    'depends': ['report_webkit','lunch'],
    'category' : 'Tools',
    'summary': 'Lunch Order, Meal, Food',
    'description': """
The base module to manage lunch.
================================
    It is conversion of rml report to Webkit Report.

    """,
    'data': [
             'lunch_report.xml',
             ],
    'installable': True,
    'application' : True,
    'auto_install': False,
}
