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

TARGETNAME    = fwstub

SWR_PRJ_PATH  = .

TARGETPATH    = $(SWR_PRJ_PATH)

SRCPATH       = $(SWR_PRJ_PATH)

PERL_PATH     = /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/

INCLUDEPATH   = -I$(SWR_PRJ_PATH)

STD_EVENT     = ../../../src/std_event.h

ifeq ($(ENV_CCC_BUILD), 1)
CCCFLAG = -DENABLE_FWSTUB_ALLOW_ALL
endif

DEPENDANCIES  = Makefile \
		$(INCLUDEPATH)/$(TARGETNAME).h \
		$(STD_EVENT) \
		fwstub_log.h \
		fwstub_utils.h \
		config.h utils.h \
		fwstub_yacc.y \
		fwstub_lex.l \

SOURCES     = fwstub_yacc.c fwstub_lex.c config.c utils.c fwstub_log.c

OBJS	    = $(SOURCES:.c=.o)
#OBJS	    = *.o

LIBNUM      = 1

#*
#* ---------------------
#* Compilation Flags
#* ---------------------
#*

PERL_CFLAGS    = `perl -MExtUtils::Embed -e ccopts` 
PERL_LDFLAGS    = `perl -MExtUtils::Embed -e ldopts` 
CFLAGS		= -Wall -O0 -ggdb -DREGEX $(CCCFLAG)  -fPIC $(INCLUDEPATH)
LIBFLAGS	= -shared $(PERL_LDFLAGS) -L../../../libs/ -Wl,-rpath,./libs/ -Wl,-soname,
LIBS		= -lperl -lresolv -ldl -lm -lcrypt -lutil -lpthread -lc

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

$(TARGETPATH)/lib$(TARGETNAME).so.$(LIBNUM): $(TARGETNAME).o fwstub_utils.o $(TARGETPATH)/$(OBJS) 
	$(CC) $(LIBFLAGS)lib$(TARGETNAME).so.$(LIBNUM) -o $@ $(OBJS) $(TARGETNAME).o fwstub_utils.o $(LIBS)

$(TARGETNAME).o: $(TARGETNAME).c
	$(CC) -c $(CFLAGS) $(PERL_CFLAGS) $(DEBUG_FLAGS) $(TARGETNAME).c

fwstub_utils.o: fwstub_utils.c
	$(CC) -c $(CFLAGS) $(PERL_CFLAGS) $(DEBUG_FLAGS) fwstub_utils.c

$(TARGETPATH)/.o: $(DEPENDANCIES)
	$(CC) -c $(CFLAGS) $(DEBUG_FLAGS) $(SOURCES)

config.c: $(STD_EVENT) config.h config.static.header config.static.footer
	cat $(STD_EVENT) | grep -v "#[[:space:]]*include" > _config.h
	gcc -E _config.h | gawk -f config.awk  > config.c
	rm -f _config.h

fwstub_lex.c: fwstub_lex.l fwstub_yacc.h
	$(LEX) $(LEX_FLAGS) $(LFLAGS) -Pfwstub -o$@ fwstub_lex.l

fwstub_yacc.c: fwstub_yacc.y
	$(YACC) $(YFLAGS) -pfwstub -o$@ fwstub_yacc.y

#*
#* -------------------
#* Cleaning section
#* -------------------
#*

clean:
	rm -f fwstub_yacc.h 
	rm -f fwstub_yacc.c fwstub_lex.c
	rm -f config.c
	rm -f *.o *.so *.so.1 

