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
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>

#include "../../../src/std_event.h"
#include "utils.h"

#define PLUGIN_NAME "OPPOSTGRES"
#define TIME_STRING_LENGTH 32

extern enum log_level_t log_level ;

void
oppostgres_log_msg(int level, char *fmt, ...)
{
    char time_string[TIME_STRING_LENGTH];
    time_t nowtime;
    struct tm result;
    va_list args;

    if(level > log_level) {
	return;
    }

    va_start(args, fmt);

    nowtime = time(NULL);
    /* Format is month day hour:minute:second (24 time) */
    strftime(time_string, TIME_STRING_LENGTH, "%b %d %H:%M:%S", localtime_r(&nowtime, &result));
    fprintf(stdout, "%s: ", time_string);
    fprintf(stdout, "%s: ", PLUGIN_NAME);
    vprintf(fmt, args);

    va_end(args);
}

void
oppostgres_assert(const char *msg, const char *file, int line)
{
    oppostgres_log_msg(LG_ERR, "file: %s:%d, Assertion '%s' failed\n", file, line, msg);
    fprintf(stderr, "%s:%d, Assertion '%s' failed\n", file, line, msg);
    abort();
}

