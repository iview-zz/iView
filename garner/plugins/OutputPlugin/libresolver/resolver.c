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
#include <sys/types.h>
#include <ctype.h>

#include "resolver_postgres_db.h"
#include "resolver.h"
#include "utils.h"
#include "hash.h"

/* 
 * -----------------------------------------------------------------------
 * MACRO definition
 * -----------------------------------------------------------------------
 */

/* default filepath for log file */
#define DEFAULT_CONFFILE_PATH "/usr/local/garner/resolver.conf" 
#define DEFAULT_RESOLVER_LOG_PATH "/var/log/garner/resolver.log" 

/* default size for internal buffers */
#define MAX_LEN	2048     

/*
 * -----------------------------------------------------------------------
 * Structure declaration
 * -----------------------------------------------------------------------
 */

static u_int8_t logging_on;

/* plugin's private data structure to maintain stat information */
struct _resolver_plugin_data{
    char *conf_filepath	;	/* configuration file path */
    char *resolver_name;	/* resolver name to be used */
    char *host;			/* Host name*/
    char *port;			/* Port */
    char *user;			/* MYSQL user name*/
    char *pass;			/* MYSQL Password*/
    struct _resolver *resolver; /* resolver to be used */
	
    void *handle;
} ;


/*
 * -----------------------------------------------------------------------
 * Global variable definition/declaration 
 * -----------------------------------------------------------------------
 */

static char *app_name = "Resolver";
static u_int32_t g_lib_refcount = 0 ;	/* library reference count */


/*
 * =======================================================================
 * Library Support Routines Starts 
 * =======================================================================
 */

/* initialize plugin library */
static int
init_plugin_gdata(struct _resolver_plugin_data *pdata)
{
    /* parse configuration file */
    if(resolver_parse_conffile(pdata->conf_filepath) < 0) {
        resolver_log_message(RLG_ERR,"init_plugin: conf file parsing fail\n");
        return -1;
    }
    return 0;
}

/* cleanup all parsed state information */
static void
release_plugin_gdata()
{
    resolver_cleanup_parsed_state();
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
    while(isspace(*start)){
	start++;
    }

    /* get pointer to next token delimiter */
    for(comma_p=start ; (*comma_p != ',') && (*comma_p != '\0'); comma_p++);

    /* trimming the token at end - skipping spaces/tabls/ne lines */
    if(comma_p != start) {
        end = comma_p-1;
    	while((end!=src) && isspace(*end)){
	    end--;
        }
        /* length of token(n bytes) */
	count=end-start+1;
    }

    if(comma_p == src || end == src) {
	/* token is empty string */
	count = 0;
    }

    xassert(count < TOKEN_LEN) ;

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
plugin_data_init(struct _resolver_plugin_data *pdata, const char *args)
{
    char token[TOKEN_LEN];
    char *arg_base = (char *) args;
    int offset;

    offset = 0;

    /* initialize conf file path */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
	/* set to default conf file path */ 
	strcpy(token, DEFAULT_CONFFILE_PATH);
    }
    pdata->conf_filepath = strdup(token);
    resolver_log_message(RLG_DEBUG, "%s: plugin conf file is set to '%s'\n", 
    						app_name, pdata->conf_filepath);
    
    /* get table name to be used */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
	resolver_log_message(RLG_ERR, "plugin_data_init():%s: resolver name '%s' is not valid\n", 
										app_name, token);
	free(pdata->conf_filepath);
	return -1;
    }
    pdata->resolver_name = strdup(token);
    resolver_log_message(RLG_DEBUG, "%s: selected resolver is '%s'\n", 
    					app_name, pdata->resolver_name);

    /* Host Name*/
    offset += get_next_token(arg_base+offset,token);
    if(strcmp(token,"")){
	pdata->host = strdup(token);
        resolver_log_message(RLG_DEBUG, "plugin database host is set to '%s'.\n", token);
    }

    /* Port*/
    offset += get_next_token(arg_base+offset,token);
    if(strcmp(token,"")){
	pdata->port = strdup(token);
        resolver_log_message(RLG_DEBUG, "plugin database port is set to '%s'.\n", token);
    } else {
        resolver_log_message(RLG_DEBUG, "plugin database port is set to default value.\n");
	pdata->port = NULL;
    }

    /* user name*/
    offset += get_next_token(arg_base+offset,token);
    if(strcmp(token,"")){
	pdata->user = strdup(token);
	resolver_log_message(RLG_DEBUG, "plugin database user is set to '%s'.\n", token);
    }

    /* password*/
    offset += get_next_token(arg_base+offset,token);
    if(strcmp(token,"")){
	pdata->pass = strdup(token);
	resolver_log_message(RLG_DEBUG, "plugin database pass is set to '%s'.\n", token);
    }

    return 0;
}


static int
plugin_data_postinit(struct _resolver_plugin_data *pdata)
{
    PGconn *conn_handle = NULL;
    int ret;

    pdata->resolver = get_resolver_by_name(pdata->resolver_name);

    if(!pdata->resolver) {	
	resolver_log_message(RLG_ERR, "%s: resolver name '%s' is not valid\n", 
						app_name, pdata->resolver_name);
	return -1;
    }
    /*Connect with database.*/
    conn_handle = pg_server_connect(pdata->host, pdata->port, 
			pdata->resolver->database_name, pdata->user, pdata->pass);

    if (!conn_handle) {
	resolver_log_message(RLG_ERR, "plugin_data_postinit: pg_server_connect failed.\n");
	return -1;
    }

    /*Prepare Hash Table.*/

    ret = pg_hash_table_init(conn_handle, pdata->resolver);

    if (ret < 0) {
        resolver_log_message(RLG_ERR, "Hash Table is not created for resolver: '%s'\n",
                                	                       	pdata->resolver->name); 
    } else if (ret > 0) {	
        resolver_log_message(RLG_MSG, "Resolver '%s': '%s' Table in '%s' Database has no record.\n",
                          pdata->resolver->name, pdata->resolver->table_name, 
			  pdata->resolver->database_name);
	ret = 0;
    } else {
	 resolver_log_message(RLG_DEBUG, "Resolver '%s' is created.\n",  pdata->resolver->name);
    }

    /*Close Connection*/
    pg_server_disconnect(conn_handle);
    return ret;
}

/* 
 * This routine will print some of the fields of plugin's private
 * data structure.
 */ 
static int
plugin_data_print(struct _resolver_plugin_data *pdata)
{

#ifdef DEBUG_INFO 

    int i;
    resolver_log_message(RLG_DEBUG,"Resolver Output Plugin '%s' initialization information:\n", 
    				app_name);
    resolver_log_message(RLG_DEBUG,"-----\n");
    resolver_log_message(RLG_DEBUG,"\tConffilepath:\t'%s'\n", pdata->conf_filepath) ;
    resolver_log_message(RLG_DEBUG,"\tDatabase Selected:\t'%s'\n", pdata->resolver->database_name) ;
    resolver_log_message(RLG_DEBUG,"\tTable Selected:\t'%s'\n", pdata->resolver->name) ;

    resolver_log_message(RLG_DEBUG,"-----\n");

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
resolver_init(const char *argstring, u_int32_t version, void **handle)
{
    struct _resolver_plugin_data *pdata ;

    /* standard event version validation */
    if(version != STD_EVENT_VERSION) {
        resolver_log_message(RLG_ERR, 
			"%s: Version %d doesnt match with standard event version %d\n", 
			app_name, version, STD_EVENT_VERSION);
        return -1;
    }

    if (!g_lib_refcount) {
	resolver_open_log_file(DEFAULT_RESOLVER_LOG_PATH);
        //resolver_toggle_log_level();
    }

    resolver_log_message(RLG_DEBUG, "resolver_init: called\n");

    /* if handle is NULL, return */
    if(!handle) {
	resolver_log_message(RLG_ERR, "%s: resolver_init: plugin handle pointer NULL\n", app_name);
        return -1;
    }

    /* allocating plugin's private data structure */
    pdata = (struct _resolver_plugin_data *) calloc(1, sizeof(struct _resolver_plugin_data));
    if(plugin_data_init(pdata, argstring) < 0) {
	free(pdata);
	return -1;
    }
    pdata->handle = (void *) pdata ;


    /* initialize plugin global state */
    g_lib_refcount++ ;
    resolver_log_message(RLG_DEBUG, "library_reference_count: %d\n",g_lib_refcount);
    if(g_lib_refcount == 1) {
	if(init_plugin_gdata(pdata) < 0) {
    	    resolver_close(pdata);
            return -1;
	} 			
    }

    if(plugin_data_postinit(pdata) < 0) {
    	resolver_close(pdata);
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
resolver_close(void *handle)
{
    struct _resolver_plugin_data *pdata;

    resolver_log_message(RLG_DEBUG, "resolver_close: called\n");

    if(!handle || (handle != ((struct _resolver_plugin_data *) handle)->handle) ) {
        resolver_log_message(RLG_DEBUG,"resolver_close: plugin handle invalid\n");
        return ;
    }

    pdata = (struct _resolver_plugin_data *) handle ;

    if(pdata->conf_filepath) {
	free(pdata->conf_filepath);
    }

    if(pdata->host) {
	free(pdata->host);
    }

    if(pdata->port) {
	free(pdata->port);
    }

    if(pdata->user) {
	free(pdata->user);
    }

    if(pdata->pass) {
	free(pdata->pass);
    }

    if(pdata->resolver_name) {	
	free(pdata->resolver_name);
    }

    /* release plugin data */
    free(handle);
    handle = NULL ;

    g_lib_refcount--;

    if(g_lib_refcount == 0) {
	release_plugin_gdata();
	resolver_close_log_file();
    }

    return;
}

int
do_data_search(struct _resolver_plugin_data *pdata, struct _std_event *se)
{
    struct _resolver *resolver = pdata->resolver;
    struct _resolver_std_event_vars *sev = NULL;
    struct _field_format *fields = NULL;
    struct _hash_table *search_data;
    char buf[1024];
    int count;

    u_int8_t *key, *ptr;

    key = calloc(1, resolver->key_len);
    ptr = key;

    fields = resolver->key_format;
    resolver_log_message(RLG_DEBUG, "Keys are: ");
    while (fields) {
	sev = (struct _resolver_std_event_vars *) fields->data;
        memcpy(ptr, ((void *) se + (sev->offset)), sev->field_size);
	sev->print_any(((void *) se + (sev->offset)), 1, NULL, 0);
	ptr += sev->field_size;
	fields = fields->next;
    }

    resolver_log_message(RLG_NONE, "\n");

    if (hash_search(resolver->hash_table, key, resolver->key_len, &search_data)) {
	resolver_log_message(RLG_DEBUG, "resolver: Data not Found\n");
	fields = resolver->key_format;
	memset(buf, 0, sizeof(buf));
	ptr = (u_int8_t *)buf;
	count = 0;
	while (fields && count < sizeof(buf)) {
	    sev = (struct _resolver_std_event_vars *) fields->data;
	    count += sev->print_any((void *) se + (sev->offset), 0, (char *)ptr, sizeof(buf)-count);
	    //count += snprintf(ptr, sizeof(ptr)-count, "%s:", (void *)se + (sev->offset));
	    ptr += count;
	    fields = fields->next;
	}
	buf[count-1] = '\0';
        fields = resolver->value_format;
	while (fields) {
	    sev = (struct _resolver_std_event_vars *) fields->data;
	    memcpy(((void *) se + (sev->offset)), buf, 
		    	count>(sev->field_size)?(sev->field_size):count);
	    sev->print_any(((void *) se + (sev->offset)), 1, NULL, 0);
	    fields = fields->next;
	}
	free(key);
	return -1;
    }

    fields = resolver->value_format;
    ptr = search_data->value;

    resolver_log_message(RLG_DEBUG, "Values are: ");
    while (fields) {
	sev = (struct _resolver_std_event_vars *) fields->data;
	memcpy(((void *) se + (sev->offset)), ptr, sev->field_size);
	sev->print_any(((void *) se + (sev->offset)), 1, NULL, 0);
	ptr += sev->field_size;
	fields = fields->next;
    }

    resolver_log_message(RLG_NONE, "\n");

    free(key);
    return 0;
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
void
resolver_output(struct _std_event *searray, u_int32_t nse,
			struct _output_data **output_data_list, void *handle)
{
    int i ;
 
    struct _resolver_plugin_data *pdata ;  
    struct _std_event *se ;


    if(!handle || handle != ((struct _resolver_plugin_data *) handle)->handle) {
    	resolver_log_message(RLG_ERR,"resolver_output: plugin handle invalid\n");
        return;
    }

    pdata = (struct _resolver_plugin_data *) handle ;

    resolver_log_message(RLG_DEBUG ,"resolver_output: called for resolver %s\n", 
    							pdata->resolver_name);


    /* return is hash table is not created.*/
    if (!pdata->resolver->hash_table) {
	return;
    }

    /* return if nothing to be written to archieve file */
    if (searray == NULL) {
	return ;
    }

    /* traverse through all elements of SE array */
    for(i=0; i<nse; i++) {
        se = searray + i ;
	do_data_search(pdata, se);
    }

    resolver_monitor_logsize();

    return;
}

void
resolver_debug(void)
{
    logging_on++;

    if (logging_on < g_lib_refcount) return;

    resolver_toggle_log_level();
    logging_on = 0;
    resolver_log_message(RLG_DEBUG,"resolver_debug: log level toggled\n");
    return ;
}

/*
 * #######################################################################
 * Library Routines Ends 
 * #######################################################################
 */


