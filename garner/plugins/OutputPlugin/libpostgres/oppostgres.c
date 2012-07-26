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

#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

#include "config.h"
#include "postgres_db.h"
#include "oppostgres.h"
#include "utils.h"

/* 
 * -----------------------------------------------------------------------
 * MACRO definition
 * -----------------------------------------------------------------------
 */

/* default filepath for log file */
#define DEFAULT_CONFFILE_PATH "/usr/local/garner/oppostgres.conf" 

/* default size for internal buffers */
#define MAX_LEN 2048     

/*
 * -----------------------------------------------------------------------
 * Structure declaration
 * -----------------------------------------------------------------------
 */

/* plugin's private data structure to maintain stat information */
struct _plugin_data{
    char *conf_filepath	;   	/* configuration file path */
    struct _db db;	    	/* contains database name and connection handle */
    char *table_name;	    	/* table name to be used */
    struct _table *table;	/* table to be used */
    u_int8_t rotate_count ;	/* number of table rotation for current connection */
	
    void *handle;
} ;


/*
 * -----------------------------------------------------------------------
 * Global variable definition/declaration 
 * -----------------------------------------------------------------------
 */

//static char *app_name = "OPPOSTGRES";
static u_int32_t g_lib_refcount = 0 ;       /* library reference count */

enum log_level_t log_level = LG_ERR;

/*
 * =======================================================================
 * Library Support Routines Starts 
 * =======================================================================
 */

/* initialize plugin library */
static int
init_plugin_gdata(struct _plugin_data *pdata)
{
    /* parse configuration file */
    if(oppostgres_parse_conffile(pdata->conf_filepath) < 0) {
        oppostgres_log_msg(LG_ERR,"init_plugin_gdata: conf file parsing fail\n");
        return -1;
    }

    if(init_table_list() < 0) {
	oppostgres_log_msg(LG_ERR,"init_plugin_gdata: table list initialization fail\n");
	oppostgres_cleanup_parsed_state();
	return -1;
    }

    return 0;
}

/* cleanup all parsed state information */
static void
release_plugin_gdata()
{
    oppostgres_cleanup_parsed_state();
    return ;	
}


/*
 * this routine will fill up token string in dst if it is not null
 * it will return (token length + 1)
 */

#define	TOKEN_LEN MAX_LEN

static int
get_next_token(char *src, char *dst)
{
    int count;
    char *start,*end, *comma_p;

    start = src;
    /* trimming the token at start - skipping spaces/tabs/new lines */
    while(*start==' ' || *start=='\t' || *start=='\n'){
	start++;
    }

    /* get pointer to next token delimiter */
    for(comma_p=src ; (*comma_p != ',') && (*comma_p != '\0'); comma_p++);

    /* trimming the token at end - skipping spaces/tabls/ne lines */
    if(comma_p != src) {
        end = comma_p-1;
    	while((end!=src) && 
		(*end==' ' || *end=='\t' || *end=='\n')){
	    end--;
        }
        /* length of token(n bytes) */
	count=end-start+1;
    }
    if(comma_p == src || end == src) {
	/* token is empty string */
	count = 0;
    }

    assert(count < TOKEN_LEN) ;

    /* to return token to caller */
    if(dst != NULL) {
        memcpy(dst, start, count);
        dst[count] = '\0';
    }
    
    /* return number of bytes to be skipped to get next token */
    return (comma_p-src+1); 
}

/* 
 * This routine will initialize some of the fields of plugin's private
 * data structure. It will also parse argument string
 */ 
static int
plugin_data_init(struct _plugin_data *pdata, const char *args)
{
    char token[TOKEN_LEN];
    char *arg_base = strdup(args);
    int offset;

    offset = 0;

    /* initialize conf file path */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
	/* set to default conf file path */ 
	strcpy(token, DEFAULT_CONFFILE_PATH);
    }
    pdata->conf_filepath = strdup(token);
    oppostgres_log_msg(LG_DEBUG, "plugin conf file is set to '%s'\n", pdata->conf_filepath);

    /* get table name to be used */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
	oppostgres_log_msg(LG_ERR, "table name '%s' is not valid\n", token);
	return -1;
    }
    pdata->table_name = strdup(token);
    oppostgres_log_msg(LG_DEBUG, "selected table is '%s'\n", pdata->table_name);

    /* releasing copied argument string */
    free(arg_base);
    
    return 0;
}

static int
plugin_data_postinit(struct _plugin_data *pdata)
{
    pdata->table = get_table_by_name(pdata->table_name);
    if(!pdata->table) {	
	oppostgres_log_msg(LG_ERR, "table name '%s' is not valid\n", pdata->table_name);
	return -1;
    }

    /* reset table state */
    RESET_TABLE_CREATED_FLAG((pdata->table));

    pdata->db.db_name = strdup(config_get_database_name());		
    if(!pdata->db.db_name) {
	oppostgres_log_msg(LG_ERR, "database name allocation failed\n");
	return -1;
    }
	
    if(init_postgres_client(&(pdata->db), pdata->table) < 0) {
	/* database server couldn't connected */
	RESET_DB_CONNECTED_FLAG((&(pdata->db)));
    } else {
	/* connected to database server */
	SET_DB_CONNECTED_FLAG((&(pdata->db)));
    }

    return 0;
}

/* 
 * This routine will print some of the fields of plugin's private
 * data structure.
 */ 
static int
plugin_data_print(struct _plugin_data *pdata)
{

#ifdef DEBUG_INFO 
    int i;
    oppostgres_log_msg(LG_DEBUG,"Oppostgres Output Plugin '%s' initialization information:\n",
										app_name);
    oppostgres_log_msg(LG_DEBUG,"-----\n");
    oppostgres_log_msg(LG_DEBUG,"\tConffilepath:\t'%s'\n", pdata->conf_filepath);
    oppostgres_log_msg(LG_DEBUG,"\tDatabase Selected:\t'%s'\n", pdata->db.db_name);
    oppostgres_log_msg(LG_DEBUG,"\tTable Selected:\t'%s'\n", pdata->table->name);

    oppostgres_log_msg(LG_DEBUG,"-----\n");

#endif

    return 0;
}

/*
 * #######################################################################
 * Library Support Routines Ends 
 * #######################################################################
 */


/*
 * =======================================================================
 * Library Routines Starts 
 * =======================================================================
 */

/*
 * Arguments:
 *	argstring - Arguments passed along with the output line in output block.
 *	version - version of garner.
 *      handle - to store an pointer to internal state information.
 * Return Value:
 *	Returns 0 on success, -1 on failure.
 *      Pointer to internal state information in 'handle', if required.
 *	Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *	This routine would be called once by garner during initialization.
 *	Version mismatch can be check during init itself.
 */
int
oppostgres_init(const char *argstring, u_int32_t version, void **handle)
{
    struct _plugin_data *pdata ;

    /* standard event version validation */
    if(version != STD_EVENT_VERSION) {
        oppostgres_log_msg(LG_ERR, "Version %d doesnt match with standard event version %d\n", 
								version, STD_EVENT_VERSION);
        return -1;
    }

    /* if handle is NULL, return */
    if(!handle) {
	oppostgres_log_msg(LG_ERR, "oppostgres_init: plugin handle pointer NULL\n");
        return -1;
    }

    /* allocating plugin's private data structure */
    pdata = (struct _plugin_data *) calloc(1, sizeof(struct _plugin_data));
    if(plugin_data_init(pdata, argstring) < 0) {
	free(pdata);
	return -1;
    }
    pdata->handle = (void *) pdata ;

    /* initialize plugin global state */
    g_lib_refcount++ ;
    oppostgres_log_msg(LG_DEBUG, "library_reference_count: %d\n",g_lib_refcount);
    if(g_lib_refcount == 1) {
	if(init_plugin_gdata(pdata) < 0) {
	    oppostgres_close(pdata);
            return -1;
	} 			
    }

    if(plugin_data_postinit(pdata) < 0) {
	oppostgres_close(pdata);
	return -1;
    }

    /* return handle to plugin open instance */
    *handle = (void *) pdata ;

    /* print plugin's initialized state information */
    plugin_data_print(pdata);

    return 0;
}

/*
 * Frees the internal data-structures of the library.
 */
void
oppostgres_close(void *handle)
{
    struct _plugin_data *pdata;
	
    if(!handle || (handle != ((struct _plugin_data *) handle)->handle) ){
        oppostgres_log_msg(LG_ERR,"oppostgres_close: plugin handle invalid\n");
        return ;
    }

    pdata = (struct _plugin_data *) handle ;

    /* release configuratio file path memory */
    if(pdata->conf_filepath) {
	free(pdata->conf_filepath);
	pdata->conf_filepath = NULL;
    }

    /* release database name allocated memory */
    if(pdata->db.db_name) {
	free(pdata->db.db_name);
	pdata->db.db_name = NULL;
    }

    /* release table name allocated memory */
    if(pdata->table_name) {	
	free(pdata->table_name);
	pdata->table_name = NULL;
    }

    /* reset state of table structure instance and close connection to postgres server */
    release_postgres_client(&(pdata->db), pdata->table);

    /* reset table pointer */
    pdata->table = NULL;

    /* release plugin data */
    free(handle);
    handle = NULL ;

    /* decrease reference count and if it became '0', release plugin's global resources */
    g_lib_refcount--;
    if(g_lib_refcount == 0) {
	release_plugin_gdata();
    }

    return;
}

/*
 * Arguments:
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 *	output_data_list - 2D pointer to output data list
 *      handle - pointer to internal state information intialized in *_init()
 * Description:
 *      Output plugin, can be formatter or processor
 */

#define MAX_ROTATE_PER_CONNECTION 1

void
oppostgres_output(struct _std_event *searray, u_int32_t nse,
			struct _output_data **output_data_list, void *handle)
{
    int i, ret ;
 
    struct _plugin_data *pdata ;  
    struct _std_event *se ;

    if(!handle || handle != ((struct _plugin_data *) handle)->handle) {
    	oppostgres_log_msg(LG_ERR,"oppostgres_output: plugin handle invalid\n");
        return;
    }
    pdata = (struct _plugin_data *) handle ;

    /* return if nothing to be written to archieve file */
    if(searray == NULL) {
	return ;
    }

    /* traverse through all elements of SE array */
    for(i=0; i<nse; i++) {
        se = searray + i ;
	
	ret = do_datainsert(&(pdata->db), pdata->table, se) ;
	if(ret < 0) {
	    oppostgres_log_msg(LG_ERR,"oppostgres_output: log event couldn't inserted\n");
	    return;
	}
	if(ret == 1) {
	    oppostgres_log_msg(LG_ERR,"oppostgres_output: error: database connection lost\n");
	}
    }
    return;
}

void
oppostgres_event(void *handle)
{
    struct _plugin_data *pdata ;  

    /* return if nothing to be written to archieve file */
    if(!handle || handle != ((struct _plugin_data *) handle)->handle) {
    	oppostgres_log_msg(LG_ERR,"oppostgres_event: plugin handle invalid\n");
        return;
    }
    pdata = (struct _plugin_data *) handle ;
    	
    oppostgres_log_msg(LG_DEBUG,"oppostgres_event: timestamp: '%lu'\n", time(NULL));

    /* clock event for this plugin is to rotate currently used table */
    move_table_to_usedqueue(&(pdata->db), pdata->table);
	if(IS_DB_CONNECTED((&(pdata->db)))) {
		if(pdata->table->table_name){
		    pdata->rotate_count++;
		    /* reset connection if rotate count exceeds MAX_ROTATE_PER_CONNECTION */
		    if(pdata->rotate_count >= MAX_ROTATE_PER_CONNECTION) {
			oppostgres_log_msg(LG_ERR,"FORCED CONNECTION RESET for TABLE: '%s' FD: %d\n",
						pdata->table->name, PQsocket(pdata->db.db_handle));
			release_postgres_client(&(pdata->db), pdata->table);	
			pdata->rotate_count = 0;
		    }
		}
	}
    return;
}

void
oppostgres_debug(void *handle)
{
    if(log_level > LG_ERR) {
	log_level = LG_ERR ;
    } else {
    	log_level = LG_DEBUG ;
    }

    oppostgres_log_msg(LG_DEBUG,"oppostgres_debug: log level toggled\n");
    return ;
}

/*
 * #######################################################################
 * Library Routines Ends 
 * #######################################################################
 */


