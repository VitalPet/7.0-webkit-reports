# -*- coding: utf-8 -*-
##############################################################################
#
#    This module uses OpenERP, Open Source Management Solution Framework.
#    Copyright (C) 2012-Today Serpent Consulting Services Pvt. Ltd.(<http://www.serpentcs.com>)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>
#
##############################################################################


{
    "name" : 'An Extension to Sales Management',
    "version" : "1.0",
    "depends" : ["sale_stock"],
    'category': 'Sales Management',
    'sequence': 15,
    "author" : "Serpent Consulting Services Pvt. Ltd.",
    "description": """
    This module is an extension to Sales Management where we deliver only the available qty of product, 
    thus no backorder generation.
    """,
    "website" : "www.serpentcs.com",
    "demo" : [],
    "data" : [
        'sale_report.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': True,
}
