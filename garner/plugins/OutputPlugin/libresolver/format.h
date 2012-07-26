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

#ifndef _CYBEROAM_OP_RESOLVER_FORMAT_H_
#define _CYBEROAM_OP_RESOLVER_FORMAT_H_

#include <sys/types.h>

#include "hash_private.h"
#include "resolver_log.h"

#define __RESOLVER_FO(type, field) ((u_int32_t)&(((type *)0)->field))
#define __RESOLVER_ROUTINES(TYPE)  string_to_##TYPE, print_##TYPE

#define PLUGIN_NAME "RESOLVER"
#define MAX_LEN 2048

struct _hash_table {
    u_int8_t *key;
    u_int8_t *value;
    UT_hash_handle hh;
};

struct _field_format {
    char *cname;
    const void *data;	/* pointer to string or struct _resolver_std_event_vars */
    unsigned long field_size; 
    struct _field_format *next;
};

struct _resolver_std_event_vars {
    int (*string_to_any) (const char *, void *, const u_int32_t);
    int (*print_any) (void *, int, char *, int);
    u_int32_t field_size;
    char *type;
    char *variable;
    int offset;
};

struct _resolver {
    char *name;		/* identifier for instance of this structure */
    char *table_name ;	/* use at runtime to store table-name */
    char *database_name;
    struct _field_format *key_format;
    struct _field_format *value_format;
    u_int32_t key_len;
    u_int32_t value_len;
    struct _hash_table *hash_table;	
    struct _resolver *next;
};


extern struct _resolver *resolver_list;

/* prototype */
const struct _resolver_std_event_vars *get_var_by_name(const char *name);

struct _resolver *new_resolver();
struct _resolver *get_resolver_by_name(char *name);
void insert_resolver_in_list(struct _resolver *resolver);
void free_resolver_list();
void free_resolver(struct _resolver **resolver);

struct _field_format *prepare_field_format(char *);
void free_field_format(struct _field_format *field_format);

void resolver_cleanup_parsed_state();

#endif	
