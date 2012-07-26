#!/bin/sh
# ***********************************************************************
# Cyberoam iView - The Intelligent logging and reporting solution that 
# provides network visibility for security, regulatory compliance and 
# data confidentiality 
# Copyright  (C ) 2009  Elitecore Technologies Ltd.
# 
# This program is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by 
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License 
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# The interactive user interfaces in modified source and object code 
# versions of this program must display Appropriate Legal Notices, as 
# required under Section 5 of the GNU General Public License version 3.
# 
# In accordance with Section 7(b) of the GNU General Public License 
# version 3, these Appropriate Legal Notices must retain the display of
#  the "Cyberoam Elitecore Technologies Initiative" logo.
# ***********************************************************************

#
# A very crude way of generating a C file from .h file.
# While writing this script, i did not give any thought to scalability
# and compatibility. At present this should be taken as 'it works
# for particular kind of header files.
#

BEGIN {
	level = 0
	printf "/* This is an auto-generated file, please do not edit it. */"
	printf "\n\n"
	system("cat format.static.header");
	done = 0
}

{
  if(done == 0) {
    gsub(";", "");
    gsub("\\[[[:print:]]*\\]", "");
    if(NF > 0 && substr($1, 1, 1) != "#") {
	if($1 == "struct") {
	    array[level++] = substr($2, 2)
	} else if(substr($1, 1) == "}") {
	    level--;
	    if(level == 0) {
		done = 1;
	    }
	} else if(level > 0) {
	    variable = "";
	    for(i=1; i<level; i++) {
		variable = variable array[i] ".";
	    }
	    variable = variable $2
	    printf "  { __RESOLVER_ROUTINES("$1"), sizeof(resolv_std_ev." variable "), \"" $1 "\", \"" array[0] "." variable "\",  __RESOLVER_FO(struct _" array[0] ", " variable ")},\n";
	}
    }
  }
}

END {
	system("cat format.static.footer");
}
