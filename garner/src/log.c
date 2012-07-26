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

#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>
#include "garner.h"
#include "log.h"

static char *log_string[] = {
	"MESSAGE",
	"CRITICAL",
	"ERROR",
	"NOTICE",
	"INFO",
	"DEBUG",
	"MAX"
};

#define TIME_LENGTH 16
#define STRING_LENGTH 1024

/*
 * Global file descriptor for the log file
 */
static int log_file_fd=STDOUT_FILENO;

/*
 * Store the log level setting to MSG, which is the least level.
 */
static int log_level=LG_NOTICE;

/*
 * Used to toggle the log-level, e.g. webcat -k debug
 */
static int configured_log_level=0;

/*
 * Open the log file and store the file descriptor in a global location.
 */
int
open_log_file(const char* log_file_name, int truncatefile)
{
    u_int32_t flags;
    flags = O_CREAT|O_WRONLY|O_APPEND;
    
    if(truncatefile) {
	flags |= O_TRUNC;
    }
    log_file_fd = open(log_file_name, flags, 0666);
    return log_file_fd;
}

/*
 * Close the log file
 */
void
close_log_file(void)
{
    close(log_file_fd);
}

static int duped;
void
dup_log_fd_to_std(void)
{
    int old_fd;
    if(log_file_fd == STDOUT_FILENO)
	return;
    duped = 1;
    dup2(log_file_fd, STDOUT_FILENO);
    dup2(log_file_fd, STDERR_FILENO);
    /* now we have stderr and stdout pointing to our log */
    /* close the original log file */
    old_fd = log_file_fd;
    log_file_fd = STDOUT_FILENO;
    close(old_fd);
}

/*
 * Truncate log file to a zero length.
 */
void
truncate_log_file(void)
{
    if(duped) {
	xassert(log_file_fd == STDOUT_FILENO);
	lseek(STDOUT_FILENO, 0, SEEK_SET);
	lseek(STDERR_FILENO, 0, SEEK_SET);
    } else {
	lseek(log_file_fd, 0, SEEK_SET);
    }
    ftruncate(log_file_fd, 0);
}

//#define LOG_TRUNCATE_LIMIT 524288000 /* 500 MB */
#define LOG_TRUNCATE_LIMIT (1.5*1024*1024*1024) /* 1.5 GB */

void
monitor_logsize(void)
{
	struct stat sbuf;
	if(fstat(log_file_fd, &sbuf) == 0) {
		if(sbuf.st_size > LOG_TRUNCATE_LIMIT) {
			truncate_log_file();
			log_message(LG_MSG, "-----------------Log file truncated-------------\n");
		}
	}
	else {
		log_message(LG_CRIT, "monitor_logsize: fstat failure with logfile.");
	}
}

/*
 * Set the log level for writing to the log file. Is called while parsing.
 */
void
set_log_level(int level)
{
    configured_log_level = log_level = level;
}

/*
 * Get the log level from string
 */
int
get_log_level_from_string(const char *string)
{
    int i;
    for(i=0; i < sizeof(log_string)/sizeof(char*); i++) {
	if(strcasecmp(string, log_string[i]) == 0) {
	    return i;
	}
    }
    return 0;
}

/*
 * -k debug calls this, to toggle the logging level.
 */
void
toggle_log_level()
{
	if(log_level == LG_MAX)
		log_level = configured_log_level;
	else
		log_level = LG_MAX;

	if(log_file_fd >= 0)
	    log_message(LG_MSG, "Toggling log level to: %s\n", log_string[log_level]);
}

inline int
fill_time_string(char *time_string, int len)
{
    time_t nowtime;
    struct tm result;
    
    nowtime = time(NULL);
    /* Format is month day hour:minute:second (24 time) */
    return strftime(time_string, len, "%b %d %H:%M:%S",
	     localtime_r(&nowtime, &result));
}

/*
 * log_file_fd should have been initialized before this.
 * This routine logs messages to either the log file or the syslog function.
 */
void
log_messageu(int level, u_int32_t uniqueid, char *fmt, ...)
{
    int n;
    char *msg;
    va_list args;

    char time_string[TIME_LENGTH];
    char str[STRING_LENGTH];

    if(level > log_level) {
	return;
    }
    va_start(args, fmt);

    fill_time_string(time_string, TIME_LENGTH);

    n = snprintf(str, STRING_LENGTH, "%-9s %s [0x%x]: ",
	    log_string[level], time_string, uniqueid);

    msg = str + n;
    n  += vsnprintf(msg, STRING_LENGTH-n, fmt, args);

    /* maximum size that could be filled in str will be STRING_LENGTH,
     * now if vsnprintf has overflown, it will return a value greater
     * than this. So make it proper.
     */
    if(n >= STRING_LENGTH) {
	/* last char is '\0', we need not write it,
	 * we add ... at the end to indicate an overflow
	 */
	strcpy(str+STRING_LENGTH-6, " ...\n");
	n = STRING_LENGTH-1;
    }
    write(log_file_fd, str, n);

    va_end(args);
}

void
log_message(int level, char *fmt, ...)
{
    int n;
    char *msg;
    va_list args;

    char time_string[TIME_LENGTH];
    char str[STRING_LENGTH];

    if(level > log_level) {
	return;
    }
    va_start(args, fmt);

    fill_time_string(time_string, TIME_LENGTH);

    n = snprintf(str, STRING_LENGTH, "%-9s %s [%lu]: ",
	    log_string[level], time_string, (long int) pthread_self());

    msg = str + n;
    n  += vsnprintf(msg, STRING_LENGTH-n, fmt, args);

    /* maximum size that could be filled in str will be STRING_LENGTH,
     * now if vsnprintf has overflown, it will return a value greater
     * than this. So make it proper.
     */
    if(n >= STRING_LENGTH) {
	/* last char is '\0', we need not write it,
	 * we add ... at the end to indicate an overflow
	 */
	strcpy(str+STRING_LENGTH-6, " ...\n");
	n = STRING_LENGTH-1;
    }
    write(log_file_fd, str, n);

    va_end(args);
}

void
log_io(int level, const char *peername, char inout, const char *buffer, int buflen)
{
    int n;

    char time_string[TIME_LENGTH];
    char str[STRING_LENGTH];

    if(level > log_level) {
	return;
    }

    fill_time_string(time_string, TIME_LENGTH);

    n = snprintf(str, STRING_LENGTH, "%-9s %s [%lu]: %s %c ",
	    log_string[level], time_string, (long int) pthread_self(), peername, inout);

    write(log_file_fd, str, n);
    write(log_file_fd, buffer, buflen);
}

void
log_iou(int level, u_int32_t uniqueid, const char *peername, char inout, const u_int8_t *buffer, int buflen)
{
    int n;

    char time_string[TIME_LENGTH];
    char str[STRING_LENGTH];

    if(level > log_level) {
	return;
    }

    fill_time_string(time_string, TIME_LENGTH);

    n = snprintf(str, STRING_LENGTH, "%-9s %s [0x%x]: %s %c ",
	    log_string[level], time_string, uniqueid, peername, inout);

    write(log_file_fd, str, n);
    write(log_file_fd, buffer, buflen);
}

#ifdef TEST_LOG
void*
thread_run(void* data)
{
	int i=0;
	char buffer[1024];
	for(;i<10240;i++) {
		sprintf(buffer, "vinod-%d END\n", i);
		log_message(LG_INFO, buffer);
	}
	return NULL;
}

#define NOTHR 5
int
main()
{
	int i;
	pthread_t th[NOTHR];
	set_log_level(LG_DEBUG);
	if( open_log_file("/tmp/pitaji.log") < 0) {
		fprintf(stderr, "could not open file\n");
		exit(0);
	}
	for(i=0; i< NOTHR; i++)
		pthread_create(&th[i], NULL, thread_run, NULL);

	for(i=0; i< NOTHR; i++)
		pthread_join(th[i], NULL);
	truncate_log_file();
	close_log_file();
	return 0;
}
#endif
