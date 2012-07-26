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
#include <ctype.h>
#include <assert.h>

#include "devdiscovery.h"
#include "devid_hash.h"

/* 
 * -----------------------------------------------------------------------
 * MACRO definition
 * -----------------------------------------------------------------------
 */

/* default filepath for log file */
#define DEFAULT_BASEDIR_PATH                                    "/usr/local/garner/conf/" 
#define DEFAULT_REGISTERED_DEVICEID_FILENAME    "registered_deviceid.list"
#define DEFAULT_UNREGISTERED_DEVICEID_FILENAME  "unregistered_deviceid.list"

/* default size for internal buffers */
#define MAX_LEN          2048     

/*
 * -----------------------------------------------------------------------
 * Structure declaration
 * -----------------------------------------------------------------------
 */

/* plugin's private data structure to maintain stat information */
struct _devdiscovery_plugin_data{
    char        *basedir_path;                          /* configuration file path */ 
        void    *devid_hash_handle;                     /* handle of hash table */      

    void *handle;
} ;

/*
 * -----------------------------------------------------------------------
 * Global variable definition/declaration 
 * -----------------------------------------------------------------------
 */
static char *app_name = "DeviceDiscoveryOutputPlugin";

/*
 * =======================================================================
 * Library Support Routines Starts 
 * =======================================================================
 */

/*
 * this routine will fill up token string in dst if it is not null
 * it will return (token length + 1)
 */

#define TOKEN_LEN       MAX_LEN

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
plugin_data_init(struct _devdiscovery_plugin_data *pdata, const char *args)
{
    char token[TOKEN_LEN];
    char *arg_base = (char *) args;
    int offset;

    offset = 0;

    /* initialize directory path for device-id list files */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
                /* set to default conf file path */ 
                strcpy(token, DEFAULT_BASEDIR_PATH);
    }
    pdata->basedir_path = strdup(token);
    
    return 0;
}

static void
trim_start(char *str)
{
        char *start = str;

        while(isspace(*start) && *start!='\0') {
                start++ ;
        }
        str = start;

        return ;
}

static void
trim_end(char *str)
{
        char *end = NULL;
        int      len = strlen(str);

        end = str + len - 1 ;

        while(isspace(*end) && end!=str) {
                end-- ;
        }

        end++;
        *end = '\0' ;

        return;
}


static int
add_devids_from_file(struct _devdiscovery_plugin_data *pdata, char *filename, u_int8_t status)
{
        FILE *fp;
        char line[1024];
        char *cp;

        if(!filename) {
                fprintf(stderr, "%s: add_devids_from_file: invalid filename\n", app_name);
                return -1;
        }

        /* open the file */
        fp = fopen(filename, "r");
        if(fp == (FILE *)NULL) {
                fprintf(stderr, "%s: add_devids_from_file: couldnt open file '%s'\n", app_name, filename);
                
                /* return normally */
                return 0;
        }
        
//      fprintf(stdout, "%s: add_devids_from_file: reading device-id list from file '%s'\n", app_name, filename);

        /* get device id entry */
    while(fgets(line, sizeof(line), fp)) {
                line[sizeof(line)-1] = '\0' ;

                cp = line ;
        
                trim_start(cp);

                if(*cp == '#') {
                        continue;
                }

                trim_end(cp);
        
/*
                while(!isalnum(*cp) && *cp!='\0') {
                        cp++ ;
                }
*/
                if(strlen(cp)) {

                        /* add device id entry into hash table with supplied status */
                        if(devid_hash_add(&(pdata->devid_hash_handle), cp, status) >=0) {
                                fprintf(stdout, "%s: add_devids_from_file: registered device-id: '%s'\n", app_name, cp);
                        } 
            }
        }
        
        /* clode the file */
        fclose(fp);

        return 0;
}

static int
plugin_data_postinit(struct _devdiscovery_plugin_data *pdata)
{
        char    filename[MAX_LEN];
        int     ret;    

        snprintf(filename, sizeof(filename), "%s/%s", pdata->basedir_path, DEFAULT_REGISTERED_DEVICEID_FILENAME);
        ret = add_devids_from_file(pdata, filename, DEVICEID_STATUS_REGISTERED);
        if(ret < 0) {
                fprintf(stderr, "%s: plugin_data_postinit: registered device-id cache preparation failed\n", app_name);
                return -1;
        }

        snprintf(filename, sizeof(filename), "%s/%s", pdata->basedir_path, DEFAULT_UNREGISTERED_DEVICEID_FILENAME);
        ret = add_devids_from_file(pdata, filename, DEVICEID_STATUS_UNREGISTERED);
        if(ret < 0) {
                fprintf(stderr, "%s: plugin_data_postinit: non registered device-id cache preparation failed\n", app_name);
                return -1;
        }
                 
        return 0;
}

/* 
 * This routine will print some of the fields of plugin's private
 * data structure.
 */ 
static int
plugin_data_print(struct _devdiscovery_plugin_data *pdata)
{
#ifdef DEBUG_INFO 
    int i;

        fprintf(stdout, "%s: plugin_data_print: Device Discovery Output Plugin Configuration:\n", app_name);
    fprintf(stdout,"%s: plugin_data_print: ----------\n");
    fprintf(stdout,"\tBase Directory Path:\t%s\n", pdata->basedir_path);
    fprintf(stdout,"%s: plugin_data_print: ----------\n");

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
 *      argstring - Arguments passed along with the output line in output block.
 *      version - version of garner.
 *      handle - to store an pointer to internal state information.
 * Return Value:
 *      Returns 0 on success, -1 on failure.
 *      Pointer to internal state information in 'handle', if required.
 *      Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *      This routine would be called once by garner during initialization.
 *      Version mismatch can be check during init itself.
 */
int
devdiscovery_init(const char *argstring, u_int32_t version, void **handle)
{
    struct _devdiscovery_plugin_data *pdata ;

    /* standard event version validation */
    if(version != STD_EVENT_VERSION) {
        fprintf(stderr, "%s: devdiscovery_init: Version %d doesnt match with standard event version %d\n", 
                                                                        app_name, version, STD_EVENT_VERSION);
        return -1;
    }

    /* if handle is NULL, return */
    if(!handle) {
                fprintf(stderr, "%s: devdiscovery_init: plugin handle pointer NULL\n", app_name);
        return -1;
    }

    /* allocating plugin's private data structure */
    pdata = (struct _devdiscovery_plugin_data *) calloc(1, sizeof(struct _devdiscovery_plugin_data));
    if(plugin_data_init(pdata, argstring) < 0) {
                free(pdata);
                return -1;
    }
    pdata->handle = (void *) pdata ;

    if(plugin_data_postinit(pdata) < 0) {
        devdiscovery_close(pdata);
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
devdiscovery_close(void *handle)
{
    struct _devdiscovery_plugin_data *pdata;

    if(!handle || (handle != ((struct _devdiscovery_plugin_data *) handle)->handle) ) {
        fprintf(stdout,"%s: devdiscovery_close: plugin handle invalid\n", app_name);
        return ;
    }
    pdata = (struct _devdiscovery_plugin_data *) handle ;

        devid_hash_delete_all(&(pdata->devid_hash_handle));

    if(pdata->basedir_path) {
                free(pdata->basedir_path);
    }

    /* release plugin data */
    free(handle);
    handle = NULL ;

    return;
}

/*
 * Arguments:
 *      searray - an array of standard events
 *      nse - number of elements in searray.
 *      output_data_list - 2D pointer to output data list
 *      handle - pointer to internal state information intialized in *_init()
 * Description:
 *      Output plugin, can be formatter or processor
 */
void
devdiscovery_output(struct _std_event *searray, u_int32_t nse,
                        struct _output_data **output_data_list, void *handle)
{
    int i ;
 
    struct _devdiscovery_plugin_data *pdata ;  
    struct _std_event *se ;

    if(!handle || handle != ((struct _devdiscovery_plugin_data *) handle)->handle) {
        fprintf(stderr, "%s: devdiscovery_output: plugin handle is invalid\n", app_name);
        return;
    }
    pdata = (struct _devdiscovery_plugin_data *) handle ;
    
        /* return if nothing to be written to archieve file */
    if(searray == NULL) {
           return ;
    }

    /* traverse through all elements of SE array */
    for(i=0; i<nse; i++) {
                u_int8_t dev_status = 0;

        se = searray + i ;




        //if(strcmp(se->device.device_id,"new")){  // If new ip address found by fwstub then do nothing to this event.
        if(se->gr_data.action != 2){  // If new ip address found by fwstub then do nothing to this event.

                /* If device id is null then set it to unknown Case when fw type is falsely selected */ 
                if(se->device.device_id[0]=='\0'){ 
                        strcpy(se->device.device_id,"unknown");
                }

                /* find deviceid in hash table and get device status */
                dev_status = devid_hash_get_status(&(pdata->devid_hash_handle), se->device.device_id);
                if(dev_status == DEVICEID_STATUS_REGISTERED) {
                        /*      REGISTERED DEVICE */
//                      fprintf(stdout, "%s: devdiscovery_output: device-id '%s' is REGISTERED\n", app_name, se->device.device_id); 
                        /*      accept the SE */
                } else if(dev_status == DEVICEID_STATUS_UNREGISTERED) {
                        /*      UNREGISTERED DEVICE */
//                      fprintf(stdout, "%s: devdiscovery_output: device-id '%s' is UNREGISTERED\n", app_name, se->device.device_id); 
                        
                        /* drop the SE */
                        se->gr_data.action = SE_ACTION_DROP;
                } else if(dev_status == DEVICEID_STATUS_NOT_FOUND) {
                        /*      NEW DEVICE */
//                      fprintf(stdout, "%s: devdiscovery_output: device-id '%s' is NEW DEVICE\n", app_name, se->device.device_id); 
                        /* Id id not found then check for Ip 
                        */
                        dev_status = devid_hash_get_status(&(pdata->devid_hash_handle), se->device.device_name);        

						if( dev_status ==  DEVICEID_STATUS_REGISTERED) {
								if(!strcmp(se->device.device_id,"unknown")){
										devid_hash_add(&(pdata->devid_hash_handle), se->device.device_id, DEVICEID_STATUS_UNREGISTERED);
								}else{ 
										devid_hash_add(&(pdata->devid_hash_handle), se->device.device_id, DEVICEID_STATUS_REGISTERED);
								}
								se->gr_data.action = SE_ACTION_NEWDEV_ALERT;
						}else  {
						/* accept this SE, further SE for same device will be dropped untill device is registered */
								devid_hash_add(&(pdata->devid_hash_handle), se->device.device_id, DEVICEID_STATUS_UNREGISTERED);
								se->gr_data.action = SE_ACTION_NEWDEV_ALERT;
						}
                  }
                } else {
					if (se->gr_data.action == 2) {			/*New Devices*/
						strcpy(se->device.device_id,"new");
					} else { 
                        /*      ERROR */
                        fprintf(stderr, "%s: devdiscovery_output: invalid device status 2 '%d' for device id '%s'\n", app_name, dev_status, se->device.device_id);
					}
                }
            }
        

    return;
}

void
devdiscovery_debug(void)
{
    return ;
}

/*
 * #######################################################################
 * Library Routines Ends 
 * #######################################################################
 */
