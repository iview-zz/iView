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

#ifdef FD_SETSIZE
#undef FD_SETSIZE
#endif
#define FD_SETSIZE 1024

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <errno.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include "../../../src/std_event.h"
#include "libpq-fe.h"
#include "postgres_db.h"
#include "config.h"
#include "utils.h"
#include "oid-types.h"

#define	OPPOSTGRES_DEFAULT_CONNECT_TIMEOUT "2"

int
__pg_initparam_type_string(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev; 
	
    sev = (struct _std_event_vars_pg *)tf->data;
    *param_type_ptr = VARCHAROID;
    *param_length_ptr = 0;
    *param_format_ptr = 0;

    return 0;
}

int
pg_initparam_char_array(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev;

    sev = (struct _std_event_vars_pg *)tf->data;

    *param_type_ptr = VARCHAROID;
    *param_length_ptr =	0;
    *param_format_ptr =	0;

    oppostgres_log_msg(LG_DEBUG, "pg_initparam_char_array: column name: %s, type: %d, length: %d, format: %d\n", 
						tf->cname, *param_type_ptr, *param_length_ptr, *param_format_ptr);
    return 0;
}

int 
pg_setparam_char_array(struct _table_format *tf, char **param_value_ptr, void *data)
{
    *param_value_ptr = (char *) data;

    //tf->tmplen = strlen(*param_value_ptr);
    oppostgres_log_msg(LG_DEBUG, "pg_setparam_char_array: column name: %s, value: %s\n", 
							tf->cname, *param_value_ptr);
    return 0;
}

int 
pg_printparam_char_array(struct _table_format *tf, void *data)
{
    oppostgres_log_msg(LG_ERR, "pg_printparam_char_array: column name: %s, value: %s\n", 
								tf->cname, (char *) data);
    return 0;
}

int
pg_initparam_u_int32_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev;

    sev = (struct _std_event_vars_pg *)tf->data;

    *param_value_ptr = (char *) &(sev->un.int8_data);
    *((u_int32_t *)*param_value_ptr) = 0;

    *param_type_ptr = INT8OID;
    *param_length_ptr =	8;
    *param_format_ptr =	1;	
	
    return 0;
}

int 
pg_setparam_u_int32_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    //*param_value_ptr = (char *) data;

    *((u_int32_t *)*param_value_ptr + 1) = htonl(*(u_int32_t *) data);
    oppostgres_log_msg(LG_DEBUG, "pg_setparam_u_int32_t: column name: %s, value: %u\n", 
					tf->cname, *((u_int32_t *) *param_value_ptr + 1));
    return 0;
}

int 
pg_printparam_u_int32_t(struct _table_format *tf, void *data)
{
    oppostgres_log_msg(LG_ERR, "pg_setparam_u_int32_t: column name: %s, value: %u\n", 
							tf->cname, *(u_int32_t *) data);
    return 0;
}

int
pg_initparam_u_int16_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev;

    sev = (struct _std_event_vars_pg *)tf->data;

    *param_value_ptr = (char *) &(sev->un.int4_data);
    *((u_int16_t *)*param_value_ptr) = 0;

    *param_type_ptr = INT4OID;
    *param_length_ptr =	4;
    *param_format_ptr =	1;		

    return 0;
}

int 
pg_setparam_u_int16_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    //*param_value_ptr = (char *)data;
    *((u_int16_t *)*param_value_ptr + 1) = htons(*(u_int16_t *) data);

    oppostgres_log_msg(LG_DEBUG, "pg_setparam_u_int16_t: column name: %s, value: %u\n", 
					tf->cname, *((u_int16_t *) *param_value_ptr + 1));
    return 0;
}

int 
pg_printparam_u_int16_t(struct _table_format *tf, void *data)
{
    return pg_printparam_u_int32_t(tf, data);
}

int
pg_initparam_u_int8_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev;

    sev = (struct _std_event_vars_pg *)tf->data;

    *param_value_ptr = (char *) &(sev->un.int2_data);
    *((u_int8_t *)*param_value_ptr) = 0;

    *param_type_ptr = INT2OID;
    *param_length_ptr =	2;
    *param_format_ptr =	1;		

    return 0;
}

int
pg_setparam_u_int8_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    //*param_value_ptr = (char *)data;
    *((u_int8_t *)*param_value_ptr + 1) = *(u_int8_t *) data;

    oppostgres_log_msg(LG_DEBUG, "pg_setparam_u_int8_t: column name: %s, value: %u\n", 
					tf->cname, *((u_int8_t *) *param_value_ptr + 1));
    return 0;
}

int 
pg_printparam_u_int8_t(struct _table_format *tf, void *data)
{
    return pg_printparam_u_int32_t(tf, data);
}

int
pg_initparam_direction_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    return pg_initparam_u_int8_t(tf, param_type_ptr, param_length_ptr, param_format_ptr, param_value_ptr);
}

int
pg_setparam_direction_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    return pg_setparam_u_int8_t(tf, param_value_ptr, data);
}

int 
pg_printparam_direction_t(struct _table_format *tf, void *data)
{
    return pg_printparam_u_int32_t(tf, data);
}

int
pg_initparam_ipaddr_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
						int *param_format_ptr, char **param_value_ptr)
{
    return pg_initparam_u_int32_t(tf, param_type_ptr, param_length_ptr, param_format_ptr, param_value_ptr);
}

int
pg_setparam_ipaddr_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    return pg_setparam_u_int32_t(tf, param_value_ptr, data);
}

int 
pg_printparam_ipaddr_t(struct _table_format *tf, void *data)
{
    return pg_printparam_u_int32_t(tf, data);
}

int
pg_initparam_date_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
					int *param_format_ptr, char **param_value_ptr)
{
    return pg_initparam_u_int32_t(tf, param_type_ptr, param_length_ptr, param_format_ptr, param_value_ptr);
}

int
pg_setparam_date_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    return pg_setparam_u_int32_t(tf, param_value_ptr, data);
}

int 
pg_printparam_date_t(struct _table_format *tf, void *data)
{
    return pg_printparam_u_int32_t(tf, data);
}

int
pg_initparam_int32_t(struct _table_format *tf, Oid *param_type_ptr, int *param_length_ptr, 
					int *param_format_ptr, char **param_value_ptr)
{
    struct _std_event_vars_pg *sev;

    sev = (struct _std_event_vars_pg *)tf->data;

    *param_value_ptr = (char *) &(sev->un.int4_data);
    *param_type_ptr = INT4OID;
    *param_length_ptr =	4;
    *param_format_ptr =	1;	
    
    return 0;
}

int
pg_setparam_int32_t(struct _table_format *tf, char **param_value_ptr, void *data)
{
    //*param_value_ptr = (char *) data;
    *(u_int32_t *)*param_value_ptr = htonl(*(u_int32_t *) data);
	
    oppostgres_log_msg(LG_DEBUG, "pg_setparam_int32_t: column name:%s,  value: %d\n", 
					tf->cname, *((int32_t *) *param_value_ptr));
    return 0;
}

int
pg_printparam_int32_t(struct _table_format *tf, void *data)
{
    oppostgres_log_msg(LG_DEBUG, "pg_setparam_int32_t: column name:%s,  value: %d\n", 
						tf->cname, *(u_int32_t *) data);
    return 0;
}

int
init_insert_query(struct _table *table_list_head)
{
    struct _table *table;
    struct _table_format *tf;

    char cl_buf[MAX_LEN], tmp_buf[128], *p1, *p2 ;
    int  cl_filledb, tmp_filledb;
    char query[MAX_LEN] ;
    int ret, i, remlen;

    for(table=table_list_head; table; table=table->next) {
        oppostgres_log_msg(LG_DEBUG, "init_insert_query: for table: %s\n", table->name);
        p1 = cl_buf;
        cl_filledb = 0;
        p2 = tmp_buf;
	tmp_filledb = 0;

	/* count number of column in table */
        for(i=0, tf=table->tableformat; tf; i++, tf=tf->next) {
	    //oppostgres_log_msg(LG_DEBUG, "init_insert_query: for column: %s\n", tf->cname);
            /* append table name to buf1 */
	    remlen = sizeof(cl_buf) - cl_filledb;
	    ret = snprintf(p1, remlen, "%s,",  tf->cname);
	    if(ret >= remlen) {
		oppostgres_log_msg(LG_ERR, "init_insert_query: column name buffer overflowed\n");
		return -1;
	    }
	    p1 += ret;
	    cl_filledb += ret;
			
	    remlen = sizeof(tmp_buf) - tmp_filledb;
	    ret = snprintf(p2, remlen, "$%d,", i+1);
	    if(ret >= remlen) {
		oppostgres_log_msg(LG_ERR, "init_insert_query: column name list tmp buffer overflowed\n");
		return -1;
	    }
	    p2 += ret;
	    tmp_filledb += ret;
	}
        *(--p1) = '\0';
        *(--p2) = '\0';

	//oppostgres_log_msg(LG_DEBUG, "init_insert_query: BUF1: %s\n", cl_buf);
	//oppostgres_log_msg(LG_DEBUG, "init_insert_query: BUF2: %s\n", tmp_buf);

        table->column_count = i;
        oppostgres_log_msg(LG_DEBUG, "init_insert_query: table '%s': column count: '%d'\n",
          	                                          table->name, table->column_count);

        ret = snprintf(query, sizeof(query), "(%s) VALUES (%s) ", cl_buf, tmp_buf);
        if(ret >= sizeof(query)) {
            oppostgres_log_msg(LG_ERR,"init_insert_query: INSERT QUERY truncated\n");
	    return -1;
        }

        table->insertquery = strdup(query);
        if(!table->insertquery) {
            oppostgres_log_msg(LG_ERR, "init_insert_query: insertquery memory allocation fail\n");
            return -1;
        }
        oppostgres_log_msg(LG_DEBUG, "init_insert_query: INSERT QUERY: '%s'\n", table->insertquery);
    }
    return 0;
}

int
init_bind_param(struct _table *table_list_head)
{
    struct _table *table;
    struct _table_format *tf;

    struct _std_event_vars_pg *sev;
    Oid	*param_type_ptr	= NULL;
    char **param_value_ptr = NULL;
    int	*param_length_ptr = NULL;
    int	*param_format_ptr = NULL;

    int i;
    
    for(table=table_list_head; table; table=table->next) {
        oppostgres_log_msg(LG_DEBUG, "init_bind_param: for loop: table: %s\n", table->name);

        /* allocate memory for bind parameters */
        if(table->column_count) {
	    table->param_types = (Oid *) calloc(table->column_count, sizeof(Oid));
            if(!table->param_types) {
                oppostgres_log_msg(LG_ERR, "init_bind_param: table '%s': parameter types array allocation failed\n", 
													table->name);
                return -1;
            }

	    table->param_values = (char **) calloc(table->column_count, sizeof(char *));
            if(!table->param_values) {
                oppostgres_log_msg(LG_ERR, "init_bind_param: table '%s': parameter values array allocation failed\n", 
													table->name);
                return -1;
            }

	    table->param_lengths = (int *) calloc(table->column_count, sizeof(int));
            if(!table->param_lengths) {
                oppostgres_log_msg(LG_ERR, "init_bind_param: table '%s': parameter lenghths array allocation failed\n", 
													table->name);
                return -1;
            }

	    table->param_formats = (int *) calloc(table->column_count, sizeof(int));
            if(!table->param_formats) {
                oppostgres_log_msg(LG_ERR, "init_bind_param: table '%s': parameter formats array allocation failed\n", 
													table->name);
                return -1;
            }
        }

        /* initialize each bind parameter */
        for(i=0, tf=table->tableformat; tf; i++, tf=tf->next) {
            /* get pointer to bind parameter */
            param_type_ptr = table->param_types + i ;
            param_value_ptr = table->param_values + i ;
	    param_length_ptr = table->param_lengths + i ;
	    param_format_ptr = table->param_formats + i;

            if(tf->datalen) {
		*param_type_ptr = VARCHAROID;
		*param_value_ptr = tf->data;
		*param_length_ptr = 0;
		*param_format_ptr = 0;
            } else {
                sev = (struct _std_event_vars_pg *) tf->data;
		//oppostgres_log_msg(LG_DEBUG, "init_bind_param: pg_initparam() for variable '%s'\n", 
		//									sev->variable);
                sev->initparam(tf, param_type_ptr, param_length_ptr, param_format_ptr, param_value_ptr);
            }
        }
    }
    return 0;
}

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
	return 0;
    } else {
	/* query failed */
	oppostgres_log_msg(LG_ERR, "process_pgsql_query: query '%s' execution failed: %s\n", query, 
									PQerrorMessage(conn_handle));
	PQclear(res);	
	return -1;
    }
    /* NOT REACHED */
    return -1;
}

static int
init_prepared_statement(PGconn *conn_handle, struct _table *table)
{
    PGresult *res = NULL;
    char stmt_str[MAX_LEN] ;
    int	str_len ;

    str_len = snprintf(stmt_str, sizeof(stmt_str), "INSERT INTO %s %s",
                                  table->table_name, table->insertquery);
    if(str_len >= sizeof(stmt_str)) {
        oppostgres_log_msg(LG_ERR,"init_prepared_statement: prepare statement string truncated\n");
        return -1;
    }
    oppostgres_log_msg(LG_DEBUG,"init_prepared_statement: prepare statement string '%s'\n", stmt_str);

    res = PQprepare(conn_handle, table->name, stmt_str, table->column_count, table->param_types);
    //res = PQprepare(conn_handle, "", stmt_str, table->column_count, table->param_types);
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
	oppostgres_log_msg(LG_ERR, "init_prepared_statement: statement preparation failed: %s\n", 
									PQerrorMessage(conn_handle));
	PQclear(res);
	return -1;
    }
    PQclear(res);

    oppostgres_log_msg(LG_DEBUG, "init_prepared_statement: table '%s': INSERT statement prepared\n", table->name);
    return 0;
}

static int
deallocate_prepared_stmt(PGconn *conn_handle, struct _table *table)
{
    char query[MAX_LEN];
    int ret;

    ret = snprintf(query, sizeof(query), "DEALLOCATE %s", table->name);
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "deallocate_prepared_stmt: DEALLOCATE Query truncated\n");
	return -1;
    }

    /* send query to server for table deletion */
    if(process_pgsql_query(conn_handle, query, NULL) < 0) {
        return -1;
    }
    oppostgres_log_msg(LG_DEBUG, "deallocate_prepared_stmt: prepared statement '%s' deallocated\n", table->name);

    return 0;
}


static int
begin_transaction(PGconn *conn_handle)
{
    char query[MAX_LEN];
    int ret, fd;

    fd = PQsocket(conn_handle);

    ret = snprintf(query, sizeof(query), "BEGIN;");
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "begin_transaction: BEGIN Query truncated\n");
	return -1;
    }

    /* send query to server for table deletion */
    if(process_pgsql_query(conn_handle, query, NULL) < 0) {
	oppostgres_log_msg(LG_ERR, "TRANSACTION COULD'T BEGIN for FD: %d\n", fd);
        return -1;
    }
    oppostgres_log_msg(LG_DEBUG, "TRANSACTION BEGIN for FD: %d\n", fd);

    return 0;
}


static int
end_transaction(PGconn *conn_handle)
{
    char query[MAX_LEN];
    int ret, fd;

    fd = PQsocket(conn_handle);

    ret = snprintf(query, sizeof(query), "END;");
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "end_transaction: END Query truncated\n");
	return -1;
    }

    /* send query to server for table deletion */
    if(process_pgsql_query(conn_handle, query, NULL) < 0) {
	oppostgres_log_msg(LG_ERR, "TRANSACTION COULD'T COMMITED for FD: %d\n", fd);
        return -1;
    }
    oppostgres_log_msg(LG_DEBUG, "TRANSACTION COMMITED for FD: %d\n", fd);

    return 0;
}

static int
reset_transaction(PGconn *conn_handle)
{
    /* end transaction */
    if(end_transaction(conn_handle) < 0) {
	oppostgres_log_msg(LG_ERR, "reset_transaction: Transaction Reset Failed\n");
	return -1;
    }
    /* begin transaction */
    if(begin_transaction(conn_handle) < 0) {
	oppostgres_log_msg(LG_ERR, "reset_transaction: Transaction Reset Failed\n");
	return -1;
    }

    oppostgres_log_msg(LG_DEBUG, "reset_transaction: Transaction Reset\n");

    return 0;
}

static int
drop_table(PGconn *conn_handle, struct _table *table)
{
    char query[MAX_LEN];
    int ret;

    ret = snprintf(query, sizeof(query), "DROP TABLE IF EXISTS %s ;", table->table_name);
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "drop_table: DROP TABLE QUERY truncated\n");
	return -1;
    }

    /* send query to server for table deletion */
    if(process_pgsql_query(conn_handle, query, NULL) < 0) {
        return -1;
    }
    oppostgres_log_msg(LG_DEBUG, "drop_table: table '%s' dropped\n", table->table_name);

    return 0;
}

static int
create_table(PGconn *conn_handle, struct _table *table)
{
    char query[MAX_LEN];
    int ret;
    struct timeval tv;

    gettimeofday(&tv, NULL);

    ret = snprintf(query, sizeof(query), "write_%s_%lu_%lu", table->name, 
						tv.tv_sec, tv.tv_usec);
    if(table->table_name) {
        free(table->table_name);
        table->table_name = NULL;
    }

    table->table_name = strdup(query);
    if(!table->table_name) {
    	oppostgres_log_msg(LG_ERR, "create_table: table name preparation failed\n");
        return -1;
    }

    ret = snprintf(query, sizeof(query), "CREATE TABLE %s (%s) ;", 
					table->table_name, table->createquery);
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "create_table: QUERY '%s' truncated\n", query);
	return -1;
    }

    /* create new table */
    if(process_pgsql_query(conn_handle, query, NULL) < 0) {
        return -1;
    }

    oppostgres_log_msg(LG_DEBUG, "create_table: table '%s' created\n", table->table_name);

    return 0;
}

static int
get_next_available_table(PGconn *conn_handle, struct _table *table)
{
    int	ret, i, j;
    char query[MAX_LEN];
    char *table_name = NULL;
    PGresult *res;

    ret = snprintf(query, sizeof(query), "SELECT tablename FROM %s LIMIT 1;", table->tblavailable);
    if(ret >= sizeof(query)) {
        oppostgres_log_msg(LG_ERR, "get_next_available_table: QUERY '%s' truncated\n", query);
	return -1;
    }

    if(process_pgsql_query(conn_handle, query, &res) < 0) {
	oppostgres_log_msg(LG_ERR, "get_next_available_table: QUERY '%s' failed\n", query);
	return -1;
    }

    /* process result set to get table name and then rotate tables one by one */
    for(i = 0; i < PQntuples(res); i++) {
	for(j = 0; j < PQnfields(res); j++) {
	    table_name = PQgetvalue(res, i, j);
	    if(table_name) {
		table->table_name = strdup(table_name);
		if(table->table_name) {
		    /* set table state */
		    SET_TABLE_CREATED_FLAG(table); 
		    goto found;
		}
	    } else {
		oppostgres_log_msg(LG_DEBUG,"get_next_available_table: no available table found\n");
	    }
	}
    }

found:
    /* cleanup result data */
    PQclear(res);

    if(!table->table_name) {
	if(create_table(conn_handle, table) < 0) {
	    oppostgres_log_msg(LG_ERR, "get_next_available_table: new table couldn't created\n");
	    return -1;
	}	

	snprintf(query, sizeof(query), "INSERT INTO %s (tablename) VALUES ('%s');", 
                                  		table->tblavailable, table->table_name);
	/* insert new available table */
	if(process_pgsql_query(conn_handle, query, NULL) < 0) {
	    oppostgres_log_msg(LG_ERR, "get_next_available_table: created table's name "\
						"couldn't inserted in available queue\n");
	    drop_table(conn_handle, table);
            return -1;
	}
    } 
    oppostgres_log_msg(LG_DEBUG, "get_next_available_table: selected table: '%s'\n",
							    	table->table_name);

    return 0;
}

static int
prepare_next_table(PGconn *conn_handle, struct _table *table)
{
    int	ret;

    if(table->table_name) {
        free(table->table_name);
        table->table_name = NULL;
    }

    if(get_next_available_table(conn_handle, table) < 0) {
	return -1;
    }

    /* start transaction */
    if(begin_transaction(conn_handle) < 0) {
	oppostgres_log_msg(LG_ERR, "prepare_next_table: transaction couldn't started "\
					"for table '%s'\n", table->table_name);
	return -1;
    }

   /* initialize prepared statement */
    ret = init_prepared_statement(conn_handle, table) ;
    if(ret < 0) {
        oppostgres_log_msg(LG_ERR, "prepare_next_table: prepare statement failed for "\
						"table '%s'\n", table->table_name);
        return -1;
    }

    /* reset uncommitted record count */
    table->uncommitted_record_count = 0;

    /* reset total record count */
    table->record_count = 0;

    /* set table status flag to ready */
    SET_TABLE_CREATED_FLAG(table);

    return 0;
}

void
move_table_to_usedqueue(struct _db *db, struct _table *table)
{
    int ret ;
    char query[MAX_LEN];

    if(!IS_TABLE_CREATED(table)) {
	oppostgres_log_msg(LG_INFO, "move_table_to_usedqueue: no table selected yet\n");
	return ;
    }

    oppostgres_log_msg(LG_DEBUG, "move_table_to_usedqueue: moving table '%s' FD: %d\n", 
					table->table_name, PQsocket(db->db_handle));

    /* end transaction */
    if(end_transaction(db->db_handle) < 0) {
	oppostgres_log_msg(LG_ERR, "move_table_to_usedqueue: end transaction failed for '%s'\n", 
								    table->table_name);
	//return ;
    }

    /* dellocate prepared statement */
    if(deallocate_prepared_stmt(db->db_handle, table) < 0) {
	oppostgres_log_msg(LG_ERR, "move_table_to_usedqueue: prep. stmt deallocation failed for '%s'\n", 
										table->table_name);
	//return ;
    }

    /* we have delocated prepared statement so reset table state flag */
    RESET_TABLE_CREATED_FLAG(table);

    ret = snprintf(query, sizeof(query), "SELECT move_from_avail_to_used('%s', '%s');", 
							table->table_name, table->name) ;
    if(ret >= sizeof(query)) {
	oppostgres_log_msg(LG_ERR,"move_table_to_usedqueue: QUERY '%s' truncated\n", query);
	return;
    }
    
    /* move table to 'used' queue */
    if(process_pgsql_query(db->db_handle, query, NULL) < 0) {
	oppostgres_log_msg(LG_ERR, "move_table_to_usedqueue: query execution failed\n");
        return ;
    }
    oppostgres_log_msg(LG_INFO, "move_table_to_usedqueue: table '%s' is moved to 'used' queue\n", 
									table->table_name);
    return ;
}

static PGconn *
do_pgsql_server_connect(void)
{
    PGconn *conn_handle = NULL;

/* --------- FOR TESTING --------------	
    char	conninfo[1024];
    int		ci_len;
	
    ci_len = snprintf(conninfo, sizeof(conninfo), 
			"hostaddr=%s port=%s dbname=%s user=%s password=%s connect_timeout=%s",
			config_get_server_addr(),
			config_get_server_port(), 
			config_get_database_name(), 
			config_get_username(), 
			config_get_password(),
			OPPOSTGRES_DEFAULT_CONNECT_TIMEOUT);
				
    if(ci_len >= sizeof(conninfo)) {
        oppostgres_log_msg(LG_ERR,"do_pgsql_server_connect: conninfo string truncated\n");
        return NULL;
    }
    oppostgres_log_msg(LG_DEBUG,"do_pgsql_server_connect: conninfo string '%s'\n", conninfo);

    conn_handle = PQconnectdb(conninfo);
    if (PQstatus(conn_handle) != CONNECTION_OK) {
	oppostgres_log_msg(LG_ERR, "do_pgsql_server_connect: Connect failed: %s\n", PQerrorMessage(conn_handle));
	PQfinish(conn_handle);
	return NULL;
    }
*/
    if(setenv("PGCONNECT_TIMEOUT", OPPOSTGRES_DEFAULT_CONNECT_TIMEOUT, 1)) {
	oppostgres_log_msg(LG_ERR, "do_pgsql_server_connect: Environment Variable PGCONNECT_TIMEOUT init failed\n");
	return NULL;
    }

/*    oppostgres_log_msg(LG_DEBUG, "do_pgsql_server_connect: Evironment Variable PGCONNECT_TIMEOUT: %s\n", 
										getenv("PGCONNECT_TIMEOUT"));
*/
    /* Make a connection to the database */
    conn_handle = PQsetdbLogin(	config_get_server_addr(), 
				config_get_server_port(), 
				config_get_connect_options(), 
				NULL, 
				config_get_database_name(), 
				config_get_username(), 
				config_get_password() );
    /* Check to see that the backend connection was successfully made */
    if (PQstatus(conn_handle) != CONNECTION_OK) {
	oppostgres_log_msg(LG_ERR, "do_pgsql_server_connect: Connect failed: %s\n", PQerrorMessage(conn_handle));
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
release_postgres_client(struct _db *db, struct _table *table)
{
    int fd = PQsocket(db->db_handle);

    /* end transaction, if not commited */
    end_transaction(db->db_handle);

    /* reset table related parameters */
    if(table && IS_TABLE_CREATED(table)) {
	move_table_to_usedqueue(db, table);	
    }

    /* disconnect connection to server */
    if(IS_DB_CONNECTED(db)) {
	if(db->db_handle == NULL) {
	    oppostgres_log_msg(LG_ERR, "release_postgres_client: invalid DB Connetion State FD: %d\n", fd);
	} else {
	    do_pgsql_server_disconnect(db->db_handle);
	    db->db_handle = NULL;

	    oppostgres_log_msg(LG_ERR, "release_postgres_client: Database disconnected FD: %d\n", fd);
	}
	RESET_DB_CONNECTED_FLAG(db);
    }
    return;
}

int
init_postgres_client(struct _db *db, struct _table *table)
{
#if 0
    u_int32_t	time_diff, now;
    u_int32_t	reconnect_interval = config_get_reconnect_interval();

    now = time(NULL);
    time_diff = now - db->last_connection_time;

    oppostgres_log_msg(LG_DEBUG, "init_postgres_client: Last connection established before '%u' seconds\n", time_diff);

    if(time_diff <= reconnect_interval ) {
	oppostgres_log_msg(LG_ERR, "init_postgres_client: database connection blocked for '%d' seconds\n",
									(reconnect_interval - time_diff) );
        return -1;
    }

    db->last_connection_time = now ;
#endif

    /* connect with embedded server */
    db->db_handle = do_pgsql_server_connect();
    if(db->db_handle == NULL) {
        oppostgres_log_msg(LG_ERR, "init_postgres_client: Server couldn't connected TABLE: '%s'\n",
											table->name);
        return -1;
    }
    oppostgres_log_msg(LG_INFO, "init_postgres_client: server connected TABLE: '%s' FD: %d\n", 
								table->name, PQsocket(db->db_handle));
    
    if(PQsetnonblocking(db->db_handle, TRUE) < 0) {
        oppostgres_log_msg(LG_ERR, "init_postgres_client: connection handle couldn't made non-blocking\n");
	release_postgres_client(db, table);
        return -1;
    }
	
    return 0;
}

static int
process_insert_query_result(PGconn *conn_handle, PGresult  **r_set)
{
    PGresult *res = NULL;

    if(PQconsumeInput(conn_handle) == 0) {
	oppostgres_log_msg(LG_ERR, "process_insert_query_result: consume result failed: %s\n", 
								PQerrorMessage(conn_handle));
	return -1;						
    }

    while((res = PQgetResult(conn_handle))) {
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
	    oppostgres_log_msg(LG_ERR, "process_insert_query_result: insert query failed: %s\n", 
									PQerrorMessage(conn_handle));
	    PQclear(res);
	    return -1;
	}
    }
    return 0;
}

#define INSERT_TIMEOUT_SEC	0
#define INSERT_TIMEOUT_USEC	100000

static int
process_insert_query_async(PGconn *conn_handle, struct _table *table, PGresult  **r_set)
{
    int ret;
    int	sock_fd = -1;
    fd_set input_mask;

    struct timeval tv;

    tv.tv_sec = INSERT_TIMEOUT_SEC;
    tv.tv_usec = INSERT_TIMEOUT_USEC;

    ret = PQsendQueryPrepared(conn_handle, table->name, table->column_count,
	(const char * const *)table->param_values, table->param_lengths, table->param_formats, 0);
    if(ret == 0) {
    	/* query failed */
	oppostgres_log_msg(LG_ERR, "process_insert_query_async: prepared query send failed: %s\n", 
									PQerrorMessage(conn_handle));
        return -1 ;
    }
    PQflush(conn_handle);

    sock_fd = PQsocket(conn_handle);
    if(sock_fd < 0) {
	/* very rare condition */
	/* it becomes equivalent to blocking query execution */
	oppostgres_log_msg(LG_ERR, "process_insert_query_async: couldn't get socket fd: %s\n", 
								PQerrorMessage(conn_handle));
	return process_insert_query_result(conn_handle, NULL);
    }

    FD_ZERO(&input_mask);
    FD_SET(sock_fd, &input_mask);
	
    ret = select(sock_fd+1, &input_mask, NULL, NULL, &tv);
    if(ret < 0) {
		oppostgres_log_msg(LG_ERR, "process_insert_query_async: select failed: %s\n", strerror(errno));
		return -1;
    } else if(ret == 0) {
	PGcancel *cancel = NULL;
	int can_ret;
	char err_buf[256];

	oppostgres_log_msg(LG_ERR, "process_insert_query_async: query execution timed-out\n");

	cancel = PQgetCancel(conn_handle);
	if(cancel == NULL) {
	    oppostgres_log_msg(LG_ERR, "process_insert_query_async: couldn't got query cancel object\n");
	    /* it becomes equivalent to blocking query execution */
	    return process_insert_query_result(conn_handle, NULL);
	}

	can_ret = PQcancel(cancel, err_buf, sizeof(err_buf));
	if(can_ret == 0) {
	    oppostgres_log_msg(LG_ERR, "process_insert_query_async: couldn't cancel last query: %s\n", err_buf);
	    /* it becomes equivalent to blocking query execution */
	    return process_insert_query_result(conn_handle, NULL);
	}
	oppostgres_log_msg(LG_ERR, "process_insert_query_async: last query canceled\n");
	PQfreeCancel(cancel);

	process_insert_query_result(conn_handle, r_set);
	return -2;
    } 

    /* collect result data */
    return process_insert_query_result(conn_handle, r_set);
}

int
do_datainsert(struct _db *db, struct _table *table, struct _std_event *se)
{
    int i, ret;

    struct _table_format *tf=NULL ;
    struct _std_event_vars_pg *sev=NULL ;
    char **param_value_ptr = NULL;

retry_conn:
    if(!IS_DB_CONNECTED(db)) {
	/* make new connection to database */
	if(init_postgres_client(db, table) < 0) {
	    oppostgres_log_msg(LG_ERR, "do_datainsert: Database couldn't connected\n");
	    return 1;
	} else {
	    /* connected to database */
	    SET_DB_CONNECTED_FLAG(db);
	    /* force to create new table */
	    RESET_TABLE_CREATED_FLAG(table);

	    oppostgres_log_msg(LG_DEBUG, "do_datainsert: Database Connected TABLE: '%s' FD: %d\n",
								table->name, PQsocket(db->db_handle));
	}
    } else {
	/* check existing database connection */
	if(PQstatus(db->db_handle) != CONNECTION_OK) {
            /* connection interrupted */
	    oppostgres_log_msg(LG_DEBUG, "do_datainsert: Database Connection interrupted\n");
	    release_postgres_client(db, table);
	    goto retry_conn;
	}
    }

    oppostgres_log_msg(LG_DEBUG, "do_datainsert: TABLE: '%s'\n",table->name);
    if(!IS_TABLE_CREATED(table)) {
        if(prepare_next_table(db->db_handle, table) < 0) {
	    oppostgres_log_msg(LG_ERR, "do_datainsert: couldn't select table '%s'\n", table->name);
            return -1;
        }
    }

    /*
     *  set uninitialized data of bind parameters
     *  Note: constant data of bind parameters has been initialized in init_table_list
     */
    for(i=0, tf=table->tableformat; (i<table->column_count) && (tf) ; i++, tf=tf->next) {
        if(tf->datalen) {
            /* already intialized */
        } else {
	    param_value_ptr = (table->param_values + i) ;
            sev = (struct _std_event_vars_pg *) (tf->data);

	    /* initialize std event value's pointer to bind parameter value pointer */
	    sev->setparam(tf, param_value_ptr, (void *) se + (sev->offset));
        }
    }

    /* execute prepared statement */
    oppostgres_log_msg(LG_DEBUG, "do_datainsert: executing prepared statement\n");

    ret = process_insert_query_async(db->db_handle, table, NULL);
    if (ret < 0) {
        oppostgres_log_msg(LG_ERR, "do_datainsert: data insert failed for table '%s'\n", 
                                        table->table_name);
        /*
         *  print column and value
         *  Note: constant data of bind parameters has been initialized in init_table_list
         */
        for(i=0, tf=table->tableformat; (i<table->column_count) && (tf) ; i++, tf=tf->next) {
            sev = (struct _std_event_vars_pg *) (tf->data);
            /* print std event value's pointer to bind parameter value pointer */
            sev->printparam(tf, (void *) se + (sev->offset));
        }

	/* reset transaction */
	if(reset_transaction(db->db_handle) < 0) {
	    oppostgres_log_msg(LG_ERR, "do_datainsert: reset transaction failed for table '%s'\n", 
									    table->table_name);
	    //return -1;
	}
	/* reset uncommitted record count */
	table->uncommitted_record_count = 0;

	if (ret != -2 ){
            /* close db connection */
            release_postgres_client(db, table);
        }
        return -1;
    }

    /* commit uncommitted transaction */
    table->uncommitted_record_count++;
    if(table->uncommitted_record_count >= table->max_uncommitted_records) {
	/* reset transaction */
	if(reset_transaction(db->db_handle) < 0) {
	    oppostgres_log_msg(LG_ERR, "do_datainsert: reset transaction failed for table '%s'\n", 
										    table->table_name);
	    release_postgres_client(db, table);
	    return -1;
	}
	/* reset uncommitted record count */
	table->uncommitted_record_count = 0;
    }

    /* update record count */
    table->record_count++;
    if(table->record_count >= table->max_records) {
	/* number of records have crossed set limit for maximum records in a table */
	move_table_to_usedqueue(db, table);	
    }

    return 0;
}

