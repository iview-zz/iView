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

#ifndef _CYBEROAM_OP_POSTGRES_DB_H_
#define _CYBEROAM_OP_POSTGRES_DB_H_

#include "../../../src/std_event.h"
#include "libpq-fe.h"
#include "config.h"

int __pg_initparam_type_string(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
							int *param_format_ptr, char **param_value_ptr);
int pg_initparam_char_array(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_u_int32_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_u_int16_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_u_int8_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_direction_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_ipaddr_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_date_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);
int pg_initparam_int32_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr);

int pg_setparam_char_array(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_u_int32_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_u_int16_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_u_int8_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_direction_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_ipaddr_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_date_t(struct _table_format *tf, char **param_value_ptr, void *data);
int pg_setparam_int32_t(struct _table_format *tf, char **param_value_ptr, void *data);


int pg_printparam_char_array(struct _table_format *tf, void *data);
int pg_printparam_u_int32_t(struct _table_format *tf, void *data);
int pg_printparam_u_int16_t(struct _table_format *tf, void *data);
int pg_printparam_u_int8_t(struct _table_format *tf, void *data);
int pg_printparam_direction_t(struct _table_format *tf, void *data);
int pg_printparam_ipaddr_t(struct _table_format *tf, void *data);
int pg_printparam_date_t(struct _table_format *tf, void *data);
int pg_printparam_int32_t(struct _table_format *tf, void *data);

int init_bind_param(struct _table *table_list_head);
int init_insert_query(struct _table *table_list_head);

int init_postgres_client(struct _db *db, struct _table *table);
void release_postgres_client(struct _db *db, struct _table *table);
int  do_datainsert(struct _db *db, struct _table *table, struct _std_event *se);
void move_table_to_usedqueue(struct _db *db, struct _table *table);

#endif
