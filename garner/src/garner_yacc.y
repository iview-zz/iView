%{
    #include <stdio.h>
    #include <netdb.h>
    #include <errno.h>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <sys/types.h>
    #include <string.h>
    #include <stdlib.h>
    #include "garner.h"
    #include "log.h"
    
    #define YYERROR_VERBOSE 1

    void report_error(char *fmt, ...) __attribute__((format(printf, 1, 2)));
    void garnererror(char *);
    extern int garnerlex(void);
    extern inline int getlineno();
    extern inline const char* getfilename();
    extern void free_istack();
    extern int include_file(const char *filename);
    extern void lex_flush();
    static struct _act_cond *prepare_ac_list(struct _act_cond *, struct _act_cond *);
    static int fill_network_items(const int socktype, char *sockpath);
    static void insert_node_in_udplist(struct _input_plugin *node);

    /* globals - should be reset on start */
    static char *basedir=NULL;

    extern FILE *garnerin;

    /* routines */
%}

%union {
    unsigned int num;
    char chr;
    char *cptr;
    struct _exprnode *node;
    struct _act_cond *actcond;
}

/* daemon */
%token KW_DAEMON KW_LOGFILE KW_LOGLEVEL KW_USER KW_GROUP
%token KW_IOBUFFERSIZE KW_SEARRAY KW_ENABLECORE KW_RWTIMEOUT

/* network */
%token KW_NETWORK KW_SOCKET KW_UDP KW_TCP

/* input */
%token KW_INPUT KW_INPUTPLUGIN

/* output */
%token KW_OUTPUT KW_OUTPUTPLUGIN
%token KW_IF
%token KW_NULL

/* conditions */
%token KW_EVENT KW_CLOCKPERIOD KW_EVENTCONSUMER

/* conditions */
%token KW_CONDITIONS KW_CALL KW_RETURN

/* include */
%token KW_INCLUDE

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
%type <cptr>    optstring
%type <actcond> conditionalactions
%type <actcond> __conditions
%type <actcond> __conditionalactions
%type <node>    expression
%type <node>    comparison
%type <chr>	EQNEQLTGT
%type <chr>	EQNEQ
%type <chr>	LTGT
%type <num>     __socktype

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
	daemon
	|
	network  
	|
	input
	|
	output
	|
	event
	|
	conditions
	;

/* DAEMON */
daemon:
	KW_DAEMON
	skipnl
	'{'
	__daemon
	'}'
	;

__daemon:
	__daemon
	daemonitems '\n'
	|
	;

daemonitems:
	KW_LOGFILE string {
	    log_message(LG_INFO, "deamon.logfile: %s\n", $2);
	    config.daemon.log_file = $2;
	}
	|
	KW_LOGLEVEL IDENTIFIER {
	    log_message(LG_INFO, "deamon.loglevel: %s\n", $2);
	    set_log_level(get_log_level_from_string($2));
	    free($2);
	}
	|
	KW_USER IDENTIFIER {
	    log_message(LG_INFO, "daemon.username: %s\n", $2);
	    config.daemon.username = $2;
	}
	|
	KW_GROUP IDENTIFIER {
	    log_message(LG_INFO, "daemon.group: %s\n", $2);
	    config.daemon.group = $2;
	}
	|
	KW_SEARRAY NUMBER NUMBER {
	    log_message(LG_INFO, "daemon.searray_initial_size: %d,"\
			"daemon.searray_delta: %d\n", $2, $3);
	    config.daemon.searray_initial_len = $2;
	    config.daemon.searray_delta = $3;
	}
	|
	KW_IOBUFFERSIZE NUMBER {
	    log_message(LG_INFO, "daemon.iobuffersize: %d\n", $2);
	    config.daemon.iobuffersize = $2;
	}
	|
	KW_ENABLECORE NUMBER {
	    log_message(LG_INFO, "daemon.enable_coredump: %d\n", $2);
	    config.daemon.enable_coredump = $2;
	}
	|
	KW_RWTIMEOUT NUMBER {
	    if($2 > 0) {
		u_int32_t mili, micro, seconds;
		mili = $2;
	        seconds = mili/1000;
	        mili -= (seconds * 1000);
	        micro = mili*1000;
		config.daemon.rwtimeout.tv_sec = seconds;
		config.daemon.rwtimeout.tv_usec = micro;
		log_message(LG_INFO, "daemon.rwtimeout: %u seconds, %u miliseconds\n", seconds, micro);
	    }
	}
	|
	;
/* END DAEMON */

/* NETWORK */
network:
	KW_NETWORK
	skipnl
	'{'
	__network
	'}'
	;

__network:
	__network
	networkitems '\n'
	|
	;

networkitems:
        KW_SOCKET __socktype string {
            log_message(LG_INFO, "socket-type: %d socket-path: %s\n", $2, $3);
            fill_network_items($2, $3);
            //config.network.sockettype = $2;
            //config.network.socketpath = $3;
        }
        |
        ;

__socktype:
        KW_UDP {$$=N_UDP;}
        |
        KW_TCP {$$=N_TCP;}
        | /* NULL */ { $$=N_TCP;}
        ;
/* END NETWORK */

/* INPUT */
input:
	KW_INPUT
	skipnl
	'{'
	__input
	'}'
	;

__input:
	__input
	inputitems '\n'
	|
	;

inputitems:
	/* InputPlugin <ident>    <libpath>  <prefix> <args> */
	KW_INPUTPLUGIN IDENTIFIER IDENTIFIER string optstring {
	    struct _input_plugin **list, *input;

	    input = calloc(1, sizeof(struct _input_plugin));
	    input->ident = $2;
	    input->library = $3;
	    input->libprefix = $4;
	    input->argstring = $5;
	    if(load_input_library(input) != 0) {
		report_error("Invalid InputPlugin: %s\n", $2);
		/* strings are freed along with library */
		free_input_plugin(input);
		YYABORT;
	    }
	    for(list = &config.input_list; (*list); list=&(*list)->next);
	    (*list) = input;
	}
	|
	KW_INPUTPLUGIN KW_UDP ':' NUMBER IDENTIFIER string optstring {
            struct _input_plugin *input;
            void *handle;

            input = calloc(1, sizeof(struct _input_plugin));
            input->src_port = $4;
            input->library = $5;
            input->libprefix = $6;
            input->argstring = $7;
            if(load_input_library(input) != 0) {
                report_error("Invalid InputPlugin: %d\n", input->src_port);
                /* strings are freed along with library */
                free_input_plugin(input);
                YYABORT;
            }
            /* in udp case: we init the plugin at this stage */
            if(input->libname_init(input->argstring, STD_EVENT_VERSION, &handle) != 0) {
                log_message(LG_ERR, "%s: %s: failed\n", input->library, "libinit");
                unload_input_library(input);
                YYABORT;
            }
            insert_node_in_udplist(input);
        }
        |
        ;

/* END INPUT */

/* OUTPUT */
output:
	KW_OUTPUT
	skipnl
	'{'
	__output
	'}'
	;

__output:
	__output
	outputitems '\n'
	|
	;

outputitems:
	/* OutputPlugin <ident>    <libpath>  <prefix> <args> */
	KW_OUTPUTPLUGIN IDENTIFIER IDENTIFIER string optstring {
	    struct _output_plugin **list, *output;

	    output = calloc(1, sizeof(struct _output_plugin));
	    output->opname = $2;
	    output->library = $3;
	    output->libprefix = $4;
	    output->argstring = $5;
	    if(load_output_library(output) != 0) {
		report_error("Invalid outputplugin: %s\n", $2);
		/* strings are freed with output */
		free_output_plugin(output);
		YYABORT;
	    }

	    for(list = &config.output_list; (*list); list=&(*list)->next);
	    (*list) = output;
	}
	|
	;

/* EVENT */
event:
    KW_EVENT
    skipnl
    '{'
    __event
    '}'
    ;

__event:
    __event
    eventitems '\n'
    |
    ;

eventitems:
    /* ClockPeriod <period(in second)> */
    KW_CLOCKPERIOD	NUMBER {
	config.event.clock_period = $2;
    }
    |
    /* EventReceiver <OutputPlugin-ident> <event-interval> */
    KW_EVENTCONSUMER IDENTIFIER NUMBER {
	struct _event_consumer	**list, *event_con;
	struct _output_plugin *op;
		
	/* get output plugin by name */
        for(op=config.output_list; op; op=op->next) {
	    if(strcasecmp(op->opname, $2) == 0) {
	    break;
        }
    }
    if(!op) {
        report_error("OutputPlugin named '%s' is not declared in Output block\n", $2);
	free($2);
        YYABORT;
    }

    event_con = calloc(1, sizeof(struct _event_consumer));
    event_con->output = op;

    /* 
     *	initialize number of clock events to be skipped before sent event to consumer. 
     * 	in other words it is multiple of garner's base clock period. 
     * 	value will be rounded DOWN in case it is not an exact multiple.
     */		
    event_con->event_skipcount = $3/(config.event.clock_period) ;
    for(list = &(config.event_consumer_list); (*list); list=&(*list)->next);
        (*list) = event_con;
    }
    |
    ;

/* END EVENT */

/* CONDITIONS */
conditions:
	KW_CONDITIONS
	skipnl
	'{'
	__conditionalactions {
	    config.ac_list = $4;
	}
	'}'
	;

conditionalactions:
	KW_CALL IDENTIFIER '\n' {
	    struct _act_cond *ac;
	    struct _output_plugin *op;
	    for(op=config.output_list; op; op=op->next) {
		if(strcasecmp(op->opname, $2) == 0) {
		    break;
		}
	    }
	    if(!op) {
		report_error("OutputPlugin named '%s' is not declared in Output block\n", $2);
		free($2);
		YYABORT;
	    }
	    ac = new_act_cond();
	    ac->type = ACTION;
	    ac->un.action.type = ACTION_CALL;
	    ac->un.action.args = op;
	    $$ = ac;
	}
	|
	KW_RETURN '\n' {
	    struct _act_cond *ac;
	    ac = new_act_cond();
	    ac->type = ACTION;
	    ac->un.action.type = ACTION_RETURN;
	    ac->un.action.args = NULL;
	    $$ = ac;
	}
	|
	__conditions {
	    $$ = $1;
	}
	|
	'\n' {
	    $$ = NULL;
	}
	;

__conditions:
	KW_IF {
	    log_message(LG_INFO, "if statement start\n");
	}
	'(' expression ')' skipnl '{' __conditionalactions '}' {
	    struct _act_cond *ac;
	    if($8 == NULL) {
		/* i cannot allow no-actions in conditional block */
		report_error("'Condition' block cannot be empty. Atleast one action/condition expected.");
		free_exprnode($4);
		free_act_cond($8);
		YYABORT;
	    }

	    ac = new_act_cond();
	    ac->type = CONDITION;
	    ac->un.condition.exprnode = $4;
	    ac->un.condition.child_ac_list = $8;
	    log_message(LG_INFO, "if statement over\n");
	    $$ = ac;
	}
	;

__conditionalactions:
	__conditionalactions conditionalactions {
	    $$ = prepare_ac_list($1, $2);
	}
	| {
	    $$ = NULL;
	}
	;

expression:
	comparison                      {
					$$ = $1;
					}
	| expression '|' expression
					{
					struct _exprnode *node;
					node = new_exprnode('|');
					node->left = (struct _exprnode *) $1;
					node->right = (struct _exprnode *) $3;
					$$ = node;
					}
	| expression '&' expression
					{
					struct _exprnode *node;
					node = new_exprnode('&');
					node->left = (struct _exprnode *) $1;
					node->right = (struct _exprnode *) $3;
					$$ = node;
					}
	| '!' expression
					{
					struct _exprnode *node;
					node = new_exprnode('!');
					node->left = (struct _exprnode *) $2;
					$$ = node;
					}
	| '(' expression ')'            { $$ = $2; }
	;

comparison:
	IDENTIFIER EQNEQLTGT string {
	    struct _exprnode *node;
	    const struct _std_event_vars *sev;

	    log_message(LG_INFO, "comparison: ( %s %c %s )\n", $1, $2, $3);

	    sev = get_var_by_name($1);
	    if(!sev) {
		report_error("variable '%s' is not a member of struct std_event\n", $1);
		free($1);
		free($3);
		YYABORT;
	    }

	    node = new_exprnode(0);
	    node->callback.routine = compare_std_event_var;
	    node->callback.free = free_sev_data;
	    node->callback.data = new_sev_data(sev, $3);
	    node->callback.cbop = $2;
	    if(!node->callback.data) {
		report_error("Type Mismatch : Could not convert '%s' to '%s'\n", $3, sev->type);
		free($1);
		free($3);
		free_exprnode(node);
		YYABORT;
	    }

	    $$ = node;
	    free($1);
	    free($3);
	}
	;


EQNEQLTGT:
	EQNEQ
	|
	LTGT
	;

EQNEQ:
	'=' {
	    $$ = '=';
	}
	|
	'!' '=' {
	    $$ = '!';
	}
	|
	'=' '=' {
	    $$ = '=';
	}
	;

LTGT:
	'<' {
	    $$ = '<';
	}
	|
	'>' {
	    $$ = '>';
	}
	;

/* END CONDITIONS */

string:
	IDENTIFIER
        |
	STRING
        ;

optstring:
	string {
	    $$ = $1;
	}
	| {
	    $$ = NULL;
	}
	;

skipnl:
        skipnl '\n' | /*NULL*/ ;

/* END DATA_TYPES */
%%

static struct _act_cond *
prepare_ac_list(struct _act_cond *d1, struct _act_cond *d2)
{
    struct _act_cond *prev, *new;
    new = d2;
    prev = d1;
    if(new) {
	/* we have non-null new act_cond */
	if(prev) {
	    struct _act_cond *ac_list;
	    /* there are previous list, append new to the list */
	    for(ac_list=prev; ac_list->next; ac_list=ac_list->next);
	    ac_list->next = new;
	    /* return the previous */
	    return prev;
	} else {
	    /* no previous stuff, this is the start os chain */
	    return new;
	}
    } else {
	/* new is null, return prev */
	return prev;
    }
}

void
report_error(char *fmt, ...)
{   
    va_list args;
    char msg[1024];
    va_start(args, fmt);
    vsnprintf(msg, 1024, fmt, args);
    garnererror(msg);
    va_end(args);
}

void garnererror(char *s)
{
    log_message(LG_ERR, "%s:%d: ERROR: %s\n", getfilename(), getlineno(), s);
}

void
set_basedir(const char *filename)
{
    char *str;

    xassert(basedir == NULL);
    xassert(filename != NULL);

    str = strrchr(filename, '/');
    if(str) {
	basedir = strndup(filename, (str-filename));
	log_message(LG_INFO, "basedir = '%s'\n", basedir);
    }
}

inline const char *get_basedir()
{
    return (basedir) ? basedir : ".";
}

int
parse_conf_file(const char *conf_file)
{
    int result;

    xassert(conf_file != NULL);

    /* just to assure that every thing is sane */
    lex_flush();

    if(include_file(conf_file) != 0) {
	log_message(LG_CRIT, "parse_conf_file: %s - %s\n", conf_file, strerror(errno));
	return -1;
    }

    set_basedir(conf_file);

    /* reset the global variables */

    result = garnerparse();
    
    /* close all opened files and buffers */
    free_istack();

    free(basedir);
    basedir = NULL;

    if(result) {
	/* parsing errors */
	return -1;
    }
    log_message(LG_INFO, "parsing successfull\n");
    printf ("printing udp input list \n");
    struct _input_plugin *index = config.input_udp_list;
    for (; index; index=index->next){
        printf (" '%d' ", index->src_port);
    }
    printf ("\n");

    /* successful parsing */
    return 0;
}

static int
fill_network_items(const int socktype, char *sockpath)
{
    xassert (socktype == N_TCP || socktype == N_UDP);
    xassert (sockpath != NULL);

    if (config.network[socktype].socketpath) {
        log_message (LG_ERR, "Sockettype %s is already defined previous "
                     "path is '%s'\n", (socktype==N_TCP?"tcp":"udp"),
                     config.network[socktype].socketpath);
        return -1;
    }
    config.network[socktype].socketpath = sockpath;
    config.network[socktype].sockettype = socktype;

    if (strchr(sockpath, ':') == NULL) {
        config.network[socktype].addrfamily = AF_UNIX;
    } else {
        config.network[socktype].addrfamily = AF_INET;
    }
    return 0;
}

static void
insert_node_in_udplist(struct _input_plugin *node)
{
    struct _input_plugin **base = &config.input_udp_list;
    struct _input_plugin *backup = NULL;

    if (!(*base)) {
        *base = node;
        return;
    }

    for (; (*base); base = &(*base)->next) {
        if(node->src_port < (*base)->src_port) {
            node->next = (*base);
            if (backup) {
                backup->next = node;
            } else {
                *base = node;
            }
            break;
        }
        backup = (*base);
    }
    if ( (*base) == NULL) {
        backup->next = node;
    }
}
