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

#include <unistd.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <pthread.h>
#include <string.h>
#include <sys/types.h>
#include <fcntl.h>
#include <time.h>

#include "fwstub_log.h"

static char *log_str[] = {
	"MESSAGE",
	"CRITICAL",
	"ERROR",
	"NOTICE",
	"INFO",
	" ",
	"DEBUG",
	"MAX"
};

#define FWSTUB_TIME_LENGTH 16
#define FWSTUB_STRING_LENGTH 1024

/*
 * Global file descriptor for the log file
 */
static int log_fd=1;

/*
 * Store the log level setting to MSG, which is the least level.
 */
static int fwstub_log_level=FWSLG_ERR;

/*
 * Open the log file and store the file descriptor in a global location.
 */
int
fwstub_open_log_file(const char* log_file_name)
{
    log_fd = open(log_file_name, O_CREAT|O_WRONLY|O_APPEND, 0666);
    return log_fd;
}

/*
 * Close the log file
 */
void
fwstub_close_log_file(void)
{
    close(log_fd);
}


//#define LOG_TRUNCATE_LIMIT 524288000 /* 500 MB */
#define LOG_TRUNCATE_LIMIT (50*1024*1024) /* 1.5 GB */

void
fwstub_monitor_logsize(void)
{
    struct stat sbuf;

    if(fstat(log_fd, &sbuf) == 0) {
	if(sbuf.st_size > LOG_TRUNCATE_LIMIT) {
            ftruncate(log_fd, 0);
	    fwstub_log_message(FWSLG_MSG, "-----------------Log file truncated-------------\n");
	}
    } else {
	fwstub_log_message(FWSLG_CRIT, "monitor_logsize: fstat failure with logfile.");
    }
}

void
fwstub_toggle_log_level()
{
    if(fwstub_log_level == FWSLG_ERR)
	fwstub_log_level = FWSLG_DEBUG;
    else
	fwstub_log_level = FWSLG_ERR;

    if(log_fd >= 0)
        fwstub_log_message(FWSLG_MSG, "Toggling log level to: %s\n", log_str[fwstub_log_level]);
}

inline int
_fill_time_string(char *time_string, int len)
{
    time_t nowtime;
    struct tm result;
    
    nowtime = time(NULL);
    /* Format is month day hour:minute:second (24 time) */
    return strftime(time_string, len, "%b %d %H:%M:%S",
	     localtime_r(&nowtime, &result));
}

void
fwstub_log_message(int level, char *fmt, ...)
{
    int n;
    char *msg;
    va_list args;

    char time_string[FWSTUB_TIME_LENGTH];
    char str[FWSTUB_STRING_LENGTH];

    if(level > fwstub_log_level) {
	return;
    }
    va_start(args, fmt);

    if (level == FWSLG_NONE) {
      n = vsnprintf(str, FWSTUB_STRING_LENGTH, fmt, args);
      goto logmsg;
    }

    _fill_time_string(time_string, FWSTUB_TIME_LENGTH);

    n = snprintf(str, FWSTUB_STRING_LENGTH, "%-9s %s [%lu]: ",
	    log_str[level], time_string, (long int) pthread_self());

    msg = str + n;
    n  += vsnprintf(msg, FWSTUB_STRING_LENGTH-n, fmt, args);

    /* maximum size that could be filled in str will be FWSTUB_STRING_LENGTH,
     * now if vsnprintf has overflown, it will return a value greater
     * than this. So make it proper.
     */
    logmsg:
    if(n >= FWSTUB_STRING_LENGTH) {
	/* last char is '\0', we need not write it,
	 * we add ... at the end to indicate an overflow
	 */
	strcpy(str+FWSTUB_STRING_LENGTH-6, " ...\n");
	n = FWSTUB_STRING_LENGTH-1;
    }

    if (level == FWSLG_ERR) {
	fprintf(stderr,str);
    }

    write(log_fd, str, n);

    va_end(args);
}

