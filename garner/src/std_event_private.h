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

#ifndef _STD_EVENTS_PRIVATE_H_
#define _STD_EVENTS_PRIVATE_H_

#include <sys/types.h>

#define __FO(type, field)    ((u_int32_t)&(((type *)0)->field))
#define __ROUTINES(TYPE)   compare_##TYPE, typecast_##TYPE, free_##TYPE

struct _std_event_vars {
    int (*compare)(void*, void*, char);
    void* (*typecast)(const char*, int *);
    void (*free)(void *);
    char *type;
    char *variable;
    int offset;
};

struct _sev_data {
    const struct _std_event_vars *sev;
    void *data;
};

#include "std_event.h"

/* prototype */
const struct _std_event_vars *get_var_by_name(const char *name);
struct _sev_data *new_sev_data(const struct _std_event_vars *sev, const char *string);
void free_sev_data(void *sev_data);

int compare_std_event_var(void *se, void *arg, char op);

#endif /* _STD_EVENTS_PRIVATE_H_ */
