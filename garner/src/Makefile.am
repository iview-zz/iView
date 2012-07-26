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


AM_YFLAGS = @YFLAGS@
AM_LIBS = @LIBS@
AM_LDFLAGS = @LDFLAGS@
SUBDIRS = @PROTOSUBDIRS@

sbin_PROGRAMS = garner

garner_SOURCES = \
	log.c log.h \
	utils.c utils.h \
	garner.c garner.h \
	std_event.c std_event.h \
	garner_yacc.y garner_lex.l

garner_lex.c: garner_lex.l garner_yacc.h
	$(LEX) $(LEX_FLAGS) $(LFLAGS) -Pgarner -o$@ garner_lex.l

garner_yacc.c: garner_yacc.y
	$(YACC) $(AM_YFLAGS) -p garner -o $@ garner_yacc.y

std_event.c: std_event.h std_event_private.h std_event.static.header std_event.static.footer
	cat std_event.h | grep -v "#[[:space:]]*include" > _std_event.h
	$(CC) -E _std_event.h | $(AWK) -f std_event.awk  > std_event.c
	rm -f _std_event.h
	
EXTRA_garner_SOURCES = garner_yacc.h
garner_DEPENDENCIES = @ADDITIONAL_OBJECTS@
#garner_LDADD = @ADDITIONAL_OBJECTS@ @LDADD@ -lbt -lsvc -lrt
garner_LDADD = @ADDITIONAL_OBJECTS@ @LDADD@ 
#garner_LDFLAGS = -L../libs -Wl,-dynamic-linker,./libs/ld-linux.so.2 -Wl,-rpath,./libs
garner_LDFLAGS = -L../libs

clean:
	rm -f *.o
	rm -f *.da
	rm -f gmon.out
	rm -f garner
	rm -f garner_lex.c garner_yacc.c garner_yacc.h
	rm -f std_event.c
