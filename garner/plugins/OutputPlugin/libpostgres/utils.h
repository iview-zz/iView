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

#ifndef _CYBEROAM_OP_OPPOSTGRES_UTILS_H_
#define _CYBEROAM_OP_OPPOSTGRES_UTILS_H_

#include "../../../src/std_event.h"

/* compare returns 0 if condition is true
 * non-zero if condition is false
 * compare should be called with std_event and corresponding argument
 */


/* Define boolean values */
#ifndef FALSE
#define FALSE 0
#define TRUE (!FALSE)
#endif

enum log_level_t {
    LG_EMG,
    LG_ALERT,
    LG_CRIT,
    LG_ERR,
    LG_WARN,
    LG_NOTICE,
    LG_INFO,
    LG_DEBUG
} ;

#define xassert(EX)  ((EX)?((void)0):oppostgres_assert(#EX, __FILE__, __LINE__))

void oppostgres_log_msg(int, char*, ...) __attribute__((format(printf, 2, 3)));
extern int oppostgres_parse_conffile(const char *conf_file);

void oppostgres_assert(const char *msg, const char *file, int line);

#endif
