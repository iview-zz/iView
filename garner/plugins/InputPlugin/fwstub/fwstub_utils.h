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

#ifndef _CYBEROAM_FWSTUB_UTILS_H
#define _CYBEROAM_FWSTUB_UTILS_H

#include "../../../src/std_event.h"


struct _se_vars_fws {
    int (*typecast)(struct _se_vars_fws *, struct _std_event *, void *);
    int (*typecast_st)(char *,struct _se_vars_fws *, struct _std_event *, char *);
    char *type;
    char *variable;
    int offset;
};

extern int fwstub_typecast_u_int32_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_u_int16_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_u_int8_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_int32_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_date_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_char_array(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_ipaddr_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);
extern int fwstub_typecast_direction_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv);

extern int fwstub_typecast_str_u_int32_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_u_int16_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_u_int8_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_int32_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_date_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_char_array(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_ipaddr_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);
extern int fwstub_typecast_str_direction_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string);

#endif
