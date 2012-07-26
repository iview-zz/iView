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

#ifndef _CYBEROAM_OP_OPPGTRIGGER_CONFIG_H_
#define _CYBEROAM_OP_OPPGTRIGGER_CONFIG_H_

#include <sys/types.h>
#include "libpq-fe.h"

#define PLUGIN_NAME "OPPGTRIGGER"
#define MAX_LEN 2048

#define OPPGTRIGGER_CONFIG_DEFAULT_DATABASE_NAME "iView"
#define	OPPGTRIGGER_CONFIG_DEFAULT_SERVER_ADDR "127.0.0.1"
#define OPPGTRIGGER_CONFIG_DEFAULT_RECONNECT_INTERVAL_SEC 10

struct _trigger {
    char *name;			/* identifier for instance of this structure */
    char *query;		/* trigger query */
    u_int32_t query_state;	/* current state of command */
    struct _trigger *next;
};

struct _db {
    PGconn *db_handle;		/* POSTGRES database connection handler */
    u_int8_t db_state;		/* 0 - not connected ; 1 - connected */
    u_int32_t last_connection_time;
} ;

#define DB_CONNECTED_MASK 0x01
#define IS_DB_CONNECTED(db) (db->db_state & DB_CONNECTED_MASK)
#define SET_DB_CONNECTED_FLAG(db) (db->db_state |= DB_CONNECTED_MASK)
#define RESET_DB_CONNECTED_FLAG(db) (db->db_state &= ~DB_CONNECTED_MASK)

#define QUERY_RUNNING_MASK 0x01
#define IS_QUERY_RUNNING(trigger) (trigger->query_state & QUERY_RUNNING_MASK)
#define SET_QUERY_RUNNING_FLAG(trigger) (trigger->query_state |= QUERY_RUNNING_MASK)
#define RESET_QUERY_RUNNING_FLAG(trigger) (trigger->query_state &= ~QUERY_RUNNING_MASK)

/* prototype */

void pgtrigger_config_set_server_addr(char *server_addr);
char *pgtrigger_config_get_server_addr(void);
void pgtrigger_config_set_server_port(char *server_port);
char *pgtrigger_config_get_server_port(void);
void pgtrigger_config_set_connect_options(char *connect_options);
char *pgtrigger_config_get_connect_options(void);
void pgtrigger_config_set_database_name(char *db_name);
char *pgtrigger_config_get_database_name(void);
void pgtrigger_config_set_username(char *username);
char *pgtrigger_config_get_username(void);
void pgtrigger_config_set_password(char *password);
char *pgtrigger_config_get_password(void);
void pgtrigger_config_set_reconnect_interval(u_int32_t interval_sec);
u_int32_t pgtrigger_config_get_reconnect_interval(void);

struct _trigger	*pgtrigger_config_new_trigger();
struct _trigger	*pgtrigger_config_get_trigger_by_name(char *name);
void pgtrigger_config_insert_trigger_in_list(struct _trigger *trigger);
void pgtrigger_config_free_trigger_list();
int  pgtrigger_config_init_trigger_list();
void pgtrigger_config_cleanup_parsed_state();

#endif	/* _OP_OPPGTRIGGER_CONFIG_H_ */
