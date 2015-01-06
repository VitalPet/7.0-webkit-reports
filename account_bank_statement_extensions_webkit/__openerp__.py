# -*- coding: utf-8 -*-
##############################################################################
#
#    OpenERP, Open Source Management Solution
#    Copyright (C) 2011-2013 Serpent Consulting Services Pvt. Ltd.(<http://www.serpentcs.com>)
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
    'name': 'Bank Statement Extensions to Support e-banking Webkit',
    'version': '1.0',
    'author': 'Serpent Consulting Services Pvt. Ltd.',
    'category': 'Generic Modules/Accounting',
    'description': '''
Module that extends the standard account_bank_statement_line object for improved e-banking support.
===================================================================================================

 It is conversion of rml report to Webkit Report.

    ''',
    'depends': ['account_bank_statement_extensions','report_webkit'],
    'data' : [
        'account_bank_statement_report.xml',
    ],
    'auto_install': False,
    'installable': True,
}

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
