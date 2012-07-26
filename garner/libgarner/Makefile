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

#*
#* ------------------------------
#* Start of macro declarations
#* ------------------------------
#*

#*
#* -------------------------
#* Configurable Parameters
#* -------------------------
#*

CC            = gcc

LD            = ld

VERSION       = 0.0.1.0

TARGETNAME    = garnerc

SWR_PRJ_PATH  = .

TARGETPATH    = $(SWR_PRJ_PATH)

INCLUDEPATH   = $(SWR_PRJ_PATH)

DEPENDANCIES  = $(TARGETNAME).c	\
		$(INCLUDEPATH)/$(TARGETNAME).h

SOURCES       = $(TARGETNAME).c

LIBNUM     = 1

#*
#* ---------------------
#* Compilation Flags
#* ---------------------
#*

CFLAGS        = -Wall -O0 -ggdb -fPIC -I$(INCLUDEPATH) 
TSFLAGS	      = -pthread -D_GNU_SOURCE -D_THREAD_SAFE -D_REENTRANT -DGR_REENTRANT

LIBFLAGS      = -shared -Wl,-soname,

#*
#* ---------------------------
#* End of macro declarations
#* ---------------------------
#*


#*
#* ----------------------
#* Compilation section
#* ----------------------
#*

all: $(TARGETPATH)/lib$(TARGETNAME).so $(TARGETPATH)/lib$(TARGETNAME)_r.so $(TARGETPATH)/test

#* Non reentrant
$(TARGETPATH)/lib$(TARGETNAME).so: $(TARGETPATH)/$(TARGETNAME).o
	$(CC) $(LIBFLAGS)lib$(TARGETNAME).so -o $@ $<

$(TARGETPATH)/$(TARGETNAME).o: $(DEPENDANCIES)
	$(CC) -c $(CFLAGS) $(DEBUG_FLAGS) $(SOURCES) -o $@ 

#* Reentrant
$(TARGETPATH)/lib$(TARGETNAME)_r.so: $(TARGETPATH)/$(TARGETNAME)_r.o
	$(CC) $(LIBFLAGS)lib$(TARGETNAME)_r.so -lpthread -o $@ $<

$(TARGETPATH)/$(TARGETNAME)_r.o: $(DEPENDANCIES)
	$(CC) -c $(CFLAGS) $(TSFLAGS) $(DEBUG_FLAGS) $(SOURCES) -o $@ 

$(TARGETPATH)/test: test.c
	$(CC) $(CFLAGS) $(DEBUG_FLAGS) -L$(TARGETPATH) -l$(TARGETNAME) test.c -o $@ 


#*
#* -------------------
#* Cleaning section
#* -------------------
#*

clean:
	rm -f *.o *.so *.so.1 test

