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

#ifndef SKEIN_LOG_H
#define SKEIN_LOG_H
#include <stdio.h>

/*
 * Okay, I have modelled the levels for logging off the syslog() interface.
 * However, I would really prefer if only six of the levels are used. You
 * can see them below and I'll describe what each level should be for.
 * Hopefully webcat will remain consistent with these levels.
 *	-- vinod
 */
enum {
	LG_MSG,     /* always display this message e.g. webcat start & end */
	LG_CRIT,    /* critical conditions */
	LG_ERR,     /* error conditions */
	LG_NOTICE,  /* normal, but significant, condition */
	LG_INFO,    /* informational message */
	LG_DEBUG,   /* debug-level message */
	LG_MAX	    /* should always come last, has no special meaning */	
};

#define CLIDEBUGNAME "CLI"
#define SERDEBUGNAME "SER"
#define FILDEBUGNAME "FIL"
#define READCHAR '<'
#define WRITECHAR '>'

extern int open_log_file(const char*, int);
extern void close_log_file(void);
extern void truncate_log_file(void);

extern void monitor_logsize(void);

extern void toggle_log_level();

extern void log_message(int, char*, ...) __attribute__((format(printf, 2, 3)));
extern void log_messageu(int, u_int32_t, char *, ...) __attribute__((format(printf, 3, 4)));
extern void log_io(int level, const char *peername, char inout, const char *buffer, int buflen);
extern void log_iou(int level, u_int32_t uniqueid, const char *peername, char inout, const u_int8_t *buffer, int buflen);
extern void set_log_level(int level);
void dup_log_fd_to_std(void);

inline int get_log_level_from_string(const char *string);
inline int fill_time_string(char *time_string, int len);

#endif
