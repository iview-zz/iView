%{
#define _GNU_SOURCE
    
    #include <errno.h>
    #include <string.h>
    #include <stdarg.h>

    #include "config.h"
    #include "utils.h"
    
    #define YYERROR_VERBOSE 1

    void oppostgres_report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void oppostgreserror(char *);
    extern int oppostgreslex(void);
    extern inline int oppostgres_getlineno();
    extern inline const char* oppostgres_getfilename();
    extern void oppostgres_free_istack();
    extern int oppostgres_include_file(const char *filename);
    extern void oppostgres_lex_flush();

    /* globals - should be reset on start */
    static char *basedir=NULL;
    extern FILE *oppostgresin;

    static struct _table *g_table_p = NULL;

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

/* tableformat */
%token KW_TABLEFORMAT

/* postgres table */
%token KW_TABLE
%token KW_CREATEQUERY 
%token KW_TBLAVAILABLE 
%token KW_TBLUSED 
%token KW_ROTATIONPERIOD
%token KW_MAXRECORDS
%token KW_MAX_UNCOMMITTED_RECORDS

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

%type <cptr>	string
%type <cptr>    stringnocrlf

%start program

%%

program:
	skipnl
	settings
	tables
	| /* NULL */
	;

settings:
	KW_SETTINGS skipnl '{'
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
	KW_SERVER_ADDR STRING {
		config_set_server_addr($2);
	}
	|
	KW_SERVER_PORT STRING {
		config_set_server_port($2);
	}
	|
	KW_CONNECT_OPTIONS STRING {
		config_set_connect_options($2);
	}
	|
	KW_DATABASENAME STRING {
		config_set_database_name($2);
	}
	|
	KW_USERNAME STRING {
		config_set_username($2);
	}
	|
	KW_PASSWORD STRING {
		config_set_password($2);
	}
	|
	KW_RECONNECT_INTERVAL NUMBER {
		config_set_reconnect_interval($2);
	}
	|
	;

tables:
	tables
	table
	|
	;

table:
	KW_TABLE IDENTIFIER {
		struct _table *table;
		table = new_table() ;
		table->name = $2;
		oppostgres_log_msg(LG_DEBUG, "new table allocated: %s\n", table->name);
				
		/* set pointer to newly allocated table struct to be used by subsequent parsing blocks */
		g_table_p = table;
	}
	skipnl
	'{'
	__tableinfo
	'}'
	{
		if(!g_table_p->createquery) {
		    oppostgres_log_msg(LG_INFO, "registering table: 'CreateQuery' not provided\n");
		    YYABORT;
		}
		if(!g_table_p->tblavailable) {
		    oppostgres_log_msg(LG_INFO, "registering table: 'TblAvailable' not provided\n");
		    YYABORT;
		}
		if(!g_table_p->tblused) {
		    oppostgres_log_msg(LG_INFO, "registering table: 'TblUsed' not provided\n");
		    YYABORT;
		}
		if(!g_table_p->tableformat) {
		    oppostgres_log_msg(LG_INFO, "registering table: 'TableFormat' not provided\n");
		    YYABORT;
		}
		/* insert initialized table struct into table list */
		oppostgres_log_msg(LG_INFO, "registering table: %s\n", g_table_p->name);
		insert_table_in_list(g_table_p);
	}
	skipnl
	;

__tableinfo:
	__tableinfo
	tableitems '\n'
	|
	;
	
tableitems:
	/* CreateQuery <create table query string> */
	KW_CREATEQUERY stringnocrlf {
		oppostgres_log_msg(LG_DEBUG, "set create table query: %s\n", $2);
		g_table_p->createquery = $2;
		oppostgres_log_msg(LG_DEBUG, "table create query: %s\n", g_table_p->createquery);
	}
	|
	/* TblAvailable <'available' queue tablename> */
	KW_TBLAVAILABLE stringnocrlf {
		oppostgres_log_msg(LG_DEBUG, "set 'available' queue tablename: %s\n", $2);
		g_table_p->tblavailable = $2;
		oppostgres_log_msg(LG_DEBUG, "'available' queue tablename: %s\n", 
							g_table_p->tblavailable);
	}
	|
	/* TblUsed <'used' queue tablename> */
	KW_TBLUSED stringnocrlf {
		oppostgres_log_msg(LG_DEBUG, "set 'used' queue tablename: %s\n", $2);
		g_table_p->tblused = $2;
		oppostgres_log_msg(LG_DEBUG, "'used' queue tablename: %s\n", g_table_p->tblused);
	}
	|
	/* TableFormat <%column-name#column-datadef%...> */
	KW_TABLEFORMAT stringnocrlf {
		oppostgres_log_msg(LG_DEBUG, "preparing table format for: %s\n", $2);
		g_table_p->tableformat = prepare_table_format($2) ;
		if(!g_table_p) {
			oppostgres_report_error("table_format string '%s' is invalid", $2);
			free($2);
			YYABORT;
		}
		free($2);
	}
	|
	/* RotatePeriod <period in second> */
	KW_ROTATIONPERIOD NUMBER {
		g_table_p->rotation_period = $2;
		oppostgres_log_msg(LG_DEBUG, "table rotation period: %d\n", g_table_p->rotation_period);
	}
	|
	/* MaxRecords <num> */
	KW_MAXRECORDS NUMBER {
		g_table_p->max_records = $2;
		oppostgres_log_msg(LG_DEBUG, "table max records: %d\n", g_table_p->max_records);
	}
	|
	/* MaxUncommittedRecords <num> */
	KW_MAX_UNCOMMITTED_RECORDS NUMBER {
		g_table_p->max_uncommitted_records = $2;
		oppostgres_log_msg(LG_DEBUG, "table max uncommitted records: %d\n", g_table_p->max_uncommitted_records);
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
			oppostgres_report_error("\\a\\n\\r\\t\\v characters not allowed in this string");
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
oppostgres_report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    oppostgreserror(msg);
    va_end(args);
}

void oppostgreserror(char *s)
{
    oppostgres_log_msg(LG_ERR, "%s:%d: ERROR: %s\n", oppostgres_getfilename(), oppostgres_getlineno(), s);
}

void
oppostgres_set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	oppostgres_log_msg(LG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *oppostgres_get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
oppostgres_parse_conffile(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    oppostgres_lex_flush();

    if(oppostgres_include_file(conf_file) != 0) {
	oppostgres_log_msg(LG_CRIT, "parse_oppostgres_conffile: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    oppostgres_set_basedir(conf_file);

    /* reset the global variables */
    result = oppostgresparse();
    
    /* close all opened files and buffers */
    oppostgres_free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    oppostgres_log_msg(LG_INFO, "configuration file parsing successfull\n");
    /* successful parsing */
    return 0;
}
