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

#ifndef _CYBEROAM_CR_STUB_UTILS_H_
#define _CYBEROAM_CR_STUB_UTILS_H_

#include "../../../src/std_event.h"

/*#define __FO(type, field)    ((u_int32_t)&(((type *)0)->field))
#define __ROUTINES(TYPE)   crstub_cast_##TYPE
*/
#define NO_CONVERTION 0
#define GET_INDEX 1
#define PROCESS 2

typedef struct kv_map{
        char* key;
		int offset;
		int (*typecast)(const char*, u_int8_t*);
		int convert;
}kv_map;


void init_map(kv_map *, int);
int set_kv_pair(kv_map *, int, struct _std_event *, char *, char *);

/* casting functions for all available types */
int crstub_cast_u_int32_t(const char *, u_int8_t *);
int crstub_cast_u_int16_t(const char *, u_int8_t *);
int crstub_cast_u_int8_t(const char *, u_int8_t *);
int crstub_cast_date_t(const char *, u_int8_t *);
int crstub_cast_ipaddr_t(const char *, u_int8_t *);
int crstub_cast_direction_t(const char *, u_int8_t *);
int crstub_cast_char_array(const char *, u_int8_t *);
int crstub_cast_int32_t(const char *, u_int8_t *);

#endif
