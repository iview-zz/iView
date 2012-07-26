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

#ifndef _CYBEROAM_OP_OPPOSTGRES_CONFIG_H_
#define _CYBEROAM_OP_OPPOSTGRES_CONFIG_H_

#include <sys/types.h>
#include "libpq-fe.h"

#define PLUGIN_NAME "OPPOSTGRES"
#define MAX_LEN 2048

#define CONFIG_DEFAULT_DATABASE_NAME "iView"
#define	CONFIG_DEFAULT_SERVER_ADDR "127.0.0.1"
#define CONFIG_DEFAULT_RECONNECT_INTERVAL_SEC	10

#define __FO(type, field)  ((u_int32_t)&(((type *)0)->field))
#define __ROUTINES(TYPE) pg_initparam_##TYPE, pg_setparam_##TYPE, pg_printparam_##TYPE  

struct _table_format {
    char *cname; /* column name */	
    void *data;  /* pointer to string or struct _std_event_vars */
    unsigned long datalen;  /* non-zero if string, will also serve as Type */

    /*  to store temporary information for param binding in 
     *	prepared statements.
     */
    char *tmp;
    unsigned long tmplen;

    struct _table_format *next;
};

struct _std_event_vars_pg {
    int (*initparam) (struct _table_format *tf, Oid *param_type, int *param_length, 
						int *param_format, char **param_value);
    int (*setparam) (struct _table_format *tf, char **param_value_ptr, void *data);
    int (*printparam) (struct _table_format *tf, void *data);
    char *type;
    char *variable;
    int offset;
    union _tmp_data {
	u_int64_t int8_data;
	u_int32_t int4_data;
	u_int16_t int2_data;
    } un ;
};


struct _table {
    char *name;	/* identifier for instance of this structure */
    char *table_name ;	/* use at runtime to store table-name */
    char *createquery;	/* part of create table query */
    char *insertquery;	/* part of instert into table query */

    char *tblavailable;	/* available queue tablename */
    char *tblused ;	/* used queue tablename */

    //char *prepared_stmt_name; /* prepared statement name */
    Oid	*param_types;	 /* parameter type array pointer */
    char **param_values; /* parameter values array pointer */
    int	*param_lengths;	 /* parameter lenghts array pointer */
    int	*param_formats;	 /* parameter format array pointer */

    struct _table_format *tableformat;	

    u_int32_t column_count ;	/* number of columns in table */
    u_int32_t rotation_period ;	/* periodic rotation interval(in seconds) */
    u_int32_t max_records ;	/* maximum records in table */
    u_int32_t record_count ;	/* to track number of records inserted	*/

    u_int32_t uncommitted_record_count ; /* to track number of uncommitted records */
    u_int32_t max_uncommitted_records ;	/* maximum uncommitted records */

    u_int8_t table_state; /* 0 - needs to be cteated ; 1 - already created */

    struct _table *next;
};

struct _db {
    char *db_name ;	/* database to be used */
    PGconn *db_handle;	/* POSTGRES database connection handler */
    u_int8_t db_state;	/* 0 - not connected ; 1 - connected */
    u_int32_t last_connection_time;
};

#define DB_CONNECTED_MASK 0x01
#define IS_DB_CONNECTED(db) (db->db_state & DB_CONNECTED_MASK)
#define SET_DB_CONNECTED_FLAG(db) (db->db_state |= DB_CONNECTED_MASK)
#define RESET_DB_CONNECTED_FLAG(db) (db->db_state &= ~DB_CONNECTED_MASK)

#define TABLE_CREATED_MASK 0x01
#define IS_TABLE_CREATED(table) (table->table_state & TABLE_CREATED_MASK)
#define SET_TABLE_CREATED_FLAG(table) (table->table_state |= TABLE_CREATED_MASK)
#define RESET_TABLE_CREATED_FLAG(table) (table->table_state &= ~TABLE_CREATED_MASK)

/* prototype */
const struct _std_event_vars_pg *get_var_by_name_pg(const char *name);

void config_set_server_addr(char *server_addr);
char *config_get_server_addr(void);
void config_set_server_port(char *server_port);
char *config_get_server_port(void);
void config_set_connect_options(char *connect_options);
char *config_get_connect_options(void);
void config_set_database_name(char *db_name);
char *config_get_database_name(void);
void config_set_username(char *username);
char *config_get_username(void);
void config_set_password(char *password);
char *config_get_password(void);
void config_set_reconnect_interval(u_int32_t interval_sec);
u_int32_t config_get_reconnect_interval(void);

struct _table *new_table();
struct _table *get_table_by_name(char *name);
void insert_table_in_list(struct _table *table);
void free_table_list();
int init_table_list();

struct _table_format *prepare_table_format(char *string);
void free_table_format(struct _table_format *table_format);

void oppostgres_cleanup_parsed_state();

#endif	/* _OP_OPPOSTGRES_CONFIG_H_ */
