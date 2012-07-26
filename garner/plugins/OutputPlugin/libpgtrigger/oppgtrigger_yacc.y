%{
#define _GNU_SOURCE
    
    #include <errno.h>
    #include <string.h>
    #include <stdarg.h>

    #include "config.h"
    #include "utils.h"
    
    #define YYERROR_VERBOSE 1

    void oppgtrigger_report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void oppgtriggererror(char *);
    extern int oppgtriggerlex(void);
    extern inline int oppgtrigger_getlineno();
    extern inline const char* oppgtrigger_getfilename();
    extern void oppgtrigger_free_istack();
    extern int oppgtrigger_include_file(const char *filename);
    extern void oppgtrigger_lex_flush();

    /* globals - should be reset on start */
    static char *basedir=NULL;
    extern FILE *oppgtriggerin;

    static struct _trigger *g_trigger_p = NULL;

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

/* settings */
%token KW_SETTINGS
%token KW_SERVER_ADDR
%token KW_SERVER_PORT
%token KW_CONNECT_OPTIONS
%token KW_DATABASENAME
%token KW_USERNAME
%token KW_PASSWORD
%token KW_RECONNECT_INTERVAL

/* trigger */
%token KW_TRIGGER
%token KW_QUERY

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

%start program

%%

program:
	skipnl
	settings
	triggers
	| /* NULL */
	;

settings:
	KW_SETTINGS 
	skipnl
	'{'
	__settings_info
	'}'
	skipnl
	;

__settings_info:
	__settings_info
	settings_items '\n'
	|
	;
	
settings_items:
	KW_SERVER_ADDR stringnocrlf {
		pgtrigger_config_set_server_addr($2);
	}
	|
	KW_SERVER_PORT stringnocrlf {
		pgtrigger_config_set_server_port($2);
	}
	|
	KW_CONNECT_OPTIONS stringnocrlf {
		pgtrigger_config_set_connect_options($2);
	}
	|
	KW_DATABASENAME stringnocrlf {
		pgtrigger_config_set_database_name($2);
	}
	|
	KW_USERNAME stringnocrlf {
		pgtrigger_config_set_username($2);
	}
	|
	KW_PASSWORD stringnocrlf {
		pgtrigger_config_set_password($2);
	}
	|
	KW_RECONNECT_INTERVAL NUMBER {
		pgtrigger_config_set_reconnect_interval($2);
	}
	|
	;

triggers:
	triggers
	trigger
	|
	;

trigger:
	KW_TRIGGER IDENTIFIER {
		struct _trigger *trigger;
		trigger = pgtrigger_config_new_trigger() ;
		trigger->name = $2;
		oppgtrigger_log_msg(LG_DEBUG, "new trigger allocated: %s\n", trigger->name);
				
		/* set pointer to newly allocated trigger struct to be used by subsequent parsing blocks */
		g_trigger_p = trigger;
	}
	skipnl
	'{'
	__triggerinfo
	'}'
	{
		/* insert initialized trigger struct into trigger list */
		oppgtrigger_log_msg(LG_INFO, "registering trigger: %s\n", g_trigger_p->name);
		pgtrigger_config_insert_trigger_in_list(g_trigger_p);
	}
	skipnl
	;

__triggerinfo:
	__triggerinfo
	triggeritems '\n'
	|
	;
	
triggeritems:
	/* Query <trigger query string> */
	KW_QUERY stringnocrlf {
		oppgtrigger_log_msg(LG_DEBUG, "set trigger query: %s\n", $2);
		g_trigger_p->query = $2;
		oppgtrigger_log_msg(LG_DEBUG, "trigger query: %s\n", g_trigger_p->query);
	}
	|
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
			oppgtrigger_report_error("\\a\\n\\r\\t\\v characters not allowed in this string");
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
oppgtrigger_report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    oppgtriggererror(msg);
    va_end(args);
}

void oppgtriggererror(char *s)
{
    oppgtrigger_log_msg(LG_ERR, "%s:%d: ERROR: %s\n", oppgtrigger_getfilename(), oppgtrigger_getlineno(), s);
}

void
oppgtrigger_set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	oppgtrigger_log_msg(LG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *oppgtrigger_get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
oppgtrigger_parse_conffile(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    oppgtrigger_lex_flush();

    if(oppgtrigger_include_file(conf_file) != 0) {
	oppgtrigger_log_msg(LG_CRIT, "parse_oppgtrigger_conffile: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    oppgtrigger_set_basedir(conf_file);

    /* reset the global variables */
    result = oppgtriggerparse();
    
    /* close all opened files and buffers */
    oppgtrigger_free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    oppgtrigger_log_msg(LG_INFO, "configuration file parsing successfull\n");
    /* successful parsing */
    return 0;
}
