/* ***********************************************************************
*  Cyberoam iView - The Intelligent logging and reporting solution that 
*  provides network visibility for security, regulatory compliance and 
*  data confidentiality 
*  Copyright  (C ) 2009  Elitecore Technologies Ltd.
*  
*  This program is free software: you can redistribute it and/or modify 
*  it under the terms of the GNU General Public License as published by 
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful, but 
*  WITHOUT ANY WARRANTY; without even the implied warranty of 
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
*  General Public License for more details.
*  
*  You should have received a copy of the GNU General Public License 
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*  
*  The interactive user interfaces in modified source and object code 
*  versions of this program must display Appropriate Legal Notices, as 
*  required under Section 5 of the GNU General Public License version 3.
*  
*  In accordance with Section 7(b) of the GNU General Public License 
*  version 3, these Appropriate Legal Notices must retain the display of
*   the "Cyberoam Elitecore Technologies Initiative" logo.
*************************************************************************/

/* garner.h
 *
 * Author:	Vinod Patel <vinod@elitecore.com>
 */

#ifndef _GARNER_H_
#define _GARNER_H_

#ifndef O_TEXT
#define O_TEXT 0
#endif
#ifndef O_BINARY
#define O_BINARY 0
#endif

#define N_UDP 0
#define N_TCP 1

#include "common.h"
#include "std_event_private.h"
#include "log.h"

#define KL(s) (sizeof(s)-1)

#define safecalloc(x, y) calloc(x, y)
#define safemalloc(x) malloc(x)
#define saferealloc(x, y) realloc(x, y)
#define safefree(x) do { \
	typeof(x) *__safefree_tmp = (&(x)); \
	free(*__safefree_tmp); \
	*__safefree_tmp = NULL; \
    } while (0)
#define safestrdup(x) strdup(x)

/* we need everyone to use xasert instead */
#pragma GCC poison assert

void garner_assert(const char *msg, const char *file, int line);
void garner_exit(const char *msg, const char *file, int line);
#define xassert(EX)  ((EX)?((void)0):garner_assert(#EX, __FILE__, __LINE__))
#define xexit(EX)  garner_exit(EX, __FILE__, __LINE__)

#define RETURN(x) { ret = (x); goto cleanup;}

#define SOCKFAMILY_NAMED_UNIX   0
#define SOCKFAMILY_ABS_UNIX     1       /* abstract nameless unix socket */
#define SOCKFAMILY_INET         2

/* The full and simple forms of the name with which the program was
 * invoked.  These variables are set up automatically at startup based on
 * the value of ARGV[0] (this works only if you use GNU ld).
 */

#ifdef _ENABLE_CYGWIN

#define appname "garner"

#else	/* _ENABLE_CYGWIN */

extern char *program_invocation_short_name;
/* just to make it short */
#define appname program_invocation_short_name

#endif /* _ENABLE_CYGWIN */

/* compare returns 0 if condition is true
 *                      non-zero if condition is false
 * compare should be called with std_event and corresponding argument
 */
typedef int (CONDITIONCHECK)(void*, void *arg, char op);
typedef void (CONDITIONFREE)(void *arg);

typedef enum {
    ACTION,
    CONDITION,
} act_cond_t;

struct _callback {
    CONDITIONCHECK *routine;
    CONDITIONFREE *free;
    void *data;
    char cbop;
};

struct _exprnode {
    char op;
    struct _callback callback;
    struct _exprnode *left;
    struct _exprnode *right;
};

typedef enum {
    ACTION_CALL,
    ACTION_RETURN,
    ACTION_MAX
} action_t;


/*
 * Hold all the configuration time information.
 */
struct config_s {
    struct _daemon {
	char *pid_file;
	char *log_file;
	char *config_file;
	char uniquetag[32];
	union {
	    struct {
		uint8_t alarm:1;
		uint8_t quit:1;
		uint8_t reconfig:1;
		uint8_t toggle_log:1;
	    };
	    u_int8_t sig;
	};
	u_int8_t enable_coredump:1; /* boolean */
	u_int8_t test_plugin:1; /* init and close method of the plugin will be called if this flag is set */
	char *username;
	char *group;
	uid_t effectiveUserID;
	gid_t effectiveGroupID;
	struct _std_event *searray;
	u_int32_t searray_initial_len;	/* initial length of searray */
	u_int32_t searray_delta;	/* searray len += delta */
	u_int32_t iobuffersize;
	struct timeval rwtimeout;	/* read write timeout in miliseconds */
    } daemon;

    int ep_fd;

    struct {
	int listen_fd;
	u_int32_t sockettype:16;
        u_int32_t addrfamily:16;
	char *socketpath;
    } network[2];

    struct _input_plugin {
	union {
            char *ident;
            int   src_port; /* in udp case we identify ident by the source port */
        };
	char *library;
	char *libprefix;
	char *argstring;
	void *dlhandle;
	int (*libname_init)(const char *, u_int32_t, void **);
	void (*libname_close)(void *);
	int (*libname_input)(const u_int8_t *, u_int32_t , struct _std_event *, u_int32_t nse, void *);
	void (*libname_debug)(void *);
	struct _input_plugin *next;
    } *input_list, *input_udp_list;

    struct _output_plugin {
	char *opname;
	char *library;
	char *libprefix;
	char *argstring;
	void *dlhandle;
	void *plugin_handle;
	int (*libname_init)(const char *, u_int32_t, void **);
	void (*libname_close)(void *);
	void (*libname_output)(struct _std_event *, u_int32_t nse, struct _output_data**, void *);
	void (*libname_event)(void *);
	void (*libname_debug)(void *);
	struct _output_plugin *next;
    } *output_list;

    struct _event {
	pthread_t tid;	/* thread id of clock event thread */
	u_int32_t clock_period;	/* clock period (in second) for clock event thread */
	union {
	    struct {
		int read_fd;
		int write_fd;	
	    };
	    int pipefd[2];
	};
    } event;

    /* to hold clock event consumer information */
    struct _event_consumer {
	int event_skipcount;	/* mutiple of garner's base clock period */
	int event_count;		/* clock event counter */
	struct _output_plugin *output;	/* clock event consumer plugin */
	struct _event_consumer *next;	
    } *event_consumer_list;

    struct _act_cond {
	act_cond_t type;
	union {
	    struct _action {
		action_t type;
		void *args;
	    } action;
	    struct _condition {
		struct _exprnode *exprnode;
		/* if the condition is true */
		struct _act_cond *child_ac_list;
	    } condition;
	} un;
	struct _act_cond *next;
    } *ac_list;
};

/* Global Structures used in the program */
extern struct config_s config;

void fatal(const char *message);
void fatalf(const char *fmt,...);

void enter_suid(void);
void leave_suid(void);

extern int parse_conf_file(const char *conf_file);

void free_exprnode(struct _exprnode *node);
void free_act_cond(struct _act_cond *list);
void free_condition(struct _condition *condition);

struct _exprnode* new_exprnode(char op);
struct _act_cond* new_act_cond();

const char *mybasename(const char *path);

void unload_input_library(struct _input_plugin *input);
int load_input_library(struct _input_plugin *input);
void unload_output_library(struct _output_plugin *output);
int load_output_library(struct _output_plugin *output);


void free_input_plugin(struct _input_plugin *list);
void free_output_plugin(struct _output_plugin *list);

#endif
