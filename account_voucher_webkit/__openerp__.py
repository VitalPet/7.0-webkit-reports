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

##############################################################################

{
    'name' : 'eInvoicing & Payments',
    'version' : '1.0',
    'author' : 'Serpent Consulting Services Pvt. Ltd.',
    'summary': 'Send Invoices and Track Payments',
    'description': """
Invoicing & Payments by Accounting Voucher & Receipts
=====================================================
    It is conversion of rml report to Webkit Report.
    """,
    'category': 'Accounting & Finance',
    'sequence': 4,
    'website' : 'http://serpentcs.com',
    'depends' : ['account_voucher','report_webkit'],
    'data' : [
        'account_voucher_report.xml',
    ],
    'auto_install': False,
    'application': True,
    'installable': True,
}

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
