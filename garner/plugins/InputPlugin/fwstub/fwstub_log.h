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

#ifndef _CYBEROAM_FWSTUB_LOG_H
#define _CYBEROAM_FWSTUB_LOG_H
#include <stdio.h>

enum {
        FWSLG_MSG,     /* always display this message e.g. webcat start & end */
        FWSLG_CRIT,    /* critical conditions */
        FWSLG_ERR,     /* error conditions */
        FWSLG_NOTICE,  /* normal, but significant, condition */
        FWSLG_INFO,    /* informational message */
        FWSLG_NONE,    /* informational message */
        FWSLG_DEBUG,   /* debug-level message */
        FWSLG_MAX           /* should always come last, has no special meaning */
};


int fwstub_open_log_file(const char* file);
void fwstub_close_log_file(void);

void fwstub_monitor_logsize(void);

void fwstub_toggle_log_level();

void fwstub_log_message(int, char*, ...) __attribute__((format(printf, 2, 3)));

inline int _fill_time_string(char *time_string, int len);

#endif

