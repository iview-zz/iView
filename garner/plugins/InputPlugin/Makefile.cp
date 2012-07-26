#*
#* ------------------------------------------------------
#* Authors   : Vivek Yagnik 
#* Company   : elitecore technologies ltd.
#* Date      : 18-10-2007
#* File Name : Makefile
#* File Aim  : To compile plugins for garner
#* ------------------------------------------------------
#*

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

TARGETNAME    = Dummy

SWR_PRJ_PATH  = .

TARGETPATH    = $(SWR_PRJ_PATH)

SRCPATH       = $(SWR_PRJ_PATH)

INCLUDEPATH   = $(SWR_PRJ_PATH)

DEPENDANCIES  = $(TARGETNAME).c	\
		$(INCLUDEPATH)/$(TARGETNAME).h \
		../../../src/std_event.h

SOURCES       = $(TARGETNAME).c

OBJS          = $(SOURCES:.c=.pic.o)

LIBNUM     = 1

#*
#* ---------------------
#* Compilation Flags
#* ---------------------
#*

CFLAGS        = -Wall -O0 -ggdb -fPIC -I$(INCLUDEPATH) 

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

all: $(TARGETPATH)/lib$(TARGETNAME).so

$(TARGETPATH)/lib$(TARGETNAME).so: $(TARGETPATH)/lib$(TARGETNAME).so.$(LIBNUM)
	ln -s -f lib$(TARGETNAME).so.$(LIBNUM) $@ 

$(TARGETPATH)/lib$(TARGETNAME).so.$(LIBNUM): $(TARGETPATH)/$(OBJS)
	$(CC) $(LIBFLAGS)lib$(TARGETNAME).so.$(LIBNUM) -o $@ $<

$(TARGETPATH)/%.pic.o: $(DEPENDANCIES)
	$(CC) -c $(CFLAGS) $(DEBUG_FLAGS) $(SOURCES) -o $@ 

#*
#* -------------------
#* Cleaning section
#* -------------------
#*

clean:
	rm -f *.o *.so *.so.1 

