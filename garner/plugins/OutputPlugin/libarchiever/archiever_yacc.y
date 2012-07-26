%{
#define _GNU_SOURCE

    #include <stdio.h>
    #include <netdb.h>
    #include <errno.h>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <sys/types.h>
    #include <string.h>
    #include <stdlib.h>
    #include <stdarg.h>

    #include "utils.h"
    #include "format.h"
    
    #define YYERROR_VERBOSE 1

    void archiever_report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void archievererror(char *);
    extern int archieverlex(void);
    extern inline int archiever_getlineno();
    extern inline const char* archiever_getfilename();
    extern void archiever_free_istack();
    extern int archiever_include_file(const char *filename);
    extern void archiever_lex_flush();

    /* globals - should be reset on start */
    static char *basedir=NULL;

    extern FILE *archieverin;

    /* routines */
%}

%union {
    unsigned int num;
    char chr;
    char *cptr;
    struct _log_format *logformat;
}

/* include */
%token KW_INCLUDE

/* logger */
%token KW_LOGGER KW_MD5SUM

/* logformatter */
%token KW_LOGFORMATTER
%token KW_LOGFORMAT

/* archiever */
%token KW_ARCHIEVER

/* yes/no switches */
%token KW_YES KW_NO

%left '|' 
%left '&'
%left '!'

%token <num>	NUMBER    
%token <cptr>	IDENTIFIER
%token <cptr>	STRING    
%token <cptr>	IPV4_ADDRESS
%token <cptr>	IPV4_NETWORK
%token <cptr>	IPV4_RANGE
%token <cptr>   IPV4_CIDRNETWORK

/* Following variables are duplicated:
 * IDENTIFIER
 * STRING
 * IPV4_ADDRESS
 * IPV4_CIDRNETWORK
 * IPV4_NETWORK
 */

%type <cptr>		string
%type <cptr>    	stringnocrlf
%type <logformat> 	logformats
%type <logformat>	__formatitems
%type <num>		md5sum_flag

%start program

%%

program:
	program 
	blocks
	| /* NULL */
	;

blocks:
	'\n'
	|
	logger
	|
	logformatter
	|
	archiever
	;

/* LOGGER */
logger:
	KW_LOGGER IDENTIFIER skipnl '{' skipnl KW_LOGGER stringnocrlf NUMBER NUMBER skipnl md5sum_flag skipnl '}' {
	    struct _logger *logger;
									
	    logger = get_logger_by_name($2);
	    if(logger) {
		archiever_report_error("logger named '%s' already defined before.", $2);
		free($2);
		free($7);
		YYABORT;
	    }

	    logger = new_logger();
	    logger->name = $2;
	    logger->base_dir = $7;
	    logger->max_filesize = $8;
	    if($9) {
		logger->index_flag = 1;
	    } else {
		logger->index_flag = 0;
	    }		
	    logger->fd = -1;
	    logger->logfile = NULL;
	    logger->md5sum = $11;

	    arch_log_msg(ARCH_LG_INFO, "registering logger: %s\n", $2);
	    insert_logger_in_list(logger);
	}
	;

md5sum_flag:
	KW_MD5SUM {
	    $$ = 1;
	}
	| /*Default off*/
	{
	    $$ = 0;
	}
	;


/* LOGFORMATTER */
logformatter:
	KW_LOGFORMATTER IDENTIFIER skipnl '{' skipnl logformats skipnl '}' {
	    struct _logformatter *formatter;
	    formatter = get_logformatter_by_name($2);
	    if(formatter) {
		archiever_report_error("logformatter named '%s' already defined before.", $2);
		free($2) ;
		free_log_format($6);
		YYABORT;
	    }
	    formatter = new_logformatter();
	    formatter->name = $2;
	    formatter->logformat = $6;
	    arch_log_msg(ARCH_LG_INFO, "registering logformatter: %s\n", $2);
	    insert_logformatter_in_list(formatter);
	}
	;

logformats:
        KW_LOGFORMAT __formatitems '\n'	{
	    $$ = $2 ;
	}
        ;
        
__formatitems:
        string {
            struct _log_format *format;

            format = prepare_log_format($1);

            if (!format) {
                archiever_report_error("Invalid log format: %s", $1);
                free($1);
                YYABORT;
            }
            free($1);
	    $$ = format ;
        }
        ;


/* ARCHIEVER */
archiever:
        KW_ARCHIEVER IDENTIFIER skipnl '{' skipnl KW_ARCHIEVER IDENTIFIER IDENTIFIER NUMBER skipnl '}' {
	    struct _logger *logger;
	    struct _logformatter *logformatter;
            struct _archiever *archiever;

            archiever = get_archiever_by_name($2);
            if(archiever) {
                archiever_report_error("archiever named '%s' already defined before.", $2);
                free($2);
                free($7);
                free($8);
                YYABORT;
            }
		
	    logger = get_logger_by_name($7);
	    if(!logger) {
		archiever_report_error("logger named '%s' not found.", $7);
		free($2) ;
                free($7);
                free($8);
                YYABORT;
	    }	
	
	    logformatter = get_logformatter_by_name($8);
	    if(!logformatter) {
		archiever_report_error("logformatter named '%s' not found.", $8);
		free($2) ;
                free($7);
                free($8);
                YYABORT;
	    }	
			
	
            archiever = new_archiever();
            archiever->name = $2;
	    archiever->logger = logger;
	    archiever->logformatter = logformatter;
	    archiever->rotation_period = $9;
	    arch_log_msg(ARCH_LG_DEBUG, "NEW ARCHIEVER DETAILS:\n");
	    arch_log_msg(ARCH_LG_DEBUG, "archiever name: %s\n", archiever->name);
	    arch_log_msg(ARCH_LG_DEBUG, "selected logger: '%s'\n", logger->name);
	    arch_log_msg(ARCH_LG_DEBUG, "selected logformatter: '%s'\n", logformatter->name );
	    arch_log_msg(ARCH_LG_DEBUG, "rotation_period: '%d' seconds\n", archiever->rotation_period);
	    arch_log_msg(ARCH_LG_INFO, "registering archiever: %s\n", archiever->name);
            insert_archiever_in_list(archiever);
        }
        ;


string:
	IDENTIFIER
        |
	STRING
        ;

stringnocrlf:
	string {
	    char *str;
	    str = strpbrk($1, "\a\n\r\t\v");
	    if(str) {
		archiever_report_error("\\a\\n\\r\\t\\v characters not allowed in this string");
		free($1);
		YYABORT;
	    }
	    $$=$1;
	}
	;

skipnl:
        skipnl '\n' | /*NULL*/ ;

/* END DATA_TYPES */
%%

void
archiever_report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    archievererror(msg);
    va_end(args);
}

void archievererror(char *s)
{
    arch_log_msg(ARCH_LG_ERR, "%s:%d: ERROR: %s\n", archiever_getfilename(), archiever_getlineno(), s);
}

static void
archiever_set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	arch_log_msg(ARCH_LG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *archiever_get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
archiever_parse_conffile(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    archiever_lex_flush();

    if(archiever_include_file(conf_file) != 0) {
	arch_log_msg(ARCH_LG_CRIT, "parse_archiever_conffile: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    archiever_set_basedir(conf_file);

    /* reset the global variables */

    result = archieverparse();
    
    /* close all opened files and buffers */
    archiever_free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    arch_log_msg(ARCH_LG_INFO, "parsing successfull\n");
    /* successful parsing */
    return 0;
}
