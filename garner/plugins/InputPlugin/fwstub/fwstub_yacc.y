%{
#define _GNU_SOURCE

    #include <stdio.h>
    #include <errno.h>
    #include <string.h>
    #include <stdarg.h>

    #include "config.h"
    #include "utils.h"
    #include "fwstub_log.h"
    
    #define YYERROR_VERBOSE 1

    void fwstub_report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void fwstuberror(char *);
    extern int fwstublex(void);
    extern inline int fwstub_getlineno();
    extern inline const char* fwstub_getfilename();
    extern void fwstub_free_istack();
    extern int fwstub_include_file(const char *filename);
    extern void fwstub_lex_flush();

    /* globals - should be reset on start */
    static char *basedir=NULL;
    extern FILE *fwstubin;

    static struct _firewall_info *g_firewall = NULL;
    static struct _log_info *g_log = NULL;
    static struct _kv_info *g_kv = NULL;
    static struct _kv_rel *g_kv_rel = NULL;
    
    /* routines */
%}

%union {
    unsigned int num;
    char chr;
    char *cptr;
}

/* include */
%token KW_INCLUDE

%token KW_IPFWTYPEMAP
%token KW_IPFWTYPE
%token KW_KEYVALUE
%token KW_DELIMITER
%token KW_WORD_BOUNDRY 
%token KW_KEYVAL_SEPERATOR 
%token KW_KEYVAL_PAIR
%token KW_REGEX
%token KW_IDREGEX
%token KW_ID_MAP
%token KW_ID_MAP_KEY
%token KW_ID_MAP_VALUE

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
    ipfwmap
    keyvalues
    regexes
    ;

ipfwmap:
    KW_IPFWTYPEMAP skipnl '{' skipnl
    __ip_fwtypes
    '}'
    skipnl
    |
    ;

__ip_fwtypes:
    __ip_fwtypes
    __ip_fwtype '\n'
    skipnl
    |
    ;

__ip_fwtype:
    KW_IPFWTYPE stringnocrlf stringnocrlf stringnocrlf {
	/* allocate ip_fw_map object in hash */
    	struct _ip_fwtype_map *ip_fw_map = NULL;

	ip_fw_map = config_alloc_ip_fwtype_map();
	if(!ip_fw_map) {
            printf("ip-fwtype mapping object allocation failed\n");
            YYABORT;
        }

	strncpy(ip_fw_map->ip, $2, sizeof(ip_fw_map->ip)-1);
	printf("\tIP-FW: IP: '%s'\n", ip_fw_map->ip);

	ip_fw_map->fw_name = $3;
	printf("\tIP-FW: FW Name: '%s'\n", ip_fw_map->fw_name);

	ip_fw_map->fw_appid = $4;

	/* insert ip_fw_map object in hash */
	if(config_hash_ip_fwtype_map(ip_fw_map) < 0) {
            printf("ip-fwtype map couldn't added to ip-fwtype hash\n");
            YYABORT;
        }
    }
    ;

keyvalues:
    keyvalues
    keyvalue '\n'
    skipnl 
    |
    ;

keyvalue:
    KW_KEYVALUE IDENTIFIER {
	printf("KEY-VALUE: '%s'\n", $2);
        g_firewall = config_alloc_firewall_info();
        if(!g_firewall) {
            printf("firewall info allocation failed\n");
            YYABORT;
        }
        g_firewall->fw_name = $2;

        /* allocate keyvalue info */
	g_kv = config_alloc_kv_info();
	if(!g_kv) {
	    printf("firewall info allocation failed\n");
	    YYABORT;
        }
    }
    skipnl
    '{'
    skipnl
    __keyval_items 
    '}'
    {
	g_firewall->un.kv = g_kv;

        /* insert firewall_info */
        if(config_insert_firewall(g_firewall) < 0) {
            printf("firewall info inserted to firewall list\n");
            YYABORT;
        }
	
	/* reset globals */
	g_firewall = NULL;
	g_kv = NULL;
    }
    ;

__keyval_items:
    __keyval_items
    __keyval_item '\n'
    skipnl
    |
    ;

__keyval_item:
    KW_DELIMITER stringnocrlf {
	g_kv->delimiter = $2[0];
	free($2);
	printf("\tDELIMITER: '%c'\n", g_kv->delimiter);
    }
    |
    KW_WORD_BOUNDRY stringnocrlf {
        g_kv->wboundry = $2[0];	
	free($2);
	printf("\tWORD BOUNDRY: '%c'\n", g_kv->wboundry);
    }
    |
    KW_KEYVAL_SEPERATOR stringnocrlf {
        g_kv->kv_seperator = $2[0];	
	free($2);
	printf("\tKEYVAL SEPERATOR: '%c'\n", g_kv->kv_seperator);
    }
    |
    __kv_pair
    ;

regexes:
    regexes
    regex '\n'
    skipnl
    |
    ;
    
regex:
    KW_REGEX IDENTIFIER {
	printf("REGEX: '%s'\n",$2);
	g_firewall = config_alloc_firewall_info();
	if(!g_firewall) {
	    printf("firewall info allocation failed\n");
	    YYABORT;
        }
	g_firewall->fw_name = $2;
    }
    skipnl
    '{'
    skipnl
    __regex_items
    '}'
    {
	/* insert firewall_info */
	if(config_insert_firewall(g_firewall) < 0) {
	    printf("firewall info inserted to firewall list\n");
	    YYABORT;
	}
	g_firewall = NULL;
    }	
    ;

__regex_items:
    __regex_items
    _regex_item '\n'
    skipnl
    |
    ;

_regex_item:
    KW_IDREGEX stringnocrlf {
	if(g_firewall->fw_regex) {
	    free(g_firewall->fw_regex);
	}	   
	g_firewall->fw_regex = $2;  
	printf("\tIDREGEX: %s\n", g_firewall->fw_regex);
    }
    |
    __id_map
    ;

__id_map:
  KW_ID_MAP stringnocrlf {
	g_log = config_alloc_log_info();
	if(!g_log) {
	    printf("log_info allocation failed\n");
	    free($2);
	    YYABORT;
	}
	g_log->log_id = $2;
	printf("\tID_MAP ID: %s\n", g_log->log_id);
    }
    skipnl
    '{'
    skipnl
    __id_map_items
    '}'
    {
	/* insert log info into firewall hash */
	if(config_hash_log_info(g_firewall, g_log) < 0) { 
            printf("log info couldn't added to firewall hash\n");
            YYABORT;
        }
	g_log = NULL;
    }	
    ;

__id_map_items:
    __id_map_items
    __id_map_item '\n'
    skipnl
    |
    ;

__id_map_item:
    KW_ID_MAP_VALUE stringnocrlf {
	if(g_log->log_regex) {
	    free(g_log->log_regex);
	}
	g_log->log_regex = $2;
	printf("\tID_MAP_VALUE: %s\n", g_log->log_regex);
    }
    |
    __kv_pair
    ;

__kv_pair:
    KW_KEYVAL_PAIR stringnocrlf {
	g_kv_rel = config_alloc_kv_rel();
	if(!g_kv_rel) {
	    printf("keyvalue relation allocation failed\n");
            YYABORT;
        }
	g_kv_rel->se_var = config_get_se_var_fws_by_name($2);
	if(!g_kv_rel->se_var) {
	    printf("couldn't found '%s' in standard event\n",$2);
	    free($2);
	    YYABORT;
        }
	free($2);
	printf("\tKEYVALUE_PAIR:\n");
	printf("\t\tVALUE: '%s'\n", g_kv_rel->se_var->variable); 
    }
    __func
    {
	if(g_log) {
	    /* insert kv_rel into log_info hash */
	    if(config_hash_kv_rel_to_log(g_log, g_kv_rel) < 0) {
		printf("keyvalue relation couldn't added to log info hash\n");
		YYABORT;
	    }
        } else if(g_kv) {
            /*  insert kv_rel into keyvalue hash */
	    if(config_hash_kv_rel_to_kv(g_kv, g_kv_rel) < 0) {
		printf("keyvalue relation couldn't added to keyvalue info hash\n");
		YYABORT;
	    }
        }
	g_kv_rel = NULL;
    }	
    ;

__func:
    stringnocrlf {
        if(g_kv_rel->key) {
	    free(g_kv_rel->key);
    	}
	g_kv_rel->key = $1;
        printf("\t\tKEY: '%s'\n", g_kv_rel->key);
    }
    |
    __func_item
    ;

__func_item:
    stringnocrlf 
    {
    }
    '('
     __func
    ')'
    {
	printf("\t\tfunction name: %s\n", $1);
        if(g_kv_rel->fn_index >= g_kv_rel->fn_max) {
            if(config_realloc_conversion_fn(g_kv_rel) < 0) {
                printf("keyvalue relation function list reallocation failed\n");
                YYABORT;
            }
        }
        g_kv_rel->conversion_fn[g_kv_rel->fn_index++] = config_get_func($1);
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
			fwstub_report_error("\\a\\n\\r\\t\\v characters not allowed in this string");
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
fwstub_report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    fwstuberror(msg);
    va_end(args);
}

void fwstuberror(char *s)
{
    fwstub_log_message(FWSLG_ERR, "%s:%d: ERROR: %s\n", fwstub_getfilename(), fwstub_getlineno(), s);
}

void
fwstub_set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	fwstub_log_message(FWSLG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *fwstub_get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
fwstub_parse_conffile(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    fwstub_lex_flush();

    if(fwstub_include_file(conf_file) != 0) {
	fwstub_log_message(FWSLG_CRIT, "parse_fwstub_conffile: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    fwstub_set_basedir(conf_file);

    /* reset the global variables */
    result = fwstubparse();
    
    /* close all opened files and buffers */
    fwstub_free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    fwstub_log_message(FWSLG_INFO, "configuration file parsing successfull\n");
    /* successful parsing */
    return 0;
}
