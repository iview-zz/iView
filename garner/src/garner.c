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

/*
 * GARNER: Log collection daemon
 *
 * The initialize routine. Basically sets up all the initial stuff (logfile,
 * listening socket, config options, etc.) and then sits there and loops
 * over the new connections until the daemon is closed. Also has additional
 * functions to handle the "user friendly" aspects of a program (usage,
 * stats, etc.) Like any good program, most of the work is actually done
 * elsewhere.
 *
 * Lost! Start from main routine.
 */

#include <stdio.h>
#include <sysexits.h>
#include <unistd.h>
#include <signal.h>
#include <syslog.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <dlfcn.h>
#include <pthread.h>

#ifndef _ENABLE_CYGWIN

#include <linux/version.h>
#include <gnu/libc-version.h>

#endif /* _ENABLE_CYGWIN */


#ifdef _ENABLE_BT
#include <bt.h>
#endif /* _ENABLE_BT */

//--#include <svc.h>

#include "garner.h"
#include "log.h"
#include "utils.h"

struct _fd_pool{
    struct _fd_data **fd_list;
    int tot_fds;
};
static struct _fd_pool fd_pool;

#define UDP_BUF_SIZE 1024*2

/*
 * Extern stuff
 */
extern int yyparse(void);
extern FILE *yyin;

/*
 * Global Structures
 */
struct config_s config;
int max_fd = 0 ;

/*
 * Display the version information for the user.
 */
static void
display_version(void)
{
    printf("%s %s (%s)\n", PACKAGE, VERSION, TARGET_SYSTEM);
}

/*
 * Display usage to the user.
 */
static void
display_usage(void)
{
    printf("Usage: %s [options]\n", PACKAGE);
    printf("\
        Options:\n\
	-k shutdown|debug|kill|reconfig\n\
		 shutdown - Shutdown Garner.\n\
		 debug - Toggle DEBUG mode.\n\
		 kill - Kill garner immediately.\n\
		 reconfig - Reinitialize the configuration\n\
	-c FILE	 Use an alternate configuration file.(default is '%s')\n\
	-l FILE	 Use an alternate log file.(default is '%s')\n\
	-p FILE	 Use an alternate pid file.(default is '%s')\n\
	-h	 Display this usage information.\n\
	-L number Set the initial log level(%d-%d).\n\
	-n	 Do not make daemon.\n\
	-s \"name=value\" Set the value of a variable. Only one variable can be set in a single run.\n\
		 At present, following variables are available:\n\
		    Loglevel={debug|info|notice|error|critical}\n\
		    Timeout=<seconds>\n\
	-u string Unique tag to identify this instance of garner\n\
	-t	 Truncate log file before starting daemon\n\
	-v	 Display the version number.\n",
		 DEFAULT_CONF_FILE, DEFAULT_LOG_FILE, DEFAULT_PID_FILE,
		 LG_MSG, LG_MAX);

}

/* leave a privilegied section. (Give up any privilegies)
 * Routines that need privilegies can rap themselves in enter_suid()
 * and leave_suid()
 * To give upp all posibilites to gain privilegies use no_suid()
 */
void
leave_suid(void)
{
    if (geteuid() != 0)
	return;
    /* Started as a root, check suid option */
    if (config.daemon.username == NULL)
	return;
    if (config.daemon.group) {
	if(setegid(config.daemon.effectiveGroupID) < 0) {
	    log_message(LG_ERR, "ALERT: setegid: %s\n", strerror(errno));
	}
    }

    log_message(LG_DEBUG, "leave_suid: PID %d giving up root, becoming '%s'\n",
						(int) getpid(), config.daemon.username);
    if (seteuid(config.daemon.effectiveUserID) < 0) {
	log_message(LG_ERR, "ALERT: seteuid: %s\n", strerror(errno));
    }
}


/* Enter a privilegied section */
void
enter_suid(void)
{
    log_message(LG_DEBUG, "enter_suid: PID %d taking root priveleges\n", (int) getpid());
    if(seteuid(0)==-1) {
	log_message(LG_ERR, "enter_suid: PID %d could not "\
				  "take root priveleges - %s\n", (int) getpid(), strerror(errno));
    }
}

/* Give up the posibility to gain privilegies.
 * this should be used before starting a sub process
 */
void
no_suid(void)
{
    uid_t uid;
    leave_suid();
    uid = geteuid();
    log_message(LG_DEBUG, "leave_suid: PID %d giving up root priveleges forever\n", (int) getpid());
#if HAVE_SETRESUID
    if (setresuid(uid, uid, uid) < 0) {
	log_message(LG_ERR, "no_suid: setresuid: %s\n", strerror(errno));
    }
#else
    setuid(0);
    if (setuid(uid) < 0) {
	log_message(LG_ERR, "no_suid: setuid: %s\n", strerror(errno));
    }
#endif
}

/* fatal */
void
fatal(const char *message)
{
    openlog(appname, LOG_PID | LOG_NDELAY | LOG_CONS, LOG_LOCAL4);
    syslog(LOG_NOTICE, "FATAL: %s", message);
    log_message(LG_CRIT, "FATAL: %s", message);
    closelog();
    exit(-1);
}

void
fatalf(const char *fmt,...)
{
    va_list args;
    static char fatal_str[1024];

    va_start(args, fmt);
    vsnprintf(fatal_str, sizeof(fatal_str), fmt, args);
    va_end(args);
    fatal(fatal_str);
}

const char *
mybasename(const char *path)
{
    const char *foo;

    if(path) {
        foo = strrchr(path, '/');
        if(foo) {
            return ++foo;
        }
    }
    return path;
}

/*
 * Fork a child process and then kill the parent so make the calling
 * program a daemon process.
 */
int make_daemon(void)
{
    pid_t p;
    p = fork();
    if (p < 0) {
	return -1;
    } else if (p > 0) {
	exit(0);
    }
    /* child (daemon) continues */
    setsid(); /* obtain a new process group */
    /*for (p=getdtablesize();p>=0;--p) close(p);*/ /* close all descriptors */
    close(0);close(1);close(2);
    p=open("/dev/null",O_RDWR); dup(p); dup(p); /* handle standard I/O */
    chdir("/tmp");
    umask(022);
    return  0;
}

static pid_t
readPidFile(void)
{
    FILE *pid_fp = NULL;
    const char *f = config.daemon.pid_file;
    pid_t pid = -1;
    int i;

    if (f == NULL) {
	fprintf(stderr, "%s: ERROR: No pid file name defined\n", appname);
	exit(1);
    }
    pid_fp = fopen(f, "r");
    if (pid_fp != NULL) {
	pid = 0;
	if (fscanf(pid_fp, "%d", &i) == 1) {
		pid = (pid_t) i;
	}
	fclose(pid_fp);
    } else {
	if (errno != ENOENT) {
	    fprintf(stderr, "%s: ERROR: Could not read pid file\n", appname);
	    fprintf(stderr, "\t%s: %s\n", f, strerror(errno));
	    exit(1);
	}
    }
    return pid;
}

/* returns 1 if same process name is already running on this pid */
static int
match_proc_name(int pid)
{
    FILE *f;
    char *name;
    char buffer[1024];
    snprintf(buffer, sizeof(buffer), "/proc/%d/status", pid);

    f = fopen(buffer, "r");
    if(!f) {
	return 0;
    }

    /* read the first line of status */
    if(fgets(buffer, sizeof(buffer), f) == NULL) {
    fclose(f);
	return 0;
    }

    /* the first parameter should be Name: */
    if(strncasecmp(buffer, "Name:", 5) != 0) {
	fclose(f);
	return 0;
    }

    name = trim_space(buffer+5);

    fclose(f);
    if(strcmp(name, appname) == 0) {
	return 1;
    }
    return 0;
}

static int
checkRunningPid(void)
{
    pid_t pid;
    pid = readPidFile();
    if (pid < 2) {
	return 0;
    }

    if (kill(pid, 0) < 0) {
    	return 0;
    }

    /* now check if the process running is me */
    if(!match_proc_name(pid)) {
        return 0;
    }

    fprintf(stderr, "Garner is already running!  Process ID %d\n", pid);
    return 1;
}

static void
sendSignal(int signo)
{
    pid_t pid;
    pid = readPidFile();
    if (pid > 1  && match_proc_name(pid)) {
	if (kill(pid, signo) &&
	    /* ignore permissions if just running check */
	    !(signo == 0 && errno == EPERM)) {
	    fprintf(stderr, "%s: ERROR: Could not send ", appname);
	    fprintf(stderr, "signal %d to process %d: %s\n",
	    signo, (int) pid, strerror(errno));
	    exit(1);
	}
    } else {
	fprintf(stderr, "%s: ERROR: No running copy\n", appname);
	exit(1);
    }
    /* signal successfully sent */
    exit(0);
}

/* Variable Setting */
union _var_type_val {
    struct {
	u_int32_t type:8;
	u_int32_t val:24;
    };
    union sigval sigval;
};

enum {
    VAR_LOGLEVEL,
    VAR_TIMEOUT,
    VAR_MAX
};

struct _vars {
    u_int8_t type;
    char *name;
} vars[] = {
	{ VAR_LOGLEVEL, "LogLevel"},
	{ VAR_TIMEOUT,  "Timeout" },
	{ VAR_MAX,  	NULL }
    };

/* i don't know y i chose this signal */
#define SETVAR_SIGNO (SIGRTMAX-5)

static void
setVariable(const char *string)
{
    int i;
    pid_t pid;
    union _var_type_val vt;

    memset(&vt, 0, sizeof(vt));

    for(i=0; i<VAR_MAX; i++) {
	int len = strlen(vars[i].name);
	if(strncasecmp(string, vars[i].name, len) == 0) {
	    const char *value = string+len;
	    while(isspace(*value) || *value == '=') ++value;
	    vt.type = vars[i].type;
	    if(vars[i].type == VAR_LOGLEVEL) {
		int level = get_log_level_from_string(value);
		if(level < 0) {
		    fprintf(stderr, "%s: Invalid value of LogLevel: '%s'\n", appname, value);
		    exit(1);
		}
		vt.val = level;
	    } else if(vars[i].type == VAR_TIMEOUT) {
		vt.val = atoi(value);
		if(vt.val == 0) {
		    fprintf(stderr, "%s: Invalid value of TimeOut: '%s'\n", appname, value);
		    exit(1);
		}
	    } else {
		xassert(0);
	    }
	    break;
	}
    }

    if(i == VAR_MAX) {
	fprintf(stderr, "%s: Invalid variable '%s'\n", appname, string);
	exit(1);
    }

#if 0
    fprintf(stdout, "setting variable '%s' : %d (type=%d)\n", vars[i].name, vt.val, vt.type);
    fprintf(stdout, "mixed variable '0x%08x'\n", vt.sigval.sival_int);
#endif

    pid = readPidFile();
    if (pid > 1) {
	if (sigqueue(pid, SETVAR_SIGNO, vt.sigval) == -1) {
	    fprintf(stderr, "%s: ERROR: Could not send variable to process"\
			" %d: %s", appname, (int)pid, strerror(errno));
	    exit(1);
	}
    } else {
	fprintf(stderr, "%s: ERROR: No running copy\n", appname);
	exit(1);
    }
    /* signal successfully sent */
    exit(0);
}

void
sv_handler(int signo, siginfo_t *info, void *context)
{
    union _var_type_val vt;
    vt.sigval = info->si_value;

    switch(vt.type) {
	case VAR_LOGLEVEL:
	    set_log_level(vt.val);
	    break;
	case VAR_TIMEOUT:
	    break;
	case VAR_MAX:
	default:
	    break;
    }
}

/* -- */

#include <sys/ioctl.h>

static void
watch_child(int argc, char *argv[])
{
    char *prog;
    int failcount = 0;
    time_t start;
    time_t stop;
    int status;
    pid_t pid;
    int i;
    int nullfd;
    char **newargv;

    if (*(argv[0]) == '(') {
	return;
    }
    openlog(appname, LOG_PID | LOG_NDELAY | LOG_CONS, LOG_LOCAL4);
    if ((pid = fork()) < 0) {
	syslog(LOG_ALERT, "fork failed: %s", strerror(errno));
	exit(-1);
    } else if (pid > 0) {
	/* parent should exit */
	exit(0);
    }
    /* child */
    if (setsid() < 0) {
	syslog(LOG_ALERT, "setsid failed: %s", strerror(errno));
    }
    closelog();
#ifdef TIOCNOTTY
    if ((i = open("/dev/tty", O_RDWR | O_TEXT)) >= 0) {
	ioctl(i, TIOCNOTTY, NULL);
	close(i);
    }
#endif

    if(config.daemon.uniquetag[0] == '\0') {
	snprintf(config.daemon.uniquetag, sizeof(config.daemon.uniquetag), "%d", getpid());
	/* add one of our own, last one should be NULL */
	newargv = calloc(argc+3, sizeof(char**));
	memcpy(newargv, argv, argc * sizeof(char**));
	newargv[argc++] = strdup("-u");
	newargv[argc++] = strdup(config.daemon.uniquetag);
    } else {
	newargv = argv;
    }

    /* Connect stdio to /dev/null in daemon mode */
    nullfd = open("/dev/null", O_RDWR | O_TEXT);
    dup2(nullfd, 0);
    dup2(nullfd, 1);
    dup2(nullfd, 2);

    /* Close all else */
    for (i = 3; i < getdtablesize(); i++)
	close(i);

    do_nanosleep(0, 500);
    for (;;) {
	if ((pid = fork()) == 0) {
	    /* child */
	    openlog(appname, LOG_PID | LOG_NDELAY | LOG_CONS, LOG_LOCAL4);
	    prog = strdup(newargv[0]);
	    asprintf(&newargv[0], "(%s)", mybasename(argv[0]));
	    execvp(prog, newargv);
	    syslog(LOG_ALERT, "execvp() failed: %s", strerror(errno));
	    exit(-1);
	} else if(pid < 0) {
	    syslog(LOG_ALERT, "fork() failed: %s", strerror(errno));
	    exit(-1);
	}
	/* parent */
	openlog(appname, LOG_PID | LOG_NDELAY | LOG_CONS, LOG_LOCAL4);
	syslog(LOG_NOTICE, "Garner Parent: child process %d started with uniquetag: %s",
								pid, config.daemon.uniquetag);
	time(&start);
	signal(SIGINT, SIG_IGN);

	pid = waitpid(-1, &status, 0);
	time(&stop);
	if (WIFEXITED(status)) {
	    syslog(LOG_NOTICE,
		"Garner Parent: child process %d exited with status %d",
		 pid, WEXITSTATUS(status));

	    if(WEXITSTATUS(status) != 0){
		syslog(LOG_NOTICE,
		    "Garner Parent: child process %d exited due to signal %d",
		     pid, WTERMSIG(status));
	    }
	} else if (WIFSIGNALED(status)) {
	    syslog(LOG_NOTICE,
		"Garner Parent: child process %d exited due to signal %d",
		 pid, WTERMSIG(status));
	} else {
	    syslog(LOG_NOTICE, "Garner Parent: child process %d exited", pid);
	}
	if (stop - start < 10)
	    failcount++;
	else
	    failcount = 0;

	if (failcount == 5) {
	    syslog(LOG_ALERT,"Garner Parent: Exiting due to repeated, frequent failures");
	    exit(1);
	}
	/* check for normal exits */
	if (WIFEXITED(status))
	    if (WEXITSTATUS(status) == 0){
		exit(0);
	    }
	if (WIFSIGNALED(status)) {
	    switch (WTERMSIG(status)) {
	    case SIGKILL:
		/* 
		 * We were killed by signal 9, 
		 * threads did not do the cleanup, 
		 * so we need to do it. 
		 */
		exit(0);
		break;
	    default:
		break;
	    }
	}

	/* it was abnormally terminated, do the cleanup work */

	signal(SIGINT, SIG_DFL);
	do_nanosleep(3, 0);
    }
    /* NOTREACHED */
}

void
__print_action(const struct _action *action, int level)
{
    char sp[(level*2)+1];
    memset(sp, ' ', sizeof(sp));
    sp[sizeof(sp)-1] = '\0';

    xassert(action != NULL);
    switch(action->type) {
	/* body actions */
	case ACTION_CALL:
	    log_message(LG_DEBUG, "%sCALL\n", sp);
	    break;
	case ACTION_RETURN:
	    log_message(LG_DEBUG, "%sRETURN\n", sp);
	    break;
	default:
	    xassert(0);
    }
}

static int __print_act_cond(struct _act_cond *list, int level);

/* returns the maximum depth */
int
__print_condition(struct _condition *condition, int level)
{
    char sp[(level*2)+1];
    memset(sp, ' ', sizeof(sp));
    sp[sizeof(sp)-1] = '\0';

    xassert(condition != NULL);
    log_message(LG_DEBUG, "%sIF {\n", sp);
    level = __print_act_cond(condition->child_ac_list, level+1);
    log_message(LG_DEBUG, "%s} ENDIF\n", sp);
    return level;
}

/* returns the maximum depth */
static int
__print_act_cond(struct _act_cond *list, int level)
{
    int depth, maxdepth=0;
    while(list) {
	switch(list->type) {
	    case ACTION:
		__print_action(&list->un.action, level+1);
		break;
	    case CONDITION:
		depth = __print_condition(&list->un.condition, level+1)+1;
		if(depth > maxdepth)
		    maxdepth = depth;
		break;
	    default:
		xassert(0);
	}
	list = list->next;
    }
    return maxdepth;
}

/* returns the maximum depth */
int
print_act_cond(struct _act_cond *list)
{
    return __print_act_cond(list, 1);
}

#define _NX(x) (x?x:"")

static inline int
printConfig()
{
    struct _input_plugin *input;
    struct _output_plugin *output;
	struct _event_consumer *ev_con;

    log_message(LG_INFO, "printConfig\n");
    /* daemon */
    log_message(LG_INFO, "---------- Daemon ------------\n");
    log_message(LG_INFO, "daemon.pid_file: %s\n", _NX(config.daemon.pid_file));
    log_message(LG_INFO, "daemon.log_file: %s\n", _NX(config.daemon.log_file));
    log_message(LG_INFO, "daemon.config_file: %s\n", _NX(config.daemon.config_file));
    log_message(LG_INFO, "daemon.username: %s\n", _NX(config.daemon.username));
    log_message(LG_INFO, "daemon.group: %s\n", _NX(config.daemon.group));
    log_message(LG_INFO, "daemon.searray_initial_len: %d\n", config.daemon.searray_initial_len);
    log_message(LG_INFO, "daemon.searray_delta: %d\n", config.daemon.searray_delta);
    log_message(LG_INFO, "daemon.iobuffersize: %d\n", config.daemon.iobuffersize);
    log_message(LG_INFO, "daemon.rwtimeout: %u seconds, %u microseconds\n",
			(int)config.daemon.rwtimeout.tv_sec, (int)config.daemon.rwtimeout.tv_usec);
    log_message(LG_INFO, "\n");

    /* network */
	log_message(LG_INFO, "---------- NETWORK -------------\n");
    if (config.network[N_UDP].socketpath) {
        log_message(LG_INFO, "network[UDP].sockettype: %d\n", config.network[N_UDP].sockettype);
        log_message(LG_INFO, "network[UDP].socketpath: %s\n", _NX(config.network[N_UDP].socketpath));
    }
    if (config.network[N_TCP].socketpath) {
        log_message(LG_INFO, "network[TCP].sockettype: %d\n", config.network[N_TCP].sockettype);
        log_message(LG_INFO, "network[TCP].socketpath: %s\n", _NX(config.network[N_TCP].socketpath));
    }
    
    /* input */
    log_message(LG_INFO, "---------- INPUT -------------\n");
    for(input = config.input_list; input; input=input->next) {
	log_message(LG_INFO, "InputPlugin %s %s %s %s\n", input->ident,
			input->library, input->libprefix, input->argstring);
    }
    log_message(LG_INFO, "\n");

    /* output */
    log_message(LG_INFO, "---------- OUTPUT ------------\n");
    for(output = config.output_list; output; output=output->next) {
	log_message(LG_INFO, "OutputPlugin %s %s %s %s\n", output->opname,
			output->library, output->libprefix, output->argstring);
    }
    log_message(LG_INFO, "\n");

    /* event */
    log_message(LG_INFO, "---------- EVENT ------------\n");
    log_message(LG_INFO, "daemon.event.clock_period: %u\n", config.event.clock_period);
    for(ev_con = config.event_consumer_list; ev_con; ev_con = ev_con->next) {
	log_message(LG_INFO, "EventConsumer %s %d \n", ev_con->output->opname,
			(config.event.clock_period * ev_con->event_skipcount) );
    }
    log_message(LG_INFO, "\n");

    /* conditions */
    log_message(LG_INFO, "---------- CONDITIONS --------\n");
    print_act_cond(config.ac_list);

    return 0;
}
#undef _NX

/*
 * Check the validity of configuration mentioned read from config file.
 * Returns 0 if everything's valid. Some configuration may be set to
 * default ones and may not return error.
 */
static inline int
checkConfig()
{
    /*
     * Set the default values if they were not set in the config file.
     */
    printConfig();

/*    
    if(!config.network.socketpath) {
	config.network.socketpath = strdup("/var/run/garner.sock");
    } 
*/

    config.network[N_TCP].addrfamily = AF_UNIX;
    if(!config.network[N_UDP].socketpath && !config.network[N_TCP].socketpath) {
        config.network[N_TCP].socketpath = strdup("/tmp/garner.sock");
    }

    return 0;
}

/*
 * set the default values of all configuration
 */
static void
defaultAll()
{
    memset(&config, 0, sizeof(struct config_s));
    config.daemon.config_file = DEFAULT_CONF_FILE;
    config.daemon.pid_file = DEFAULT_PID_FILE;
    config.daemon.log_file = DEFAULT_LOG_FILE;
    config.daemon.searray_initial_len = 8;  /* initial length of searray */
    config.daemon.searray_delta = 8;        /* searray len += delta */
    config.daemon.iobuffersize = 4096;
    config.daemon.rwtimeout.tv_sec = 0;
    config.daemon.rwtimeout.tv_usec = 50000;	/* 50 miliseconds */
    config.event.clock_period = 10;	/* 10 seconds */
}

void
garner_quit(int signo)
{
    config.daemon.quit = 1;
}

#define INTERVAL 1800

void
garner_alarm(int signo)
{
    log_message(LG_ERR,"%s: GARNER GOT ALARM SIGNAL\n",appname) ; 

    config.daemon.alarm = 1;
    alarm(INTERVAL);
}

static inline void
release_fdpool (void)
{
    register int i;
    xassert (fd_pool.fd_list != NULL);

    for (i=0; i<fd_pool.tot_fds; i++) {
        if (fd_pool.fd_list[i] != NULL) {
            free(fd_pool.fd_list[i]);
        }
    }
    free (fd_pool.fd_list);
}

static void
close_udp_plugins(void)
{
    struct _input_plugin *udp_plugin = config.input_udp_list;
    for (; udp_plugin; udp_plugin=udp_plugin->next){
        udp_plugin->libname_close(NULL);
    }
}

void
garner_shutdown(void)
{
    log_message(LG_MSG, "%s: Closing servers\n", appname);

    log_message(LG_MSG, "Removing pid_file: %s\n", config.daemon.pid_file);
    if (unlink(config.daemon.pid_file) < 0) {
	log_message(LG_CRIT,
	    "Could not remove PID file \"%s\": %s.\n",
		    config.daemon.pid_file, strerror(errno));
    }
    if(config.network[N_UDP].addrfamily == AF_UNIX &&
	unlink(config.network[N_UDP].socketpath) != 0) {
	log_message(LG_ERR, "listen_unix_sock: unlink(%s) failed: %s\n",
                        config.network[N_UDP].socketpath, strerror(errno));
    }
    if(config.network[N_TCP].addrfamily == AF_UNIX &&
	unlink(config.network[N_TCP].socketpath) != 0) {
	log_message(LG_ERR, "listen_unix_sock: unlink(%s) failed: %s\n",
			config.network[N_TCP].socketpath, strerror(errno));
    }
    release_fdpool();
    close(config.ep_fd);
    close_udp_plugins();
    log_message(LG_MSG, "%s: Shutdown normally\n", appname);
    close_log_file();
    exit(EX_OK);
}

void sigsegv_dump(void **eips, int depth, void *callbackdata)
{
    int i;
    log_message(LG_CRIT, "sigsegv_dump: Segmentation Fault\n");
    for(i=0; i<depth; i++) {
        log_message(LG_CRIT, "%p\n", eips[i]);
    }
    log_message(LG_CRIT, "sigsegv_dump: End of dump\n");
    exit(11);
}

void
garner_reconfig(int signo)
{
    config.daemon.reconfig = 1;
}

void
toggle_log(int signo)
{
    config.daemon.toggle_log = 1;
}

void
set_max_fd_limit(int max_fd)
{
    struct rlimit rlmt;
    memset(&rlmt, 0, sizeof(struct rlimit));
    rlmt.rlim_cur = rlmt.rlim_max = max_fd;
    log_message(LG_INFO, "set_max_fd_limit: %d\n", max_fd);
    if (setrlimit(RLIMIT_NOFILE, &rlmt) == -1) {
	log_message(LG_ERR, "setrlimit(RLIMIT_NOFILE, %d) failed: %s\n", max_fd, strerror(errno));
    }
}

/*
 * Disable the creation of CORE files right up front.
 */
int
disable_coredump()
{
    struct rlimit core_limit = { 0, 0 };
    return setrlimit(RLIMIT_CORE, &core_limit);
}

void set_signal_handlers()
{
    struct sigaction sa;

    memset(&sa, 0, sizeof(sa));
    sa.sa_sigaction = sv_handler;
    sa.sa_flags = SA_SIGINFO ;

    if(sigaction(SETVAR_SIGNO, &sa, NULL) == -1) {
	fprintf(stderr, "sigaction '%d' failed: %s\n", SETVAR_SIGNO, strerror(errno));
	exit(-1);
    }

    signal(SIGQUIT, garner_reconfig);
    signal(SIGHUP, toggle_log);
    signal(SIGTERM, garner_quit);
    signal(SIGALRM, garner_alarm);
    signal(SIGPIPE, SIG_IGN);
}

/* number of connections that can be queued */
#define LISTEN_Q_LEN 50

int
listen_inet_sock(uint16_t port, const char *ipaddr, const int type)
{
    int listenfd;
    const int on = 1;
    int rcvbuf=16777216;

    struct sockaddr_in addr;

    xassert(port > 0);

    if (type == N_TCP) {
        log_message (LG_DEBUG, "listen_inet_sock: craeting tcp socket\n");
        listenfd = socket(AF_INET, SOCK_STREAM, 0);
    } else {
        xassert (type == N_UDP);
        log_message (LG_DEBUG, "listen_inet_sock: craeting udp socket\n");
        listenfd = socket(AF_INET, SOCK_DGRAM, 0);
    }

    if(listenfd < 0) {
	log_message(LG_ERR, "listen_inet_sock: socket() failed: %s\n", strerror(errno));
	return -1;
    }
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
#ifdef _ENABLE_CYGWIN
    setsockopt(listenfd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(int));
#else
    setsockopt(listenfd, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(int));
#endif
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);

    if (ipaddr) {
	addr.sin_addr.s_addr = inet_addr(ipaddr);
    } else {
	addr.sin_addr.s_addr = inet_addr("0.0.0.0");
    }

    if (bind(listenfd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
	log_message(LG_ERR, "Unable to bind listening socket to port '%d' because of %s\n",
								    port, strerror(errno));
	close(listenfd);
	return -1;
    }

    if (type == N_UDP) {
        return listenfd;
    }

    if (listen(listenfd, LISTEN_Q_LEN) < 0) {
	log_message(LG_ERR, "Unable to start listening socket because of %s\n", strerror(errno));
	close(listenfd);
	return -1;
    }

    return listenfd;
}

int
listen_unix_sock(const char *serverpath, const int type)
{
    int listenfd;
    struct sockaddr_un addr;

    xassert(serverpath != NULL);

    if (type == N_TCP) {
        log_message (LG_DEBUG, "listen_unix_sock: creating tcp socket\n");
        listenfd = socket(AF_UNIX, SOCK_STREAM, 0);
    } else {
        xassert (type == N_UDP);
        log_message (LG_DEBUG, "listen_unix_sock: creating udp socket\n");
        listenfd = socket(AF_UNIX, SOCK_DGRAM, 0);
    }
    if(listenfd < 0) {
	log_message(LG_ERR, "listen_unix_sock: socket() failed: %s\n", strerror(errno));
	return -1;
    }

    if(unlink(serverpath) != 0) {
	log_message(LG_INFO, "listen_unix_sock: unlink(%s) failed: %s\n",
					serverpath, strerror(errno));
    }

    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    if (*serverpath == '/'){
        strcpy((char*)&addr.sun_path, serverpath);
    } else {
        /* creating abstract namespace unix bind address*/
        strcpy((char*)&(addr.sun_path[1]), serverpath);
    }

    if (bind(listenfd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
	log_message(LG_ERR, "bind(%s) failed: %s\n", serverpath, strerror(errno));
	close(listenfd);
	return -1;
    }

    if (type == N_UDP) {
        return listenfd;
    }

    if (listen(listenfd, LISTEN_Q_LEN) < 0) {
	log_message(LG_ERR, "listen() failed: %s\n", strerror(errno));
	close(listenfd);
	return -1;
    }

    return listenfd;
}

#define MAX_EVENTS	256 
typedef void (FD_CALLBACK)(void*, u_int32_t);

struct _fd_data {
    int	fd;
    time_t last_accesstime;
    const struct _input_plugin *input;
    void *input_handle;
    FD_CALLBACK *callback;
};

static inline void
assign_to_fdpool (struct _fd_data *fd_data)
{
    fd_pool.tot_fds++;
    fd_pool.fd_list = (struct _fd_data **)realloc (fd_pool.fd_list,
		                               fd_pool.tot_fds * sizeof(struct _fd_data *));
    fd_pool.fd_list[fd_pool.tot_fds -1] = fd_data;
}

#ifdef _ENABLE_CYGWIN

#include <sys/select.h>
struct _fd_arr {
    int	fd;
    int	is_inplgn_fd;
    struct _fd_data *data ;
};
struct _fd_arr fd_arr[MAX_EVENTS] ;

#define SET_FD(i)		(fd_arr[i].fd = i)
#define FD_PRIVDATA(i)		(fd_arr[i].data)
#define RESET_FD_DATA(i)	{fd_arr[i].fd = -1 ; fd_arr[i].data=NULL; fd_arr[i].is_inplgn_fd = 0; }
#define IF_FD_VALID(i)		(fd_arr[i].fd >= 0 ? 1 : 0)
#define IS_INPLGN_FD(i)		(fd_arr[i].is_inplgn_fd)
#define SET_INPLGN_FD(i)	(fd_arr[i].is_inplgn_fd = 1)
#define RESET_INPLGN_FD(i)	(fd_arr[i].is_inplgn_fd = 0)


#else /* _ENABLE_CYGWIN */

#include <sys/epoll.h>

#endif /* _ENABLE_CYGWIN */

struct _fd_data*
new_fd_data(int fd, const void *data, FD_CALLBACK *callback)
{
    struct _fd_data *fd_data = calloc(1, sizeof(struct _fd_data));
    fd_data->fd = fd;
    fd_data->last_accesstime = time(NULL);
    fd_data->input = data;
    fd_data->callback = callback;
    assign_to_fdpool(fd_data);
    return fd_data;
}

static inline void
remove_from_fdpool(struct _fd_data *fd_data)
{
    register int i;
    xassert (fd_data != NULL);

    for (i=0; i< fd_pool.tot_fds; i++) {
        if (fd_pool.fd_list[i] == fd_data) {
            break;
        }
    }
    /* fd pointer not found in the fdpool. this must not be the case */
    if (i == fd_pool.tot_fds) {
        xassert (0);
    }
    free (fd_pool.fd_list[i]);
    fd_pool.fd_list[i] = NULL;
}

void
free_fd_data(struct _fd_data *fd_data)
{
    int fd;

    xassert(fd_data != NULL);

    fd = fd_data->fd;

    /* NOTE: Kernel below 2.6.9 need NON-NULL ev to be passed every time
     * even though its of no use for delete. Thats y i have to pass it
     * on here to be safe.
     */
    close(fd);

    /* reset the associated library */
    fd_data->input->libname_close(fd_data->input_handle);

#ifdef _ENABLE_CYGWIN
	RESET_FD_DATA(fd) ;
#else	
    if (epoll_ctl(config.ep_fd, EPOLL_CTL_DEL, fd, NULL) == -1) {
	log_message(LG_ERR, "EPOLL_CTL_DEL failed: %s\n", strerror(errno));
	return;
    }
#endif /* _ENABLE_CYGWIN */

    remove_from_fdpool(fd_data);
}

#define INACTIVE_CONNECTION_TIMEOUT 300		/* in seconds */



static void
flush_inactive_connections(void)
{
#ifdef _ENABLE_CYGWIN
    int i;
    time_t now, sum;
    struct _fd_data *fd_data = NULL;

    now = time(NULL);
    for(i=0; i<MAX_EVENTS; i++) {
	fd_data = NULL;

	if(!IS_INPLGN_FD(i)) {
	    /* connection is not related to input plugin */
	    continue;
	}
	if(IF_FD_VALID(i)) {
	    fd_data = FD_PRIVDATA(i);
	    sum = fd_data->last_accesstime + INACTIVE_CONNECTION_TIMEOUT;
	    log_message(LG_NOTICE, "flush_inactive_conn: fd: %d now: %lu sum: %lu\n", fd_data->fd, now, sum);
	    if(now > sum) {
		log_message(LG_NOTICE, "closing inactive connection on fd: %d\n", fd_data->fd);
		free_fd_data(fd_data);
	    }
    	}
    }

#endif /* _ENABLE_CYGWIN */
    return;
}

#define SEA config.daemon.searray
#define SEALEN config.daemon.searray_initial_len

static int
evalexp(struct _std_event *se, struct _exprnode *node)
{
    if(!node) return 0;

    if(node->op=='!') {
    	int leftop;
	leftop = evalexp(se, node->left);
	return !leftop;
    } else if(node->op=='&'){
	int leftop;
	leftop = evalexp(se, node->left);
	if(leftop == 0) {
	    return leftop;
	} else {
	    return (leftop && evalexp(se, node->right));
	}
    } else if (node->op=='|') {
	int leftop;
	leftop = evalexp(se, node->left);
	if (leftop == 0 ) {
	    return ( leftop || evalexp(se, node->right));
	} else {
	    return leftop;
	}
    } else {
	/* it is a comparison node, do the callback to check the
	 * condition, if (callback return 0) condition true,
	 * else false
	 */
	struct _callback *cb = &node->callback;
	xassert(cb->routine != NULL);
	return !cb->routine(se, cb->data, cb->cbop);
    }

    return 0;
}

/* returns 1 if a RETURN statement was encountered else returns 0.
 * The return value is used for internal processing only.
 */
int
check_conditions(struct _std_event *se, struct _act_cond *ac_list, struct _output_data **odlist)
{
    struct _act_cond *ac;
    xassert(se != NULL);

    for(ac = ac_list; ac; ac=ac->next) {
	switch(ac->type) {
	  case ACTION:
	    {
		const struct _action *action = &ac->un.action;
		switch(action->type) {
		    case ACTION_CALL:
			{
			struct _output_plugin *output = ac->un.action.args;
			xassert(output != NULL);
			log_message(LG_DEBUG, "CALL %s\n", output->opname);
			output->libname_output(se, 1, odlist, output->plugin_handle);
			}
			break;
		    case ACTION_RETURN:
			/* just return from here */
			log_message(LG_DEBUG, "RETURN\n");
			return 1;
			break;
		    default:
			/* NOT REACHED */
			xassert(0);
		}
	    }
	  break;
	  case CONDITION:
	    {
		const struct _condition *condition = &ac->un.condition;
		if(evalexp(se, condition->exprnode) == TRUE) {
		    log_message(LG_DEBUG, "IF condition TRUE\n");
		    if(check_conditions(se, condition->child_ac_list, odlist) != 0) {
			return 1;
		    }
		} else {
		    log_message(LG_DEBUG, "IF condition FALSE\n");
		}
	    }
	  break;
	  default:
	    /* NOT REACHED */
	    xassert(0);
	}
    }
    return 0;
}

void
free_output_data(struct _output_data *odlist)
{
    struct _output_data *next;
    while(odlist) {
	if(odlist->freehandler) {
	    odlist->freehandler(odlist->data);
	}
	next = odlist->next;
	free(odlist);
	odlist = next;
    }
}

void
process_std_events(struct _std_event *searray, int nse)
{
    int i;
    struct _output_data *odlist = NULL;

    log_message(LG_DEBUG, "process_std_events: no of std_events = %d\n", nse);
    for(i=0; i<nse; i++) {
	check_conditions(searray+i, config.ac_list, &odlist);
	free_output_data(odlist);
	odlist = NULL;
    }
}

void
handle_input(void *data, u_int32_t event)
{
    int n, fd, nse;
    u_int8_t buffer[config.daemon.iobuffersize];
    struct _fd_data *fd_data = data;
    const struct _input_plugin *input;

    log_message(LG_DEBUG, "handle_input: called\n");
    fd = fd_data->fd;
    input = fd_data->input;

    n = read(fd, buffer, sizeof(buffer));
    if(n > 0) {
retry:
	nse = input->libname_input(buffer, n, SEA, SEALEN, fd_data->input_handle);
	log_message(LG_INFO, "input plugin returned with %d\n", nse);

	if(nse > 0) {
	    process_std_events(SEA, nse);
	    memset(SEA, 0, nse * sizeof(struct _std_event));
	} else {
	    if(nse == 0) {
		/* nothing */
	    } else if(nse == -2) {
		/* plugin needs more searray size */
		SEALEN += config.daemon.searray_delta;
		log_message(LG_INFO, "reallocating searray to %d elements\n", SEALEN);
		config.daemon.searray = realloc(SEA, SEALEN * sizeof(struct _std_event));
		memset(SEA, 0, SEALEN * sizeof(struct _std_event));
		goto retry;
	    } else {
		log_message(LG_ERR, "%s: internal error\n", input->library);
	    }
	}
    } else if(n == 0) {
	/* LATER: do the epoll del and free fd_data */
	log_message(LG_INFO, "client ident '%s' closed connection on fd: %d\n", input->ident, fd);
	free_fd_data(fd_data);
    } else {
	/* error */
	if(!(errno == EAGAIN || errno == EINTR)) {
	    /* this can make epoll loop infinitely, lets terminate the connection */
	    log_message(LG_ERR, "read() failed: %s. terminating ident: %s\n", strerror(errno), input->ident);
	    free_fd_data(fd_data);
	}
    }
}

#define _STRING_LINE_(s)    #s
#define STRINGIFY(s)   _STRING_LINE_(s)

#define GREET PACKAGE "-" VERSION " (Std-Event: " STRINGIFY(STD_EVENT_VERSION) ")\r\n"

/*
 * Set the socket to non blocking
 */
int
socket_nonblocking(int sock)
{
    int flags;

    xassert(sock >= 0);

    flags = fcntl(sock, F_GETFL, 0);
    return fcntl(sock, F_SETFL, flags | O_NONBLOCK);
}

static int
set_socket_rw_timeout(int fd, struct timeval tv)
{
    if(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(struct timeval)) != 0) {
	log_message(LG_ERR, "setsockopt(SO_RCVTIMEO): fd: %d, failed: %s\n",
							fd, strerror(errno));
	return -1;
    }
    if(setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(struct timeval)) != 0) {
	log_message(LG_ERR, "setsockopt(SO_SNDTIMEO): fd: %d, failed: %s\n",
							fd, strerror(errno));
	return -1;
    }
    return 0;
}

static inline struct _input_plugin *
get_ident_struct(u_int32_t ident)
{
    struct _input_plugin *input;
    for(input=config.input_udp_list; input; input=input->next) {
        if(input->src_port == ident) {
            log_message(LG_DEBUG, "get_ident_struct: got plugin for %d\n", ident);
            return input;
        } else if (input->src_port > ident) {
            break;
        }
    }

    if (config.input_udp_list->src_port == 0) {
        log_message(LG_DEBUG, "get_ident_struct: using default plugin for %d\n", ident);
        return config.input_udp_list;
    }

    log_message(LG_ERR, "get_ident_struct: no valid plugin found for %d\n", ident);
    return NULL;
}

void
handle_accept_udp(void *data, u_int32_t event)
{
    u_int32_t read_bytes, ident;
    u_int8_t buffer[UDP_BUF_SIZE];
    socklen_t peer_len;
    struct sockaddr_in peer_add;
    struct _fd_data *fd_data = data;
    struct _input_plugin *input;
    int nse;
    char* srcip = NULL;

    peer_len = sizeof(struct sockaddr_in);

    read_bytes = recvfrom(fd_data->fd, buffer+16, UDP_BUF_SIZE-17, 0,
    	                      (struct sockaddr *)&peer_add, &peer_len);
    if (read_bytes <= 0) {
        log_message (LG_ERR, "handle_accept_udp: cannot read "
                     "from the socket '%s'\n", strerror(errno));
        return;
    }
    
    srcip = inet_ntoa(peer_add.sin_addr);
    memcpy(buffer, srcip, 16);
    read_bytes += 16;
    buffer[read_bytes] = '\0';
    buffer[15]='\0';
    ident = ntohs(peer_add.sin_port);
    log_message(LG_INFO, "Got ident: '%d'\n", ident);

    if ((input=get_ident_struct(ident)) == NULL) {
	return;
    }

retry:
    nse = input->libname_input(buffer, read_bytes, SEA, SEALEN, NULL);
    if(nse > 0) {
	process_std_events(SEA, nse);
        memset(SEA, 0, nse * sizeof(struct _std_event));
    } else {
        if(nse == 0) {
            /* nothing */
        } else if(nse == -2) {
            /* plugin needs more searray size */
            SEALEN += config.daemon.searray_delta;
            log_message(LG_INFO, "reallocating searray to %d elements\n", SEALEN);

            config.daemon.searray = realloc(SEA, SEALEN * sizeof(struct _std_event));
            memset(SEA, 0, SEALEN * sizeof(struct _std_event));
            goto retry;
        } else {
            log_message(LG_ERR, "%s: internal error\n", input->library);
        }
    }
    return;
}

void
handle_accept(void *data, u_int32_t event)
{
#ifndef _ENABLE_CYGWIN
    struct epoll_event ev;
#endif

    int newfd, n;
    struct _fd_data *fd_data = data;
    struct _fd_data *plugin_fd_data = NULL;
    char *ident=NULL, *version=NULL;
    struct _input_plugin *input;
    u_int32_t se_version ;

    xassert(fd_data != NULL);

    log_message(LG_INFO, "handle_accept: called\n");

    newfd = accept(fd_data->fd, NULL, NULL);
    if(newfd < 0) {
	log_message(LG_ERR, "handle_accept: accept: error: %s\n", strerror(errno));
	return;
    }

    log_message(LG_INFO, "handle_accept: accept() returned fd : %d\n", newfd);

    set_socket_rw_timeout(newfd, config.daemon.rwtimeout);

    /* do the handshake */
    if(write(newfd, GREET, sizeof(GREET)-1) != sizeof(GREET)-1) {
	log_message(LG_ERR, "handle_accept: write() failed during handshake\n");
	close(newfd);
	return;
    }

    if((n = readline(newfd, &ident)) <= 0) {
	log_message(LG_ERR, "handle_accept: read() failed during handshake, ret code:'%d'\n",n);
	close(newfd);
	return;
    }

    se_version = 0;
    version = strchr(ident, ' ');
    if(version) {
	*version++ = '\0' ;
	trim_end(version) ; 
	se_version = strtol(version, NULL, 16) ;
    } 

    log_message(LG_INFO, "Got ident: '%s'\n", ident);

    for(input=config.input_list; input; input=input->next) {
	if(strcasecmp(input->ident, ident) == 0) {
	    break;
	}
    }

    if(input == NULL) {
	log_message(LG_ERR, "handle_accept: client sent invalid ident: %s\n", ident);
	safefree(ident);
	close(newfd);
	return;
    }

    plugin_fd_data = new_fd_data(newfd, input, handle_input) ;

    if(input->libname_init(input->argstring,
		se_version ? se_version : STD_EVENT_VERSION, 
		&plugin_fd_data->input_handle) != 0) {
	log_message(LG_ERR, "handle_accept: input plugin init fail\n");
	safefree(ident);
	close(newfd);
	free(plugin_fd_data);
	return;
    }

#ifdef _ENABLE_CYGWIN

    if(newfd > max_fd) {
	max_fd = newfd ;
    }
    SET_FD(newfd) ;
    FD_PRIVDATA(newfd) = plugin_fd_data ;
    SET_INPLGN_FD(newfd);

#else /* _ENABLE_CYGWIN */

    ev.events = EPOLLIN;
    /* prevent valgrind from reporting uninitialized bytes */
    ev.data.u64 = 0;
    ev.data.ptr = plugin_fd_data ; 
    if (epoll_ctl(config.ep_fd, EPOLL_CTL_ADD, newfd, &ev) == -1) {
	log_message(LG_ERR, "epoll_ctl: EPOLL_CTL_ADD failed: %s\n", strerror(errno));
    }

#endif /* _ENABLE_CYGWIN */

    socket_nonblocking(newfd);

    free(ident);
}


static inline int
initialize_network(const int type)
{
    int fd;
    char *server = config.network[type].socketpath;

    xassert (type == N_UDP || type == N_TCP);
    xassert (config.network[type].addrfamily == AF_INET ||
		            config.network[type].addrfamily == AF_UNIX);

    if (config.network[type].addrfamily == AF_UNIX) {
        fd = listen_unix_sock(server, type);
    } else {
        char *pstr = strchr(server, ':');
        int port;
        if(!pstr) {
            /* port not given */
            log_message(LG_ERR, "invalid network.socketpath: %s\n", server);
            return -1;
        }
        *pstr++ = '\0';
        port = atoi(pstr);

        fd = listen_inet_sock(port, server, type);
    }
    return fd;
}

#ifndef _ENABLE_CYGWIN
static inline int
register_epollfd(int *fd, FD_CALLBACK *callback)
{
    struct epoll_event ev;

    xassert(config.ep_fd != 0);
    xassert(fd != NULL);

    if (*fd == 0) {
        *fd = -1;
        return 0;
    }
    xassert (*fd != -1);
    ev.events = EPOLLIN;
    /* prevent valgrind from reporting uninitialized bytes */
    ev.data.u64 = 0;
    ev.data.ptr = new_fd_data(*fd, NULL, callback);
    if (epoll_ctl(config.ep_fd, EPOLL_CTL_ADD, *fd, &ev) == -1) {
        log_message(LG_ERR, "epoll_ctl: EPOLL_CTL_ADD failed: %s\n", strerror(errno));
        return -1;
    }
    return 0;
}
#endif /* _ENABLE_CYGWIN */

#ifdef _ENABLE_CYGWIN
static inline int
register_select(int *fd, FD_CALLBACK *callback)
{
    xassert(fd != NULL);

    if (*fd == 0) {
        *fd = -1;
        return 0;
    }
    xassert (*fd != -1);

    if(*fd > max_fd) {
        max_fd = *fd ;
    }
    SET_FD(*fd) ;
    FD_PRIVDATA(*fd) = new_fd_data(*fd, NULL, callback);

    return 0;
}
#endif /* _ENABLE_CYGWIN */

/*
 * Creates the epoll fd and listener socket.
 * Can create both inet and unix sockets.
 */
int
init_network()
{
    memset (&fd_pool, 0, sizeof(struct _fd_pool));

#ifdef _ENABLE_CYGWIN
    config.ep_fd = -1 ;
    {
        int i ;
        for(i=0; i<MAX_EVENTS; i++) {
            RESET_FD_DATA(i);
        }
    }
#else  /* _ENABLE_CYGWIN */

    /* create the epoll descriptor */
    if((config.ep_fd = epoll_create(MAX_EVENTS)) == -1) {
	log_message(LG_ERR, "epoll_create: failed: %s\n", strerror(errno));
	return -1;
    }

#endif /* _ENABLE_CYGWIN */

    if (config.network[N_UDP].socketpath) {
        log_message (LG_DEBUG, "Initializing udp network\n");
        if ((config.network[N_UDP].listen_fd = initialize_network(N_UDP)) == -1) {
            return -1;
        }
    } else {
        xassert (config.network[N_TCP].socketpath != NULL);
        log_message (LG_DEBUG, "Initializing tcp network\n");
        if ((config.network[N_TCP].listen_fd = initialize_network(N_TCP)) == -1) {
            return -1;
        }
    }

#ifdef _ENABLE_CYGWIN
    if (((register_select(&config.network[N_UDP].listen_fd, handle_accept_udp)) == -1)          
		|| ((register_select(&config.network[N_TCP].listen_fd, handle_accept)) == -1)) {
	return -1;
    }
#else  /* _ENABLE_CYGWIN */
    if ( ((register_epollfd(&config.network[N_UDP].listen_fd, handle_accept_udp)) == -1)          
		|| ((register_epollfd(&config.network[N_TCP].listen_fd, handle_accept)) == -1)) {
	return -1;
    }
#endif /* _ENABLE_CYGWIN */

    return 0;
}

void
do_household_work()
{
    monitor_logsize();
}

void toggle_log_level_of_plugins()
{
    struct _input_plugin *input;
    struct _output_plugin *output;

    /* input */
    for(input = config.input_list; input; input=input->next) {
	if(input->libname_debug) {
	    log_message(LG_INFO, "toggle_log: input-plugin <%s>\n", input->ident);
	    input->libname_debug(NULL);
	}
    }

    /* output */
    for(output = config.output_list; output; output=output->next) {
	if(output->libname_debug) {
	    log_message(LG_INFO, "toggle_log: output-plugin <%s>\n", output->opname);
	    output->libname_debug(output->plugin_handle);
	}
    }
}

#define CHECK_SIG()					\
{							\
    if(config.daemon.sig) {				\
	if(config.daemon.alarm) {			\
	    do_household_work();			\
	}						\
	if(config.daemon.quit) {			\
	    break;					\
	}						\
	if(config.daemon.reconfig) {			\
	    /* do reconfig */				\
	}						\
	if(config.daemon.toggle_log) {			\
	    toggle_log_level();				\
	    toggle_log_level_of_plugins();		\
	}						\
	config.daemon.sig = 0;				\
    }							\
}

#ifdef _ENABLE_CYGWIN
static void
do_select()
{
    int events, i;
    struct _fd_data *fd_data;
    fd_set rfds ;

    for(;;) {

        CHECK_SIG();

        log_message(LG_DEBUG, "do_select: waiting for connections\n");

	    FD_ZERO(&rfds);
    	for(i=0; i<(max_fd+1); i++) {
        	if(IF_FD_VALID(i)){
            	FD_SET(i, &rfds);
        	}
    	}

        if((events = select(max_fd+1, &rfds, NULL, NULL, NULL)) == -1) {
            if(errno != EINTR) {
                log_message(LG_ERR, "select: error: %s\n", strerror(errno));
            }
        } else {
            log_message(LG_DEBUG, "Got %d events on select\n", events);

            for (i = 0; i < (max_fd+1); i++) {
		/* if event received for fd which is still active */
		if(IF_FD_VALID(i) && FD_ISSET(i, &rfds)) {
                    fd_data = FD_PRIVDATA(i);
                    xassert(fd_data != NULL);
					fd_data->last_accesstime = time(NULL);
                    fd_data->callback(fd_data, 0);
                }
            } /* end FOR loop */
        }
    } /* infinite for loop */
}

#else  /* _ENABLE_CYGWIN */

static void
do_epoll()
{
    int events, i;
    struct _fd_data *fd_data;
    struct epoll_event cev[MAX_EVENTS];

    for(;;) {

	CHECK_SIG();

	log_message(LG_DEBUG, "do_epoll: waiting for connections\n");

	if ((events = epoll_wait(config.ep_fd, cev, MAX_EVENTS, -1)) == -1) {
	    if(errno != EINTR) {
		log_message(LG_ERR, "epoll_wait: error: %s\n", strerror(errno));
	    }
	} else {
	    log_message(LG_DEBUG, "Got %d events on epoll fd\n", events);

	    for (i = 0; i < events; i++) {
		fd_data = cev[i].data.ptr;
		xassert(fd_data != NULL);
		/* ------- ????? ----------- 
		 *	what should be done if event received from fd which was detected as inactive
		 *	and been flushed by handle_clockevent callback ??? 
		 */
		fd_data->last_accesstime = time(NULL);
		fd_data->callback(fd_data, cev[i].events);
	    } /* end FOR loop */
	}
    } /* infinite for loop */
}

#endif /* _ENABLE_CYGWIN */

void
parent_main()
{
#ifdef _ENABLE_CYGWIN
    do_select();
#else 	/* _ENABLE_CYGWIN */
    do_epoll();
#endif	/* _ENABLE_CYGWIN */

    /* windup clock event related stuff */
    pthread_cancel(config.event.tid);
    close(config.event.read_fd);
    close(config.event.write_fd);
}

/* ------  CLOCK EVENT RELATED ROUTINE STARTS ------    */

#ifdef _ENABLE_CLOCKEVENT
void
handle_clockevent(void *data, u_int32_t event)
{
    struct _event_consumer *ev_con;
    struct _output_plugin *op;
    int event_nr ;
    int loop_count ;		
    u_int8_t buf[16];	

    event_nr = read(config.event.read_fd, buf, sizeof(buf));
    if(event_nr < 0) {
	log_message(LG_ERR,"handle_clockevent: event read failed: %s\n", strerror(errno)) ;
	return ;
    }

    log_message(LG_DEBUG,"handle_clockevent: '%d' events received\n",event_nr);
    if(!event_nr) {
	return ;
    }

    /* first forcefully close all inactive connections */
    flush_inactive_connections();

    for(ev_con=config.event_consumer_list; ev_con; ev_con=ev_con->next) {
	op = ev_con->output ;
	if(!op->libname_event) {
	    log_message(LG_DEBUG,"handle_clockevent: libname_event not defined in '%s'\n",
                                                                       	op->opname);
	    continue;
	}

	/* calculate total event count */
	ev_con->event_count += event_nr ;

	/* calculate number of events to be sent to consumer plugin */
	loop_count = (ev_con->event_count)/(ev_con->event_skipcount) ;

#ifdef _ENABLE_CLOCKEVENT_AGGREGATION
	if(loop_count) {
	    loop_count = 1;
	}		
#endif
	if(loop_count-- > 0) {
	    /* call <libname>_event routine of output plugin */
	    op->libname_event(op->plugin_handle) ;
	    log_message(LG_DEBUG,"handle_clockevent: clock event sent to '%s'\n", op->opname);
	}

	/* store remaning event count */
	ev_con->event_count %= (ev_con->event_skipcount) ;
    }	
    return ;
}

static void *
clockevent_thread_handler(void *arg)
{
    u_int8_t data;
    int ret, is_interrupted;	
    struct timespec req_ts,rem_ts ;   
    sigset_t sig_set,old_sigset;
	
    sigemptyset(&sig_set);
    sigaddset(&sig_set, SIGHUP);	
    sigaddset(&sig_set, SIGALRM) ;	

    if(pthread_sigmask(SIG_BLOCK, &sig_set, &old_sigset) < 0) {
    	log_message(LG_ERR,"clockevent_thread: pthread_sigmask failed\n");
    }

    /* should immediately quit on cancel request */
    pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);	

    log_message(LG_DEBUG,"clockevent_thread: thread started...\n");

    data = 1;
	
    req_ts.tv_nsec = 0 ;	
    is_interrupted = 0 ; 
    while(1) {
	/* sleep for configured time period - base clock period for garner */
	if(is_interrupted) {
	    req_ts.tv_sec = rem_ts.tv_sec ;
	    is_interrupted = 0;
	} else {
	    req_ts.tv_sec = config.event.clock_period ;
	}
	rem_ts.tv_sec = 0; 
	ret = nanosleep(&req_ts, &rem_ts);
	if(ret == -1) {
	    //log_message(LG_ERR,"clockevent_thread: nanosleep failed\n");
	    if(errno == EINTR) {
		//log_message(LG_ERR,"clockevent_thread: signal received\n");
		is_interrupted =1;
	    }
	    continue;
	}

	ret = write(config.event.write_fd, &data, sizeof(data));
	if(ret < 0) {
	    log_message(LG_ERR, "clockevent_thread: event write failed: %s\n", strerror(errno));
	}
    }
    pthread_exit(NULL);
    return 0;
}

static int
init_clockevent(void)
{
    pthread_attr_t attribute;
    int flags;
	
#ifndef _ENABLE_CYGWIN
    struct epoll_event ev;
#endif /* _ENABLE_CYGWIN */

    /* create pipe to handle clock event flow between garner and clock event thread */
    if(pipe(config.event.pipefd) == -1) {
	log_message(LG_ERR, "init_event_thread: pipe() failed: %s\n", strerror(errno));	
	return -1;
    }

    /* prepare pipe read fd for select/epoll by garner context */
#ifdef _ENABLE_CYGWIN
    if(config.event.read_fd > max_fd) {
        max_fd = config.event.read_fd ;
    }
    SET_FD(config.event.read_fd) ;
    FD_PRIVDATA(config.event.read_fd) =
	        new_fd_data(config.event.read_fd, NULL, handle_clockevent);

#else  /* _ENABLE_CYGWIN */
    /* lets register the listener fd with epoll */
    ev.events = EPOLLIN;
    /* prevent valgrind from reporting uninitialized bytes */
    ev.data.u64 = 0;
    ev.data.ptr = new_fd_data(config.event.read_fd, NULL, handle_clockevent);
    if (epoll_ctl(config.ep_fd, EPOLL_CTL_ADD, config.event.read_fd, &ev) == -1) {
	log_message(LG_ERR, "epoll_ctl: EPOLL_CTL_ADD failed: %s\n", strerror(errno));
	close(config.event.read_fd);
	close(config.event.write_fd);
    	return -1;
    }
#endif /* _ENABLE_CYGWIN */
	
    /* make clock event read fd non-blocking */
    flags = fcntl(config.event.read_fd, F_GETFL, 0);
    fcntl(config.event.read_fd, F_SETFL, flags | O_NONBLOCK);

    /* 
     * create clock event thread
     * initialise and set required attributes to make thread detached 
     */
    pthread_attr_init(&attribute);
    pthread_attr_setdetachstate(&attribute, PTHREAD_CREATE_DETACHED);

    /* creating a clock event thread */
    if((pthread_create(&(config.event.tid), &attribute, 
			clockevent_thread_handler, NULL)) < 0){
	log_message(LG_ERR, "init_event_thread: clock event thread creation failed\n");

#ifdef  _ENABLE_CYGWIN

	config.event.tid = NULL;

#else   /* _ENABLE_CYGWIN */

	config.event.tid = -1;

#endif  /* _ENABLE_CYGWIN */

        pthread_attr_destroy(&attribute);
	close(config.event.read_fd);
	close(config.event.write_fd);
        return -1;
    }
    /* destroy initialized thread attributes */
    pthread_attr_destroy(&attribute);	

    return 0;
}

#endif /* _ENABLE_CLOCKEVENT */

/* ------  CLOCK EVENT RELATED ROUTINE ENDS ------    */

/*
 * garner starts from here 
 */
int
garner_main(int argc, char **argv)
{
    int optch;
    int truncatelog=0;
    int daemonize=1;
    int opt_send_signal=-1;
    const char *opt_set_variable=NULL;

    defaultAll();

    /*
     * Process the various options
     */
    while ((optch = getopt(argc, argv, "c:k:l:p:vL:hnts:u:T")) != EOF) {
	switch (optch) {
	    case 'v':
		display_version();
		exit(EX_OK);
	    case 'T':
		config.daemon.test_plugin = 1;
		break;
	    case 'L':
		set_log_level(atoi(optarg));
		break;
	    case 'c':
		config.daemon.config_file = optarg;
		if (!config.daemon.config_file) {
		    fprintf(stderr, "%s: Could not allocate memory.\n", appname);
		    exit(EX_SOFTWARE);
		}
		break;
	    case 'l':
		config.daemon.log_file = optarg;
		if (!config.daemon.log_file) {
		    fprintf(stderr, "%s: Could not allocate memory.\n", appname);
		    exit(EX_SOFTWARE);
		}
		break;
	    case 'p':
		config.daemon.pid_file = optarg;
		if (!config.daemon.pid_file) {
		    fprintf(stderr, "%s: Could not allocate memory.\n", appname);
		    exit(EX_SOFTWARE);
		}
		break;
	    case 'k':
		if(opt_set_variable) {
		    fprintf(stderr, "-k option cannot be combined with -s option.\n");
		    display_usage();
		    exit(EX_OK);
		}
		if (!strncasecmp(optarg, "debug", strlen(optarg)))
		    opt_send_signal = SIGHUP;
		else if (!strncasecmp(optarg, "reconfig", strlen(optarg)))
		    opt_send_signal = SIGQUIT;
		else if (!strncasecmp(optarg, "shutdown", strlen(optarg)))
		    opt_send_signal = SIGTERM;
		else if (!strncmp(optarg, "kill", strlen(optarg)))
		    opt_send_signal = SIGKILL;
		else {
		    fprintf(stderr, "Invalid Option: %s\n", optarg);
		    display_usage();
		    exit(EX_OK);
		}
		break;
	    case 'n':
		daemonize = 0;
		break;
	    case 's':
		if(opt_set_variable) {
		    fprintf(stderr, "-s option can appear only once in a single run.\n"\
			"To set more than one variables, run this command for each variable.\n");
		    display_usage();
		    exit(EX_OK);
		}
		if(opt_send_signal != -1) {
		    fprintf(stderr, "-s option cannot be combined with -k option.\n");
		    display_usage();
		    exit(EX_OK);
		}
		opt_set_variable = optarg;
		break;
	    case 'u':
		strncpy(config.daemon.uniquetag, optarg, sizeof(config.daemon.uniquetag)-1); 
		break;
	    case 't':
		truncatelog = 1;
		break;
	    case 'h':
	    default:
		display_usage();
		exit(EX_OK);
	}
    }

    if (opt_send_signal != -1) {
	/* garner should be running here*/
	sendSignal(opt_send_signal);
	exit(EX_OK);
    }
    if(opt_set_variable) {
	/* garner should be running here*/
	setVariable(opt_set_variable);
	exit(EX_OK);
    }

    if (checkRunningPid()) {
	exit(EX_OK);
    }

    /* starting */

    umask(022);

    if(daemonize) {
	if (open_log_file(config.daemon.log_file, truncatelog) == -1) {
	    fprintf(stderr, "%s: Could not create log file: %s: %s.\n",
			appname, config.daemon.log_file, strerror(errno));
	    exit(EX_SOFTWARE);
	}
	dup_log_fd_to_std();
    }

    /* since all plugins have freedom of writing to stderr and stdout,
     * lets make it auto-flush
     */
    setvbuf(stderr, (char *)NULL, _IONBF, 0); 
    setvbuf(stdout, (char *)NULL, _IONBF, 0); 

#ifdef _ENABLE_CYGWIN

    log_message(LG_MSG, "Starting %s-%s\n", mybasename(argv[0]), VERSION);

#else	/* _ENABLE_CYGWIN */

    log_message(LG_MSG, "Starting %s-%s with glibc: %s\n", mybasename(argv[0]),
						VERSION, gnu_get_libc_version());
#endif	/* _ENABLE_CYGWIN */

    /* now onwards remember to close log_file before leaving */
    if (parse_conf_file(config.daemon.config_file) != 0) {
	fprintf(stderr,	"%s: Parsing errors in file '%s'.\n", appname, config.daemon.config_file);
	exit(EX_SOFTWARE);
    }

    /* check for validity of configuration */
    if (checkConfig() != 0) {
	fprintf(stderr, "%s: Invalid configuration, Check the logfile '%s' for errors\n",
				    			appname, config.daemon.log_file);
	exit(EX_SOFTWARE);
    }

    if (daemonize) {
	watch_child(argc, argv);
	dup_log_fd_to_std();
    }

    /* create the listener socket(s) here */

    /* creating pid file */
    log_message(LG_INFO, "Creating PID file: %s\n", config.daemon.pid_file);
    if (pidfile_create(config.daemon.pid_file) < 0) {
	fatal("Could not create PID file.");
    }

    /*
     * Switch to a different user.
     */
    config.daemon.effectiveUserID = -1;
    config.daemon.effectiveGroupID = -1;

    if (geteuid() == 0) {
	if (NULL != config.daemon.username) {
	    struct passwd *pwd = getpwnam(config.daemon.username);
	    if (NULL == pwd) {
		log_message(LG_ERR, "getpwnam failed to find userid"\
			" for effective user '%s'\n", config.daemon.username);
		exit(EX_NOUSER);
	    }
	    config.daemon.effectiveUserID = pwd->pw_uid;
	    config.daemon.effectiveGroupID = pwd->pw_gid;
	}
	if (NULL != config.daemon.group) {
	    struct group *grp = getgrnam(config.daemon.group);
	    if (NULL == grp) {
		log_message(LG_ERR, "getgrnam failed to find groupid"\
		    " for effective group '%s'\n", config.daemon.group);
		exit(EX_NOUSER);
	    }
	    config.daemon.effectiveGroupID = grp->gr_gid;
	}
	if (config.daemon.effectiveUserID == -1 || config.daemon.effectiveGroupID == -1) {
	    log_message(LG_MSG, "%s is running as root. This can be dangerous."\
				"Please provide valid 'User' and 'Group' "\
				"in config file\n", appname);
	} else {
	    leave_suid();
	}
    } else {
	config.daemon.effectiveUserID = geteuid();
	config.daemon.effectiveGroupID = getegid();
	log_message(LG_MSG, "Not running as root, so not changing UID/GID.\n");
    }

    /* setup the signal handlers */
    set_signal_handlers();

    /* lets set the alarm for household works */
    //alarm(INTERVAL);

    if(!config.daemon.enable_coredump) {
	log_message(LG_INFO, "Disable core dumps\n");
	if(disable_coredump() < 0) {
	    log_message(LG_ERR, "disable_coredump: failed: %s\n", strerror(errno));
    	}

#ifdef _ENABLE_BT

	if (setup_bt(sigsegv_dump, NULL) != 0) {
            log_message(LG_CRIT, "setup_bt: failed: %s\n", strerror(errno));
	}

#endif /* _ENABLE_BT */

    }

    if(init_network() == -1) {
	return -1;
    }

#ifdef _ENABLE_CLOCKEVENT
    if(init_clockevent() == -1) {
	return -1;
    }
#endif /* _ENABLE_CLOCKEVENT */

    log_message(LG_MSG, "Daemon initialization complete\n");
    //--   svc_init("garner");
    //--   svc_set_status(SVC_RUNNING);

    /* allocate standard events */
    config.daemon.searray = calloc(config.daemon.searray_initial_len, sizeof(struct _std_event));

    /* parent remains in this loop, until shutdown */
    parent_main();

    garner_shutdown();
    return 0;
}

/*
 * This calls up appropriate routines based on the name.
 */
int
main(int argc, char **argv)
{
    return garner_main(argc, argv);
}

void
garner_assert(const char *msg, const char *file, int line)
{
    log_message(LG_MSG, "file: %s:%d, Assertion '%s' failed\n", file, line, msg);
    fprintf(stderr, "%s:%d, Assertion '%s' failed\n", file, line, msg);
    abort();
}

void
garner_exit(const char *msg, const char *file, int line)
{
    log_message(LG_MSG, "file: %s:%d, exiting b'coz '%s'\n", file, line, msg);
    fprintf(stderr, "file: %s:%d, exiting b'coz '%s'\n", file, line, msg);
    abort();
}

void
free_exprnode(struct _exprnode *node)
{
    if(!node) {
	return;
    }

    if(node->callback.free) {
	node->callback.free(node->callback.data);
    }

    free_exprnode(node->left);
    free_exprnode(node->right);
    free(node);
}

/* prototype */
void free_act_cond(struct _act_cond *list);

void
free_condition(struct _condition *condition)
{
    xassert(condition != NULL);
    free_exprnode(condition->exprnode);
    free_act_cond(condition->child_ac_list);
}

void
free_action(struct _action *action)
{
    if(!action)
        return;

    switch(action->type) {
        /* body actions */
        case ACTION_CALL:
	    xassert(action->args == NULL);
	    /* here args is output plugin and we need not free it */
	    log_message(LG_INFO, "free_action: CALL\n");
	    break;

        case ACTION_RETURN:
	    log_message(LG_INFO, "free_action: RETURN\n");
	    break;

        default:
            xassert(0);
    }
}

void
free_act_cond(struct _act_cond *list)
{
    struct _act_cond *next;
    while(list) {
	switch(list->type) {
	    case ACTION:
		free_action(&list->un.action);
		break;
	    case CONDITION:
		free_condition(&list->un.condition);
		break;
	    default:
		xassert(0);
	}
	next = list->next;
	free(list);
	list = next;
    }
}

struct _exprnode*
new_exprnode(char op)
{
    struct _exprnode *exprnode;
    exprnode = calloc(1, sizeof(struct _exprnode));
    exprnode->op = op;
    return exprnode;
}


struct _act_cond* new_act_cond()
{
    return calloc(1, sizeof(struct _act_cond));
}

void
unload_input_library(struct _input_plugin *input)
{
    xassert(input != NULL);
    if(input->dlhandle) {
	dlclose(input->dlhandle);
	input->dlhandle = NULL;
    }
}

int
load_input_library(struct _input_plugin *input)
{
    char libname[128];
    void *input_handle ;

    xassert(input != NULL);
    xassert(input->dlhandle == NULL);

    input->dlhandle = dlopen(input->library, RTLD_LAZY);
    if (!input->dlhandle) {
	log_message(LG_ERR, "dlopen failed: %s\n", dlerror());
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_init", input->libprefix);
    input->libname_init = dlsym(input->dlhandle, libname);
    if(!input->libname_init) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_input_library(input);
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_close", input->libprefix);
    input->libname_close = dlsym(input->dlhandle, libname);
    if(!input->libname_close) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_input_library(input);
	return -1;
    }

    if (config.daemon.test_plugin) {
	/* now call the init routine of the library */
        if(input->libname_init(input->argstring, STD_EVENT_VERSION, &input_handle) != 0) {
            log_message(LG_ERR, "%s: %s: failed\n", input->library, libname);
            unload_input_library(input);
            return -1;
        }
        /* call close routine to close plugin instance opened in init */
        input->libname_close(input_handle) ;
    }

    snprintf(libname, sizeof(libname), "%s_input", input->libprefix);
    input->libname_input = dlsym(input->dlhandle, libname);
    if(!input->libname_input) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_input_library(input);
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_debug", input->libprefix);
    input->libname_debug = dlsym(input->dlhandle, libname);
    if(!input->libname_debug) {
	/* debug routines are not mandatory */
    }

    return 0;
}

void
unload_output_library(struct _output_plugin *output)
{
    xassert(output != NULL);
    /* call to free plugin's private data if any */

    if(output->plugin_handle && output->libname_close){
        output->libname_close(output->plugin_handle) ;
        output->plugin_handle=NULL;
    }

    if(output->dlhandle) {
	dlclose(output->dlhandle);
	output->dlhandle = NULL;
    }
}

int
load_output_library(struct _output_plugin *output)
{
    char libname[128];

    xassert(output != NULL);
    xassert(output->dlhandle == NULL);

    output->dlhandle = dlopen(output->library, RTLD_LAZY);
    if (!output->dlhandle) {
	log_message(LG_ERR, "dlopen failed: %s\n", dlerror());
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_init", output->libprefix);
    output->libname_init = dlsym(output->dlhandle, libname);
    if(!output->libname_init) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_output_library(output);
	return -1;
    }

    /* now call the init routine of the library  */
    if(output->libname_init(output->argstring, STD_EVENT_VERSION,
					 &output->plugin_handle) != 0) {
	log_message(LG_ERR, "%s: %s: failed\n", output->library, libname);
	unload_output_library(output);
	return -1;
    }
	
    snprintf(libname, sizeof(libname), "%s_close", output->libprefix);
    output->libname_close = dlsym(output->dlhandle, libname);
    if(!output->libname_close) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_output_library(output);
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_output", output->libprefix);
    output->libname_output = dlsym(output->dlhandle, libname);
    if(!output->libname_output) {
	log_message(LG_ERR, "dlsym(%s) failed: %s\n", libname, dlerror());
	unload_output_library(output);
	return -1;
    }

    snprintf(libname, sizeof(libname), "%s_event", output->libprefix);
    output->libname_event = dlsym(output->dlhandle, libname);
    if(!output->libname_event) {
	/* event routines are not mandatory */
    }

    snprintf(libname, sizeof(libname), "%s_debug", output->libprefix);
    output->libname_debug = dlsym(output->dlhandle, libname);
    if(!output->libname_debug) {
	/* debug routines are not mandatory */
    }

    return 0;
}

void
free_input_plugin(struct _input_plugin *list)
{
    struct _input_plugin *input, *next;
    for(input=list; input; input=next) {
	free(input->ident);
	free(input->library);
	free(input->libprefix);
	free(input->argstring);
	unload_input_library(input);
	next = input->next;
	free(input);
    }
}

void
free_output_plugin(struct _output_plugin *list)
{
    struct _output_plugin *output, *next;
    for(output=list; output; output=next) {
	free(output->opname);
	free(output->library);
	free(output->libprefix);
	free(output->argstring);
	unload_output_library(output);
	next = output->next;
	free(output);
    }
}
