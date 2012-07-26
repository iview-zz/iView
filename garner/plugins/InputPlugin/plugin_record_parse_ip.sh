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

if [ $# -eq 0 ] ; then
    echo
    echo "Please give me library name yaar..."
    echo
    exit
fi

if [ -e $1 ] ; then
    echo "Library already exists"
    exit
fi

mkdir ./$1
sed s/"TARGETNAME    = Dummy"/"TARGETNAME    = $1"/g Makefile.cp > ./$1/Makefile
sed s/"libname"/"$1"/g libip.c.rec.cp > ./$1.c.tmp
sed s/"LIBNAME"/"`echo $1 | awk '{print toupper($1);}'`"/g ./$1.c.tmp > ./$1/$1.c
sed s/"LIBNAME"/"`echo $1 | awk '{print toupper($1);}'`"/g ./libip.h.cp > ./$1/$1.h
rm -f ./$1.c.tmp

echo
echo "Structure for $1 created successfully, now plz go and do some work...."
echo
exit
