dnl Devlopers, please strive to achieve this order:
dnl
dnl 0. Initialization and options processing
dnl 1. Programs
dnl 2. Libraries
dnl 3. Header files
dnl 4. Types
dnl 5. Structures
dnl 6. Compiler characteristics
dnl 7. Functions, global variables
dnl 8. System services
dnl
dnl Read the Autoconf manual for details.

AC_INIT([garner-iView],[0.0.0.9])
AC_CONFIG_SRCDIR([src/garner.c])
#AC_PREREQ(2.63)
AC_PREREQ(2.52)

AC_CANONICAL_TARGET

AH_TEMPLATE([TARGET_SYSTEM],
	    [A string containing the target system for which garner was built.])
AC_DEFINE_UNQUOTED(TARGET_SYSTEM, ["$target"])

AM_INIT_AUTOMAKE($PACKAGE_NAME, $PACKAGE_VERSION)
AC_CONFIG_HEADERS([config.h])

dnl Check if we're compiling on a weird platform :)
AC_USE_SYSTEM_EXTENSIONS

dnl
dnl Command line options
dnl

dnl Set the default configuration file location
test "$prefix" = "NONE" && prefix=/usr/local

AH_TEMPLATE([DEFAULT_CONF_FILE],
	[This is the default file name for the configuration file.])
AC_ARG_WITH(config,
	    [AS_HELP_STRING([--with-config=FILE],[Set the default location of the config file])],
	    [tp_config_file="$withval"],
	    [tp_config_file="garner.conf"])

# If the first character is a slash, it's an absolute path
if [[ `echo $tp_config_file | cut -c1` = "/" ]]; then
	GARNER_CONFIG_DIR=`echo "$tp_config_file" | sed 's/^\(.*\)\/[[^\/]]*$/\1/'`
        GARNER_CONFIG_FILE=`echo "$tp_config_file" | sed 's/^.*\/\([[^\/]]*\)$/\1/'`
else
	# If sysconfdir is /usr/etc, change it to /etc (since /usr/etc doesn't exist)
	if [[ "/usr/etc" = `eval echo $sysconfdir` -a "/usr" = "$prefix" ]]; then
		GARNER_CONFIG_DIR="/etc/garner"
	else
		GARNER_CONFIG_DIR=`eval echo $sysconfdir/garner`
	fi
        GARNER_CONFIG_FILE="$tp_config_file"
fi

AC_DEFINE_UNQUOTED(DEFAULT_CONF_FILE, "$GARNER_CONFIG_DIR/$GARNER_CONFIG_FILE")

AH_TEMPLATE([DEFAULT_CONF_DIR],
	    [Default directory where all configuration are found.])
AC_DEFINE_UNQUOTED(DEFAULT_CONF_DIR, "$GARNER_CONFIG_DIR")

AC_MSG_NOTICE([Default config location and file is: $GARNER_CONFIG_DIR/$GARNER_CONFIG_FILE])

dnl Set the default log file location
test "$prefix" = "NONE" && prefix=/usr/local
test "$localstatedir" = "NONE" && localstatedir=$prefix/var
GARNER_LOG_DIR=`eval echo $localstatedir/log/garner`

AH_TEMPLATE([DEFAULT_LOG_FILE],
	[This is the default file name for the log file.])
AC_ARG_WITH(logfile,
            [AS_HELP_STRING([--with-logfile=FILE],[Set the default log file])],
	    [tp_log_file="$withval"],
	    [tp_log_file="garner.log"])

# If the first character is a slash, it's an absolute path
if [[ `echo $tp_log_file | cut -c1` = "/" ]]; then
	GARNER_LOG_DIR=`echo "$tp_log_file" | sed 's/^\(.*\)\/[[^\/]]*$/\1/'`
        GARNER_LOG_FILE=`echo "$tp_log_file" | sed 's/^.*\/\([[^\/]]*\)$/\1/'`
else
	GARNER_LOG_DIR=`eval echo $localstatedir/log/garner`
        GARNER_LOG_FILE="$tp_log_file"
fi

AC_DEFINE_UNQUOTED(DEFAULT_LOG_FILE, "$GARNER_LOG_DIR/$GARNER_LOG_FILE")

AH_TEMPLATE([DEFAULT_LOG_DIR],
	    [Default directory where all configuration are found.])
AC_DEFINE_UNQUOTED(DEFAULT_LOG_DIR, "$GARNER_LOG_DIR")

AC_MSG_NOTICE([Default log location and file is: $GARNER_LOG_DIR/$GARNER_LOG_FILE])

dnl Set the default pid file location
test "$prefix" = "NONE" && prefix=/usr/local
test "$localstatedir" = "NONE" && localstatedir=$prefix/var
GARNER_LOG_DIR=`eval echo $localstatedir/run`

AH_TEMPLATE([DEFAULT_PID_FILE],
	[This is the default file name for the pid file.])
AC_ARG_WITH(pidfile,
            [AS_HELP_STRING([--with-pidfile=FILE],[Set the default pid file])],
	    [tp_pid_file="$withval"],
	    [tp_pid_file="garner.pid"])

# If the first character is a slash, it's an absolute path
if [[ `echo $tp_pid_file | cut -c1` = "/" ]]; then
	GARNER_PID_DIR=`echo "$tp_pid_file" | sed 's/^\(.*\)\/[[^\/]]*$/\1/'`
        GARNER_PID_FILE=`echo "$tp_pid_file" | sed 's/^.*\/\([[^\/]]*\)$/\1/'`
else
	GARNER_PID_DIR=`eval echo $localstatedir/run`
        GARNER_PID_FILE="$tp_pid_file"
fi

AC_DEFINE_UNQUOTED(DEFAULT_PID_FILE, "$GARNER_PID_DIR/$GARNER_PID_FILE")

AC_MSG_NOTICE([Default pid location and file is: $GARNER_PID_DIR/$GARNER_PID_FILE])

dnl Set the default libraries.
LIBS="-ldl"
LDFLAGS="-rdynamic"

dnl Add compiler-specific optimization flags
AC_ARG_ENABLE(debug,
              [AS_HELP_STRING([--enable-debug],[Disable aggressive optimizations (default is NO)])],
              debug_enabled=$enableval, debug_enabled=no)

dnl Add garner specific memory debugging options 
AC_ARG_ENABLE(debug-memory,
              [AS_HELP_STRING([--enable-debug-memory],[Debug memory allocation (helps in detecting memory leaks)(default is NO)])],
              debug_memory_enabled=$enableval, debug_memory_enabled=no)

dnl Add in profiling information
AC_ARG_ENABLE(profiling,
              [AS_HELP_STRING([--enable-profiling],[Enable profiling information (default is NO)])],
              profiling_enabled=$enableval, profiling_enabled=no)

dnl Include SOCKS support
AC_ARG_ENABLE(socks,
              [AS_HELP_STRING([--enable-socks],[Enable SOCKS support (default is NO)])],
              socks_enabled=$enableval, socks_enabled=no)

dnl Include support for a statically compiled garner
AC_ARG_ENABLE(static,
              [AS_HELP_STRING([--enable-static],[Statically link garner (default is NO)])],
	      [LDFLAGS="-static $LDFLAGS"])

dnl
dnl Checks for programs
dnl

AC_PROG_MAKE_SET
AC_PROG_CC
AC_SEARCH_LIBS([strerror],[cposix])
AC_PROG_INSTALL
AC_PROG_RANLIB
AC_PROG_LN_S
AM_PROG_LEX
AC_PROG_YACC
AC_PROG_AWK

dnl If a CFLAGS variable was passed during configure, set the initial
dnl CFLAGS variable to it; otherwise, start with an empty CFLAGS
if test x"$ac_env_CFLAGS_set" = x"set" ; then
    CFLAGS=ac_env_CFLAGS_value
else
    CFLAGS="-pthread -D_GNU_SOURCE -D_THREAD_SAFE -D_REENTRANT $CFLAGS -Wall -ggdb -fno-inline"
fi

dnl Enable support for cygwin
AC_ARG_ENABLE(cygwin,
              [AS_HELP_STRING([--enable-cygwin],[Enable support for cygwin (default is NO)])],
              [CFLAGS="$CFLAGS -D_ENABLE_CYGWIN"])

dnl Enable support for bt
AC_ARG_ENABLE(bt,
              [AS_HELP_STRING([--enable-bt],[Enable support for cygwin (default is NO)])],
              [CFLAGS="$CFLAGS -D_ENABLE_BT"])

dnl Enable support for clockevent
AC_ARG_ENABLE(clockevent,
              [AS_HELP_STRING([--enable-clockevent],[Enable support for cygwin (default is NO)])],
              [CFLAGS="$CFLAGS -D_ENABLE_CLOCKEVENT"])

dnl Make sure YACC is actually bison
if test x"$YACC" != x"bison -y"; then
    AC_MSG_WARN([You will need bison if you want to regenerate the parser.])
fi

dnl
dnl Checks for libraries
dnl
AC_CHECK_LIB(socket, socket, , [AC_CHECK_LIB(socket, htonl)])
AC_CHECK_LIB(resolv, inet_aton)
AC_CHECK_LIB(socks, main, socks_library=yes, socks_library=no)

dnl
dnl Checks for headers
dnl
AC_HEADER_STDC
AC_HEADER_TIME
AC_CHECK_HEADERS([sys/ioctl.h sys/mman.h sys/resource.h \
		  sys/select.h sys/socket.h sys/time.h sys/uio.h \
		  sys/un.h sys/wait.h arpa/inet.h netinet/in.h alloca.h \
		  ctype.h errno.h fcntl.h grp.h io.h libintl.h \
		  netdb.h pwd.h regex.h signal.h stdarg.h stddef.h stdio.h \
		  sysexits.h time.h wchar.h wctype.h])

dnl OpenBSD machines don't like having malloc included (even if it's present)
dnl as they expect you to use stdlib.h
case "$target" in
    *-openbsd*) ;;
    *)         AC_CHECK_HEADER(malloc.h);;
esac

AC_CHECK_HEADER(socks.h, socks_header=yes, socks_header=no)


dnl
dnl Checks for types
dnl
AM_C_PROTOTYPES
AC_C_CONST
AC_C_INLINE
AC_TYPE_SIZE_T
AC_TYPE_PID_T
AC_DIAGNOSE([obsolete],[your code may safely assume C89 semantics that RETSIGTYPE is void.
Remove this warning and the `AC_CACHE_CHECK' when you adjust the code.])dnl
AC_CACHE_CHECK([return type of signal handlers],[ac_cv_type_signal],[AC_COMPILE_IFELSE(
[AC_LANG_PROGRAM([#include <sys/types.h>
#include <signal.h>
],
		 [return *(signal (0, 0)) (0) == 1;])],
		   [ac_cv_type_signal=int],
		   [ac_cv_type_signal=void])])
AC_DEFINE_UNQUOTED([RETSIGTYPE],[$ac_cv_type_signal],[Define as the return type of signal handlers
		    (`int' or `void').])

AC_UNP_CHECK_TYPE(uint8_t, unsigned char)
AC_UNP_CHECK_TYPE(int16_t, short)
AC_UNP_CHECK_TYPE(uint16_t, unsigned short)
AC_UNP_CHECK_TYPE(int32_t, int)
AC_UNP_CHECK_TYPE(uint32_t, unsigned int)
AC_UNP_CHECK_TYPE(ssize_t, int)
AC_UNP_CHECK_TYPE(socklen_t, unsigned int)
AC_UNP_CHECK_TYPE(in_addr_t, uint32_t)


dnl
dnl Checks for libary functions
dnl
AC_FUNC_ALLOCA

AC_CHECK_FUNCS([isascii memcpy setrlimit ftruncate])
AC_CHECK_FUNCS([strlcpy strlcat])

dnl
dnl Compiler characteristics
dnl

dnl If profiling is enabled, then enable the debugging code
if test x"$profiling_enabled" = x"yes" ; then
    AC_MSG_NOTICE([profiling is enabled, therefore enabling debugging code.])
    debug_enabled=yes
fi

dnl Enable the debugging flags (by checking for the GCC compiler)
if test x"$debug_enabled" = x"yes" ; then
    dnl Add the warnings if we have the GCC compiler
    if test x"$GCC" = x"yes" ; then
        if test x"$profiling_enabled" = x"yes" ; then
	    CFLAGS="-pg -fprofile-arcs $CFLAGS"
        fi
        CFLAGS="-Wshadow -Wcast-qual -Wcast-align -Wstrict-prototypes $CFLAGS"
        CFLAGS="-Wmissing-prototypes -Wmissing-declarations $CFLAGS"
        CFLAGS="-Wpointer-arith -Waggregate-return -Wnested-externs $CFLAGS"
    fi
    CFLAGS="$CFLAGS -DYYDEBUG"
    YFLAGS="-v -d"

#    if test x"$ac_cv_prog_LEX" = x"flex" ; then
#        LEX_FLAGS="--warn --debug"
#    fi
else
    dnl No debugging information, include the optimizations
    YFLAGS="-d"
fi

dnl If memory debugging is enabled, then define DEBUG_GARNER_MEM macro.
if test x"$debug_memory_enabled" = x"yes" ; then
    AC_MSG_NOTICE([debugging memory is enabled.])
    CFLAGS="$CFLAGS -DDEBUG_GARNER_MEM"
fi


dnl
dnl Make sure we can actually handle the "--with-*" and "--enable-*" stuff.
dnl

dnl Handle the SOCKS support
if test x"$socks_enabled" = x"yes"; then
    if test x"$socks_header" = x"yes" -a x"$socks_library" = x"yes"; then
        CFLAGS="-I/usr/include/sock.h -DSOCKS $CFLAGS"
        LIBS="-lsocks $LIBS"
    else
        AC_MSG_ERROR([Could not include the SOCKS library or header])
    fi
fi

dnl
dnl Printing default config file, log file, and pid file.
dnl
AC_MSG_NOTICE([Default config file is: $GARNER_CONFIG_DIR/$GARNER_CONFIG_FILE])
AC_MSG_NOTICE([Default log file is: $GARNER_LOG_DIR/$GARNER_LOG_FILE])
AC_MSG_NOTICE([Default pid location and file is: $GARNER_PID_DIR/$GARNER_PID_FILE])
AC_MSG_NOTICE([Protocol subdirectories enabled: $PROTOSUBDIRS])
AC_MSG_NOTICE([Setting CFLAGS to: $CFLAGS.])
AC_MSG_NOTICE([Setting LDADD to: $LDADD.])

dnl
dnl Substitute the variables into the various Makefiles
dnl
AC_SUBST(CFLAGS)
AC_SUBST(LDADD)
AC_SUBST(LDFLAGS)
AC_SUBST(YFLAGS)
AC_SUBST(CPPFLAGS)
AC_SUBST(LEX_FLAGS)
AC_SUBST(LIBS)
AC_SUBST(ADDITIONAL_OBJECTS)
AC_SUBST(GARNER_CONFIG_DIR)
AC_SUBST(GARNER_CONFIG_FILE)
AC_SUBST(PROTOSUBDIRS)

AC_CONFIG_FILES([Makefile src/Makefile doc/Makefile])
AC_OUTPUT
