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

#ifndef _CYBEROAM_OP_ARCHIEVER_UTILS_H_
#define _CYBEROAM_OP_ARCHIEVER_UTILS_H_

#include "../../../src/std_event.h"
#include "format.h"

/* compare returns 0 if condition is true
 *                 non-zero if condition is false
 * compare should be called with std_event and corresponding argument
 */


/* Define boolean values */
#ifndef FALSE
#define FALSE 0
#define TRUE (!FALSE)
#endif

enum log_level_t {
    ARCH_LG_EMG,
    ARCH_LG_ALERT,
    ARCH_LG_CRIT,
    ARCH_LG_ERR,
    ARCH_LG_WARN,
    ARCH_LG_NOTICE,
    ARCH_LG_INFO,
    ARCH_LG_DEBUG
} ;

#define xassert(EX)  ((EX)?((void)0):archiever_assert(#EX, __FILE__, __LINE__))

extern void arch_log_msg(int, char*, ...) __attribute__((format(printf, 2, 3)));
extern int archiever_parse_conffile(const char *conf_file);
void archiever_cleanup_parsed_state(void);

int rotate_unrotated_archievefiles(struct _logger *logger) ;
void rotate_archievefile(void *arg);
int do_archieve(struct _archiever *arc, struct _std_event *se) ;
void archiever_assert(const char *msg, const char *file, int line);

#endif
