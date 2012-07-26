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

#include <stdlib.h>

#include "hash.h"
#include "resolver_postgres_db.h"

#define MAX_LEN	2048
#define RESOLVER_PG_DEFAULT_CONNECT_TIMEOUT "1"

PGconn *
pg_server_connect(char *server_addr, char *server_port, char *database_name, char *username, char *password)
{
    PGconn	*conn_handle = NULL;

    if(setenv("PGCONNECT_TIMEOUT", RESOLVER_PG_DEFAULT_CONNECT_TIMEOUT, 1)) {
	resolver_log_message(RLG_ERR, "pg_server_connect: Environment Variable PGCONNECT_TIMEOUT init failed\n");
	return NULL;
    }
    //resolver_log_message(RLG_DEBUG, "pg_server_connect: Evironment Variable PGCONNECT_TIMEOUT: %s\n", 
    //									getenv("PGCONNECT_TIMEOUT"));

    /* Make a connection to the database */
    conn_handle = PQsetdbLogin(	server_addr, 
				server_port, 
				NULL, 
				NULL, 
				database_name, 
				username, 
				password);
    /* Check to see that the backend connection was successfully made */
    if(PQstatus(conn_handle) != CONNECTION_OK) {
	resolver_log_message(RLG_ERR, "pg_server_connect: Connect failed: %s\n", PQerrorMessage(conn_handle));
	PQfinish(conn_handle);
	return NULL;
    }
    return conn_handle;
}

void
pg_server_disconnect(PGconn *conn_handle)
{
    PQfinish(conn_handle);
}

static int
pg_process_query(PGconn *conn_handle, char *query, PGresult  **r_set)
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
	resolver_log_message(RLG_ERR, "pg_process_query: query '%s' execution failed: %s\n", 
							query, PQerrorMessage(conn_handle));
	PQclear(res);	
	return -1;
    }

    /* NOT REACHED */
    PQclear(res);
    return -1;
}

/* HASH TABLE SUPPORT ROUTINES */
#define MANAGE_FIELD						\
    while (next) {						\
	len = strlen(next->cname);				\
	memcpy(field, next->cname, len);			\
	field += len;						\
	*field++ = ',';						\
	*field++ = ' ';						\
	sev = (struct _resolver_std_event_vars *) next->data;	\
	keylen += sev->field_size;				\
	next = next->next;					\
    }

static char *
pg_make_select_query(struct _resolver *resolver, u_int32_t *key_len, u_int32_t *val_len)
{
    char buf[MAX_LEN + 32];
    char field_list[MAX_LEN];

    struct _field_format *next;
    struct _resolver_std_event_vars *sev;

    char *field = field_list;
    int len = 0;
    u_int32_t keylen = 0;

    if (!resolver) {
	return NULL;
    }

    memset(field_list, 0, sizeof(field_list));
    next = resolver->key_format;
    MANAGE_FIELD;
    (*key_len) = keylen;
    keylen = 0;

    next = resolver->value_format;
    MANAGE_FIELD;
    (*val_len) = keylen;
    field = field - 2;
    (*field) = 0;

    memset(buf, 0, sizeof(buf));
    len = snprintf(buf, sizeof(buf), "SELECT %s FROM %s;", field_list, resolver->table_name);

    if(len >= sizeof(buf)) {
        resolver_log_message(RLG_ERR,"pg_make_select_query:  '%s' truncated\n", buf);
        return NULL;
    }

    return strdup(buf);
}

#define MAKE_KEY_VALUE							\
    while (ptrvar) {							\
        sev = (struct _resolver_std_event_vars *) ptrvar->data;		\
		sev->string_to_any(PQgetvalue(res_set, i, ret), ptr, sev->field_size);		\
        ptr += sev->field_size;						\
        ptrvar = ptrvar->next;						\
        ret++;								\
    }

int
pg_hash_table_init(PGconn *conn, struct _resolver *resolver)
{
    int		i;
    char	*query;
   // char	buf[MAX_LEN];
    u_int32_t	keylen = 0, vallen = 0, ret;
    u_int8_t	*ptr = NULL;
	
    PGresult	*res_set;
    struct _hash_table	*hash_table = NULL;
    struct _hash_table	*element = NULL;
    struct _field_format *ptrvar = NULL;
    struct _resolver_std_event_vars *sev = NULL;
	
    resolver->hash_table = NULL;

#if 0
    /* select database */
    ret = snprintf(buf, sizeof(buf), "USE %s ;", resolver->database_name) ;
    if(ret >= sizeof(buf)) {
	resolver_log_message(RLG_ERR, "pg_hash_table_init: USE database QUERY '%s' truncated\n", buf);
        return -1;
    }
    if(pg_process_query(conn, buf, NULL) < 0) {
	resolver_log_message(RLG_ERR, "Failed 1.\n");
	return -1;
    }
#endif
    /* prepare Select Query */
    query = pg_make_select_query(resolver, &keylen, &vallen);
    if (!query) {
	resolver_log_message(RLG_ERR, "Faild to create Select Query.\n");
	return -1;
    }
	/* execute Select Query */
    if(pg_process_query(conn, query, &res_set) < 0) {
		resolver_log_message(RLG_ERR, "Failed 2.\n");
     	free(query);
	return -1;
    }
    free(query);

    /* process result set to get table name and then rotate tables one by one */
    for(i = 0; i < PQntuples(res_set); i++) {
	ret = 0;
	element = calloc(1, sizeof(struct _hash_table));
	
	ptr = calloc(1, keylen);
	element->key = ptr;			

	ptrvar = resolver->key_format;
	MAKE_KEY_VALUE;

	ptr = calloc(1, vallen);
	element->value = ptr;

	ptrvar = resolver->value_format;
	MAKE_KEY_VALUE;

	if(ret != PQnfields(res_set)) {
	    resolver_log_message(RLG_ERR, "Failed 3.\n");
	    free(element->key);
	    free(element->value);
	    PQclear(res_set); 
	    return -1;
	}
	hash_add(&hash_table, element, keylen);
    }			

   /* cleanup result data */
    PQclear(res_set);
    
    if (!hash_table) {
	return 1;
    }

    resolver->hash_table = hash_table;
    resolver->key_len = keylen;
    resolver->value_len = vallen;

    return 0;
}
