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

CC            = /usr/bin/gcc

LD            = /usr/bin/ld

VERSION       = 0.0.1.0

TARGETNAME    = resolver

SWR_PRJ_PATH  = .

TARGETPATH    = $(SWR_PRJ_PATH)

SRCPATH       = $(SWR_PRJ_PATH)

STD_EVENT     = ../../../src/std_event.h

DEPENDANCIES  = $(TARGETNAME).c	\ Makefile \
		$(INCLUDEPATH)/$(TARGETNAME).h \
		$(STD_EVENT) \
		format.h utils.h \
		hash_private.h hash.h\
		resolver_log.h\
		resolver_yacc.y resolver_lex.l \
		resolver_postgres_db.h \

SOURCES       = $(TARGETNAME).c utils.c format.c resolver_yacc.c resolver_lex.c \
		hash.c resolver_log.c resolver_postgres_db.c

OBJS	      = $(SOURCES:.c=.o)
#OBJS	      = *.o

LIBNUM	      = 1

#*
#* ---------------------
#* Compilation Flags
#* ---------------------
#*
INCLUDEPATH = -I$(SWR_PRJ_PATH)
LIBPATH = -L$(SWR_PRJ_PATH) -L../../../libs/


ifdef ENV_PG_INC_PATH
        INCLUDEPATH+=-I$(ENV_PG_INC_PATH)
endif

ifdef ENV_PG_LIB_PATH
        LIBPATH+=-L$(ENV_PG_LIB_PATH)
endif

CFLAGS        = -Wall -O0 -ggdb -fPIC -I$(INCLUDEPATH) 

LIBFLAGS      = $(LIBPATH) -shared -Wl,-rpath,./libs/ -Wl,-soname,

LIBS	      = -lpq

#DEBUG_FLAGS  = -DDEBUG_INFO

LEX           = flex
LEXLIB        = -lfl
LEX_FLAGS     =

YACC          = bison -y
YFLAGS        = -d

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

all: $(TARGETPATH)/lib$(TARGETNAME).so

$(TARGETPATH)/lib$(TARGETNAME).so: $(TARGETPATH)/lib$(TARGETNAME).so.$(LIBNUM)
	ln -s -f lib$(TARGETNAME).so.$(LIBNUM) $@ 

$(TARGETPATH)/lib$(TARGETNAME).so.$(LIBNUM): $(TARGETPATH)/$(OBJS)
	$(CC) $(LIBFLAGS)lib$(TARGETNAME).so.$(LIBNUM) -o $@ $(OBJS) $(LIBS)

$(TARGETPATH)/.o: $(DEPENDANCIES)
	$(CC) -c $(CFLAGS) $(DEBUG_FLAGS) $(SOURCES)

format.c: $(STD_EVENT) format.h format.static.header format.static.footer 
	cat $(STD_EVENT) | grep -v "#[[:space:]]*include" > _format.h
	gcc -E _format.h | gawk -f format.awk  > format.c
	rm -f _format.h

resolver_lex.c: resolver_lex.l resolver_yacc.h
	$(LEX) $(LEX_FLAGS) $(LFLAGS) -Presolver -o$@ resolver_lex.l

resolver_yacc.c: resolver_yacc.y
	$(YACC) $(YFLAGS) -presolver -o$@ resolver_yacc.y
 
#*
#* -------------------
#* Cleaning section
#* -------------------
#*

clean:
	rm -f resolver_yacc.h 
	rm -f format.c resolver_yacc.c resolver_lex.c
	rm -f *.o *.so *.so.1 

