%{
#define _GNU_SOURCE

    #include <errno.h>
    #include <stdarg.h>

    #include "utils.h"
    #include "format.h"

    #define YYERROR_VERBOSE 1

    void resolver_report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void resolvererror(char *);
    extern int resolverlex(void);
    extern inline int resolver_getlineno();
    extern inline const char* resolver_getfilename();
    extern void resolver_free_istack();
    extern int resolver_include_file(const char *filename);
    extern void resolver_lex_flush();

    /* globals - should be reset on start */
    static char *basedir=NULL;
    
    extern FILE *resolverin;

    static struct _resolver *g_resolver_p = NULL;

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


%token KW_RESOLVER
%token KW_TABLE_INFO
%token KW_KEY_FIELD
%token KW_VALUE_FIELD

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
%type <cptr>    	databasename
%type <cptr>    	tablename

%start program

%%

program:
	program 
	resolvers
	| /* NULL */
	;

resolvers:
	'\n'
	|
	resolver
	;

resolver:
	KW_RESOLVER IDENTIFIER {
		struct _resolver *resolver;
		resolver = new_resolver() ;
		resolver->name = $2;
		resolver_log_message(RLG_DEBUG, "new resolver allocated: %s\n", resolver->name);
				
		/* set pointer to newly allocated resolver struct to be used by subsequent parsing blocks */
		g_resolver_p = resolver;
	}
	skipnl
	'{'
	__resolverinfo
	'}'
	{
	        if (!g_resolver_p->key_format || !g_resolver_p->value_format) {
		    resolver_report_error("Error: Missing Key field or Value field for resolver %s",
									        g_resolver_p->name);
		    free_resolver(&g_resolver_p);
		    resolver_cleanup_parsed_state();
		    YYABORT;
		}

		/* insert initialized resolver struct into resolver list */
		resolver_log_message(RLG_INFO, "registering resolver: %s\n", g_resolver_p->name);
		insert_resolver_in_list(g_resolver_p);
	}
	;

__resolverinfo:
	__resolverinfo
	resolveritems '\n' 
	|
	;
	
resolveritems:
	/* Table Information <%database_name%table_name%> */
	KW_TABLE_INFO databasename tablename {
            resolver_log_message(RLG_DEBUG, "set table & database information. %s.%s\n", $2, $3);
	    g_resolver_p->database_name = $2;
	    g_resolver_p->table_name = $3;
	}
	|
	/* Key Field <%column-name#column-datadef%...> */
	KW_KEY_FIELD stringnocrlf {
            resolver_log_message(RLG_DEBUG, "preparing key field format for: %s\n", $2);
            g_resolver_p->key_format = prepare_field_format($2) ;
            if(!g_resolver_p->key_format) {
                resolver_report_error("resolver_format string '%s' is invalid", $2);
                free($2);
		free_resolver(&g_resolver_p);
		resolver_cleanup_parsed_state();
                YYABORT;
            }
            free($2);
	}
	|
	/* Value Field <%column-name#column-datadef%...> */
	KW_VALUE_FIELD stringnocrlf {
            resolver_log_message(RLG_DEBUG, "preparing value field format for: %s\n", $2);
            g_resolver_p->value_format = prepare_field_format($2) ;
            if(!g_resolver_p->value_format) {
                resolver_report_error("resolver_format string '%s' is invalid", $2);
                free($2);
                free_resolver(&g_resolver_p);
		resolver_cleanup_parsed_state();
                YYABORT;
            }
            free($2);
	}
	|
	;

databasename:
        STRING 
	;
tablename:
        STRING 
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
                resolver_report_error("\\a\\n\\r\\t\\v characters not allowed in this string");
		free($1);
		free_resolver(&g_resolver_p);
		resolver_cleanup_parsed_state();
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
resolver_report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    resolvererror(msg);
    va_end(args);
}

void resolvererror(char *s)
{
    resolver_log_message(RLG_ERR, 
    	"%s:%d: ERROR: %s\n", resolver_getfilename(), resolver_getlineno(), s);
}

void
resolver_set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	resolver_log_message(RLG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *resolver_get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
resolver_parse_conffile(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    resolver_lex_flush();

    if(resolver_include_file(conf_file) != 0) {
	resolver_log_message(RLG_CRIT, 
		"parse_resolver_conffile: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    resolver_set_basedir(conf_file);

#if 0
//    conn = init_mysql_client(host, user, pass);
    g_conn_handle = pg_server_connect(host, NULL, NULL, user, pass);
    if (g_conn_handle == NULL) {
	resolver_log_message(RLG_CRIT, "Could not connect to PostgreSQL Server\n");
	return -1;
    }
    /* reset the global variables */
#endif
    result = resolverparse();
    
    /* close all opened files and buffers */

#if 0
    if (g_conn_handle) {
	resolver_log_message(RLG_INFO, "Connection close with Mysql.\n");
	pg_server_disconnect(g_conn_handle);
    }
#endif
    resolver_free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    resolver_log_message(RLG_INFO, "parsing successfull\n");
    /* successful parsing */
    return 0;
}
