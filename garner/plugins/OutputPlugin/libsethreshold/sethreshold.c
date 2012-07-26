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
#include <unistd.h>
#include <assert.h>
#include <time.h>
#include <errno.h>

#include "sethreshold.h"

/* 
 * -----------------------------------------------------------------------
 * MACRO definition
 * -----------------------------------------------------------------------
 */
#define DEFAULT_MAX_SE		10000 	/* default value for SE threshold  */

/*
 * -----------------------------------------------------------------------
 * Structure declaration
 * -----------------------------------------------------------------------
 */

/* plugin's private data structure to maintain stat information */
struct _plugin_data{
    u_int32_t	max_se; 		/* max SEs allowed in given period */
    u_int32_t	se_count;  		/* counts SEs */
    u_int8_t	drop_flag;		/* drop flag */
    u_int32_t   livetime;		/* time stamp for logs which doesnt have timestamp */

	void *handle;
};

#define IS_SE_DROP_FLAG_SET(pdata) 	(pdata->drop_flag ? 1:0)
#define SET_SE_DROP_FLAG(pdata)		(pdata->drop_flag = 1)
#define RESET_SE_DROP_FLAG(pdata)	(pdata->drop_flag = 0)
		
#define RESET_SE_COUNT(pdata)		(pdata->se_count = 0)
#define UPDATE_SE_TIME(pdata)		(pdata->livetime=time(NULL))


/*
 * -----------------------------------------------------------------------
 * Global variable definition/declaration 
 * -----------------------------------------------------------------------
 */

static char *app_name = "sethreshold";

/*
 * =======================================================================
 * Library Support Routines Starts 
 * =======================================================================
 */

#define TOKEN_LEN 64

/*
 * this routine will fill up token string in dst if it is not null
 * it will return (token length + 1)
 */
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
    	while((end!=src) && (*end==' ' || *end=='\t' || *end=='\n')){
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
	int offset ;

	offset = 0 ;

    /* initialize SE threshold value */
    offset += get_next_token(arg_base+offset,token);
    if((pdata->max_se = atoi(token)) <= 0){
		/* set SE Threshold value to default */ 
		pdata->max_se = DEFAULT_MAX_SE ;
    }

    RESET_SE_DROP_FLAG(pdata) ;
	RESET_SE_COUNT(pdata);
	UPDATE_SE_TIME(pdata);		
    /* releasing copied argument string */
    free(arg_base);
   
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
    fprintf(stdout,"SEThreshold Output Plugin '%s' initialization information:\n",
					app_name);
    fprintf(stdout,"-----\n");
    fprintf(stdout,"\tSE Threshold value:\t%d\n", pdata->max_se);

    fprintf(stdout,"-----\n");

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
 *  handle - to store an pointer to internal state information.
 * Return Value:
 *	Returns 0 on success, -1 on failure.
 *  Pointer to internal state information in 'handle', if required.
 *	Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *	This routine would be called once by garner during initialization.
 *	Version mismatch can be check during init itself.
 */
int
sethreshold_init(const char *argstring, u_int32_t version, void **handle)
{
	struct _plugin_data *pdata;

    /* standard event version validation */
    if(version != STD_EVENT_VERSION) {
        fprintf(stderr, "%s: Version %d doesnt match with standard event version %d\n",
                                             app_name, version, STD_EVENT_VERSION);
        return -1;
    }

	/* if handle is NULL, return */
    if(!handle) {
        fprintf(stderr, "%s: sethreshold_init: plugin handle pointer NULL\n", app_name);
        return -1;
    }

    /* allocating plugin's private data structure */
    pdata = (struct _plugin_data *) calloc(1, sizeof(struct _plugin_data));
    if(plugin_data_init(pdata, argstring) < 0) {
		free(pdata);
		return -1;
    }
	pdata->handle = (void *) pdata;

	/* return handle to plugin open instance */
    *handle = (void *) pdata ;

    /* print plugin state information */
    plugin_data_print(pdata);
    
    return 0;
}


/*
 * Frees the internal data-structures of the library.
 */
void
sethreshold_close(void *handle)
{
	struct _plugin_data *pdata;

    if(!handle || (handle != ((struct _plugin_data *) handle)->handle) ){
        fprintf(stderr,"sethreshold_close: plugin handle invalid\n");
        return ;
    }

    pdata = (struct _plugin_data *) handle ;

	/* release plugin data structure */	
    free(pdata);

    return;
}

/*
 * Arguments:
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 *	output_data_list - 2D pointer to output data list
 *  handle - pointer to internal state information intialized in *_init()
 * Description:
 *      Output plugin, can be formatter or processor
 */
void
sethreshold_output(struct _std_event *searray, u_int32_t nse,
			struct _output_data **output_data_list, void *handle)
{
    int i ;
	struct _std_event *se ;
	struct _plugin_data *pdata ;

	if(!handle || handle != ((struct _plugin_data *) handle)->handle) {
        fprintf(stderr,"sethreshold_output: plugin handle invalid\n");
        return;
    }
    pdata = (struct _plugin_data *) handle ;

    if(searray == NULL){
		return ;
    }

    /* traverse through all elements of SE array */
    for(i=0; i<nse; i++) {
		se = searray + i ;

		if(IS_SE_DROP_FLAG_SET(pdata)) {
			fprintf(stdout, "%s: DROPPING SE\n",app_name);

			se->gr_data.action = se->gr_data.action==4?se->gr_data.action:SE_ACTION_DROP ;
			continue;
		} 
		
		pdata->se_count++;

		if(pdata->se_count > pdata->max_se) {
			fprintf(stdout, "%s: SE_COUNT > MAX_SE\n",app_name);

			SET_SE_DROP_FLAG(pdata);
			fprintf(stdout, "%s: DROP SE FLAG SET\n",app_name);

       			se->gr_data.action = se->gr_data.action==4?se->gr_data.action:SE_ACTION_DROP ;
        	} else {
			se->gr_data.action = se->gr_data.action==4?se->gr_data.action:SE_ACTION_ACCEPT ;
			if( ! se->system.timestamp) {
			    se->system.timestamp = pdata->livetime;
			}
		}
    }
    return;
}

void
sethreshold_event(void *handle)
{
    struct _plugin_data *pdata;

    if(!handle || handle != ((struct _plugin_data *) handle)->handle) {
        fprintf(stderr,"sethreshold_event: plugin handle invalid\n");
        return;
    }
    pdata = (struct _plugin_data *) handle;

    fprintf(stdout,"sethreshold_event: timestamp: '%lu' --> SE COUNT: '%d'\n", 
								time(NULL),pdata->se_count);

    RESET_SE_DROP_FLAG(pdata);
    RESET_SE_COUNT(pdata);
    UPDATE_SE_TIME(pdata);
    return ;
}


/*
 * #######################################################################
 * Library Routines Ends 
 * #######################################################################
 */


