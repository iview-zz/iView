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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include "../../../src/std_event.h"
#include "libpq-fe.h"
#include "oppgtrigger_db.h"
#include "config.h"
#include "utils.h"
#include "oid-types.h"

#define	OPPGTRIGGER_DEFAULT_CONNECT_TIMEOUT	"2"

#if TEST_SYNC
static int
process_pgsql_query(PGconn *conn_handle, char *query, PGresult  **r_set)
{
    PGresult *res = NULL;

    res = PQexec(conn_handle, query);
    if((PQresultStatus(res) == PGRES_TUPLES_OK) || (PQresultStatus(res) == PGRES_COMMAND_OK) ){
	/* query executed successfully */
	if(r_set) {
	    /* return result_set to caller. caller will be responsible to free it */
	    *r_set = res ;
        } else {
            /* caller is not interested in result. Just free result set */
            PQclear(res);
        }
    } else {
	/* query failed */
	oppgtrigger_log_msg(LG_ERR, "process_pgsql_query: query '%s' execution failed: %s\n", 
							query, PQerrorMessage(conn_handle));
	PQclear(res);	
	return -1;
    }
    return 0;
}
#endif

static int
send_async_pgsql_query(PGconn *conn_handle, struct _trigger *trigger)
{
    int ret;

    ret = PQsendQuery(conn_handle, trigger->query);
    if(ret == 0) {
	/* query failed */
	oppgtrigger_log_msg(LG_ERR, "send_async_pgsql_query: %s: query '%s' execution failed: %s\n", 
					trigger->name, trigger->query, PQerrorMessage(conn_handle));
	return -1;
    }
    PQflush(conn_handle);

    return 0;
}

static int
get_async_pgsql_query_result(PGconn *conn_handle, struct _trigger *trigger, PGresult  **r_set)
{
    PGresult *res = NULL;

    while((res = PQgetResult(conn_handle))) {
	if((PQresultStatus(res) == PGRES_TUPLES_OK) || (PQresultStatus(res) == PGRES_COMMAND_OK) ){			
	    /* query executed successfully */
	    oppgtrigger_log_msg(LG_DEBUG, "get_async_pgsql_query_result: %s: last trigger execution completed\n", 
												trigger->name);
	    if(r_set) {
		/* return result_set to caller. caller will be responsible to free it */
		*r_set = res ;
	    } else {
		/* caller is not interested in result. Just free result set */
		PQclear(res);
	    }
	} else {
	    /* query failed */
	    oppgtrigger_log_msg(LG_DEBUG, "get_async_pgsql_query_result: %s: last trigger execution failed: %s\n", 
									trigger->name, PQerrorMessage(conn_handle));
	    PQclear(res);	
	}
    }
    return 0;
}

static PGconn *
do_pgsql_server_connect(void)
{
    PGconn *conn_handle = NULL;

#if 0
    //--------- FOR TESTING --------------	
    char conninfo[1024];
    int	ci_len;
	
    ci_len = snprintf(conninfo, sizeof(conninfo), 
			"hostaddr=%s port=%s dbname=%s user=%s password=%s connect_timeout=%s",
			pgtrigger_config_get_server_addr(),
			pgtrigger_config_get_server_port(), 
			pgtrigger_config_get_database_name(), 
			pgtrigger_config_get_username(), 
			pgtrigger_config_get_password(),
			OPPGTRIGGER_DEFAULT_CONNECT_TIMEOUT);
				
	if(ci_len >= sizeof(conninfo)) {
        oppgtrigger_log_msg(LG_ERR,"do_pgsql_server_connect: conninfo string truncated\n");
        return NULL;
    }
    oppgtrigger_log_msg(LG_DEBUG,"do_pgsql_server_connect: conninfo string '%s'\n", conninfo);

    conn_handle = PQconnectdb(conninfo);
    if (PQstatus(conn_handle) != CONNECTION_OK) {
	oppgtrigger_log_msg(LG_ERR, "do_pgsql_server_connect: Connect failed: %s\n", PQerrorMessage(conn_handle));
	PQfinish(conn_handle);
	return NULL;
    }
#endif

    if(setenv("PGCONNECT_TIMEOUT", OPPGTRIGGER_DEFAULT_CONNECT_TIMEOUT, 1)) {
    	oppgtrigger_log_msg(LG_ERR, "do_pgsql_server_connect: Environment Variable PGCONNECT_TIMEOUT init failed\n");
	return NULL;
    }

/*
    oppgtrigger_log_msg(LG_DEBUG, "do_pgsql_server_connect: Evironment Variable PGCONNECT_TIMEOUT: %s\n", 
										getenv("PGCONNECT_TIMEOUT"));
*/

    /* Make a connection to the database */
    conn_handle = PQsetdbLogin(	pgtrigger_config_get_server_addr(), 
				pgtrigger_config_get_server_port(), 
				pgtrigger_config_get_connect_options(), 
				NULL, 
				pgtrigger_config_get_database_name(), 
				pgtrigger_config_get_username(), 
				pgtrigger_config_get_password() );
    /* Check to see that the backend connection was successfully made */
    if (PQstatus(conn_handle) != CONNECTION_OK) {
	oppgtrigger_log_msg(LG_ERR, "do_pgsql_server_connect: Connect failed: %s\n", PQerrorMessage(conn_handle));
	PQfinish(conn_handle);
	return NULL;
    }

    return conn_handle;
}

static void
do_pgsql_server_disconnect(PGconn *conn_handle)
{
    PQfinish(conn_handle);
}


void
oppgtrigger_db_release_client(struct _db *db)
{
    int fd = PQsocket(db->db_handle);

    /* disconnect connection to server */
    if(IS_DB_CONNECTED(db)) {
	if(db->db_handle == NULL) {
	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_release_client: invalid Connetion State FD: %d\n", fd);
	} else {
	    do_pgsql_server_disconnect(db->db_handle);
	    db->db_handle = NULL;

	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_release_client: Database disconnected FD: %d\n", fd); 
	}
	RESET_DB_CONNECTED_FLAG(db);
    }
    return;
}

int
oppgtrigger_db_init_client(struct _db *db)
{
#if 0
    u_int32_t	time_diff, now;
    u_int32_t	reconnect_interval = pgtrigger_config_get_reconnect_interval();

    now = time(NULL);
    time_diff = now - db->last_connection_time;

    oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_init_client: Last connection established before '%u' seconds\n", 
													time_diff);

    if(time_diff <= reconnect_interval ) {
        oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_init_client: database connection blocked for '%d' seconds\n",
										(reconnect_interval - time_diff) );
        return -1;
    }

    db->last_connection_time = now ;
#endif

    /* connect with server */
    db->db_handle = do_pgsql_server_connect();
    if(db->db_handle == NULL) {
        oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_init_client: server couldn't connected\n");
        return -1;
    }

    if(PQsetnonblocking(db->db_handle, TRUE) < 0) {
        oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_init_client: connection couldn't made non-blocking\n");
	oppgtrigger_db_release_client(db);
        return -1;
    }
    return 0;
}

int
oppgtrigger_db_check_status(struct _db *db, struct _trigger *trigger)
{
    oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_check_status: TRIGGER: '%s'\n", trigger->name);

    if(!IS_DB_CONNECTED(db)) {
	/* db server is not connected, it means no pending store procedure trigger */
	return 0;
    }

    if(IS_QUERY_RUNNING(trigger)) {
	if(PQconsumeInput(db->db_handle) == 0) {
	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_check_status: %s: consume result failed: %s\n", 
							trigger->name, PQerrorMessage(db->db_handle));
	    /* close database connection */
	    oppgtrigger_db_release_client(db);
    	    RESET_QUERY_RUNNING_FLAG(trigger);
	    return -1;						
	}
	if(PQisBusy(db->db_handle) == 0) {
	    /* result of last trigger query is ready, get it */ 
	    if(get_async_pgsql_query_result(db->db_handle, trigger, NULL) < 0) {
		oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_check_status: %s: execution of last trigger failed\n", 
												trigger->name);
	    } else {
		oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_check_status: %s: last trigger execution completed\n", 
													trigger->name);	
	    }
	} else {
	    /* execution of last trigger is not completed yet, so couldn't send next trigger */
	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_check_status: %s: last trigger execution is not completed yet\n", 
													trigger->name);
	    return -1;
	}
    }
	
    /* now next trigger can be send */
    RESET_QUERY_RUNNING_FLAG(trigger);
    return 0;
}

int
oppgtrigger_db_send_trigger(struct _db *db, struct _trigger *trigger)
{
    oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_send_trigger: TRIGGER: '%s'\n", trigger->name);

retry_conn:
    if(!IS_DB_CONNECTED(db)) {
	/* make new connection to database */
	if(oppgtrigger_db_init_client(db) < 0) {
	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_send_trigger: server couldn't connected TRGR: '%s'\n", 
											trigger->name);
	    return -1;
	} else {
	    /* connected to database */
	    SET_DB_CONNECTED_FLAG(db);
	    oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_send_trigger: server connected TRGR: '%s' FD: %d\n", 
								trigger->name, PQsocket(db->db_handle));
	}
    } else { /* should not be reached, as always new connection will be made for each trigger */
	/* check existing database connection */
	if(PQstatus(db->db_handle) != CONNECTION_OK) {
    	    /* connection interrupted */
	    oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_send_trigger: server connection interrupted TRGR: '%s'\n", 
												trigger->name);
	    oppgtrigger_db_release_client(db);
	    goto retry_conn;
	}
    }

    /* 
     * NOTE:
     * connection status has already been checked in oppgtrigger_db_check_status() routine,
     * so just go ahead	and execute query
     */

    if(send_async_pgsql_query(db->db_handle, trigger) < 0) {
	oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_send_trigger: %s: trigger couldn't sent\n", 
										trigger->name);
        return -1;
    }
    oppgtrigger_log_msg(LG_DEBUG, "oppgtrigger_db_send_trigger: %s: trigger sent\n", 
									trigger->name);
    /* set trigger query running flag */
    SET_QUERY_RUNNING_FLAG(trigger);

    /* execute query to trigger store procedure in Postgres Server */

#if TEST_SYNC
    if(process_pgsql_query(db->db_handle, trigger->query, NULL) < 0) {
    	oppgtrigger_log_msg(LG_ERR, "oppgtrigger_db_send_trigger: couldn't send trigger to pgsql server\n");
	return -1;
    }
#endif

    return 0;
}

