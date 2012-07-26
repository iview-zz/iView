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
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "fwstub.h" 
#include "fwstub_utils.h"
#include "utils.h"
#include "config.h"
#include <EXTERN.h>
#include <perl.h>

/*global map for ip to fwtype mapping to be filled wihile initialization
 *
*/
static struct _iplist *drop_ip_map=NULL;

#ifdef ENABLE_FWSTUB_ALLOW_ALL
static struct _firewall_info *default_fw = NULL;
#endif

extern  struct _ip_fwtype_map * g_ip_fwtype_map_hash;
static struct _ip_fwtype_map * found_ip_fwtype_map;

/* default size for internal buffers */
#define         MAX_LEN          2048


/* default filepath for log file */
#define DEFAULT_CONFFILE_PATH           "/usr/local/garner/garner/plugins/InputPlugin/fwstub/conffile.conf"
#define DEFAULT_MSGID_PATH           "/usr/local/garner/garner/plugins/InputPlugin/fwstub/msgid.conf"
static char value_buffer[1024];

/*
 * -----------------------------------------------------------------------
 * Structure declaration
 * -----------------------------------------------------------------------
 */

/* plugin's private data structure to maintain stat information */
struct _plugin_data{
    char *msgid_filepath;    /* message id mapping conf file */
    char *conf_filepath ;   /* configuration file path */
    void *handle    ;
} ;


/*
 * -----------------------------------------------------------------------
 * Global variable definition/declaration
 * -----------------------------------------------------------------------
 */

//static char *app_name = "OPPOSTGRES";
static u_int32_t g_lib_refcount = 0 ;       /* library reference count */

//enum log_level_t log_level = LG_ERR;

#define TOKEN_LEN       MAX_LEN

#ifdef REGEX
#define MAX_REGEX_EVENTS 20000
STRLEN n_a;
static PerlInterpreter *my_perl;
SV *sv;
int regex_event_count=0;
#endif

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
    printf( "plugin conf file is set to '%s'\n", pdata->conf_filepath);

    /* initialize conf file path */
    offset += get_next_token(arg_base+offset,token);
    if(!strcmp(token,"")){
        /* set to default conf file path */
        strcpy(token, DEFAULT_MSGID_PATH);
    }
    pdata->msgid_filepath = strdup(token);
    printf( "plugin messageid  conf file is set to '%s'\n", pdata->msgid_filepath);
    return 0;
}

/*This is a supporting function for set_kvpair
 */
static int
get_kv_pair(int *trim, char *str, char delim, char esc, char bound){
    int pos=0,i=0;
    /***  Trim characters   ***/
    while((str[i]==' ' || str[i]==delim) && str[i]!='\0') i++;
    /***  Set trim count  ***/
    *trim = i;
    if(str[i]=='\0')
            return 0;
    pos = i;
    while(str[pos]!=delim && str[pos]!='\0') {
        if(str[pos]==bound){
            pos++;
                while(str[pos]!='\0' && str[pos]!=bound) pos++;
        }
        if(str[pos]==esc)
            pos ++;
        pos++;
    }
    if(str[pos] == delim) {
        str[pos++] = '\0';
    }
    return pos;

}

/*This is a supporting function for set_kvpair
 */
static int
get_key(int *trim, char *str, char delim, char esc){
    int pos=0,i=0;
    /***  Trim spaces   ***/
    while(str[i]!='\0' && str[i]==' ') i++;
    /***  Set trim count  ***/
    *trim = i;
    if(str[i]=='\0' || str[i]==delim)
        return 0;
    pos = i;
    while(str[pos]!=delim && str[pos]!='\0') {
        if(str[pos]==esc)
            pos ++;
        pos++;
    }
    if(str[pos] == delim) {
        str[pos++] = '\0';
    }
    return pos;
}

/*This is a supporting function for set_kvpair
 */
static int
get_value(int *trim, char *str, char delim, char esc, char bound){
    int i=0, len=strlen(str);
    *trim = 0;
    if(bound!='\0' && str[i]!=bound)
        bound = '\0';
    else if(bound!='\0' && str[i]==bound){
        i++;
        len--;
        (*trim)++;
    }
    while(str[i]!='\0' && str[i]!=bound){
        if(str[i]==esc) i++;
        i++;
    }
    if(i!=len)
        return 0;
    else
        str[len] = '\0';
    return i;
}

/*
 * * return
 * * index of key
 * * -1 if undefined key or process is undefined
 * * -2 if event needs to be dropped.
 * */
int
set_kv_pair( struct _kv_rel *key_val_rel_map, struct _std_event *sptr, char *key, char *value){
	int i=1,j=0;
	struct _kv_rel *kvrl = NULL;

	if(key_val_rel_map==NULL){
		printf ("Empty key value relation map found\n"); 
	}else{
		HASH_FIND_STR(key_val_rel_map , key , kvrl);
		while(kvrl!=NULL){
			i=0;
			j=0;
			strcpy(value_buffer,value);
			while(kvrl->conversion_fn[i]!=NULL && i<kvrl->fn_index){
				j=kvrl->conversion_fn[i++]( sptr,value_buffer) ;
				switch(j){
					case -3: //dont execute translation fn and exit while loop 
						 
					case -1: //Exit from while loop 
						 i=kvrl->fn_index;
						 break;
					case -2: //Exit function (Drop event)
						 return -2;
						 break;
					default: ;
				}
			}
			//printf ("No. of conversions Done %d for key %s final value %s\n",i,key,value);
			if(j!=-3){
				kvrl->se_var->typecast_st(kvrl->key,kvrl->se_var,sptr,value_buffer);
			}

			kvrl=kvrl->next;
			i=0;
		}
	/*	if(i){
			printf ("Key value not found in key_val_rel_map key=%s value=%s \n",key,value);
		}
	*/
	}
	return 1;
}


/* parsing logs for key value type of firewalls
 */
static int
parse_keyvalue(struct _std_event *ev_ptr,char *response,struct _kv_info *kv){
	int len = strlen(response), i=0, j=0, k, l;
    char *key;
    // printf("Buffer =%s=\n",response);
    while(i<len) {
        j = get_kv_pair(&k, response, kv->delimiter, kv->escape, kv->wboundry);
        if(j==0) break;
        i += j;
        response += k;
        j -= k;
        //printf("Pair : %s\n",response);
        l = get_key(&k, response, kv->kv_seperator,kv->escape);
        if(l==0){
           //printf("crstub: Invalid Key found\n");
            response += j;
            continue;
        } else {
            key = strdup(response);
            response += l;
            j -= l;
            l = get_value(&k, response,kv->kv_seperator, kv->escape, kv->wboundry);
            response += k;
            if(l==0 && response[0]!='\0'){
                //printf("crstub: Invalid Value found for %s:%s\n",key,response);
            }else{
                 //printf("Key : -%s- Value : -%s-\n",key,response);
                if(set_kv_pair(kv->kv_rel_hash,ev_ptr, key, response)==-2){
		    if(key) {
			free(key);
		    }
                    /***  Drop the event    ***/
                    return -2;
                }
				
            }
            response += (j-k);
            if(key) {
                free(key);
            }
        }
    }
    return 1;	
}


#ifdef REGEX
/* parsing logs for regex type of firewalls
 */
static int
parse_regex(struct _std_event *ev_ptr,char *response, struct  _log_info *l_info){
	struct _kv_rel *kvrl=NULL;	
	struct _kv_rel *inner_kvrl=NULL;	
	SV *svp;
	int i,j=0;
	/*
 	* Execute the regex in perl interpreter
 	* It will extract values for all keys from the buffer 
 	*/ 
	if( SvIV( eval_pv( l_info->log_regex , FALSE ) ) ){
	
	/* Iterate through each node of the kv_rel_hash
 	* and set its value in standard event
 	*/
		for( kvrl=l_info->kv_rel_hash; ( kvrl != NULL ) ; kvrl=(struct _kv_rel *) (kvrl->hh.next) ) {
			//printf("Key -%s-\n", kvrl->key);
			inner_kvrl=kvrl;
			while(inner_kvrl!=NULL){
				strcpy( value_buffer, SvPV( get_sv(inner_kvrl->key,FALSE) , n_a) );	
				//printf("value -%s-\n", value_buffer);
                i=0;
				j=0;
                while(inner_kvrl->conversion_fn[i]!=NULL && i<inner_kvrl->fn_index){
                    j=inner_kvrl->conversion_fn[i++] (ev_ptr,value_buffer);
                    switch(j){
                        case -3: //dont execute translation fn and exit while loop 

                        case -1: //Exit from while loop 
                                 i=kvrl->fn_index;
                                     break;
                        case -2: //Exit function (Drop event)
                                     return -2;
                                     break; 
                        default: ;
                    }

                }
                //printf ("No. of conversions Done %d for key %s\n",i,kvrl->key);
                if(j!=-3){
                    inner_kvrl->se_var->typecast_st(inner_kvrl->key,inner_kvrl->se_var,ev_ptr,value_buffer);
                }
                inner_kvrl=inner_kvrl->next;
			}
        }

		return 1;
	}else{
		printf("Log Regex did not work\n");
		return -1;
	}
}
#endif
/*
 * Set Record function called with following arguments
 * Se pointer
 * buffer pointer
 * returns number of standard events filled from buffer
 */

static int
set_record(struct _std_event *ev_ptr, char *response,struct _firewall_info *fw_info){

	if(fw_info){
		/* equals to NULL means its a key value firewall
 		*  else a regular expression firewall
 		*/
		if(fw_info->fw_regex == NULL) {
			//printf(" key value type log \n");
			if(parse_keyvalue(ev_ptr,response,fw_info->un.kv)<0){
				//printf("Not able to parse kv_pair\n");	
				return -1;
			}
		}else{
#ifdef REGEX
			if( regex_event_count++ < MAX_REGEX_EVENTS ){
				char logid[50];
				//int i_log_id;
				struct _log_info *found_log_info=NULL;
				//printf(" regex type log $log=%s\n",response);
				sv_setpvf(sv , "$log='%s'" , response);
				eval_sv(sv , G_SCALAR);

				/* Apply fw_info->regex and get log id
				* use that log id to get log_info struct from log_info_hash
				*/ 
				if(SvIV(eval_pv(fw_info->fw_regex,TRUE))){
					strncpy(logid,SvPV(get_sv("logtype" , FALSE) , n_a), sizeof(logid)-1);
					//printf(" logtype = -%s-\n" , logid);
					//i_log_id=atoi(logid);	
					HASH_FIND_STR(fw_info->un.log_hash, logid , found_log_info);

					if(found_log_info==NULL){
						printf(" no log info found for logid %s\n",logid);
						return -1;
					}
					if(  parse_regex( ev_ptr, response, found_log_info )<0  ){
						printf(" parsing regex error  %s\n",logid);
						return -1;
					}
				}else{
					printf("fw_regex did not work \n");
				}
			}else{
				regex_event_count=0;
				perl_reset();
			}
#endif
		}
		
	}else{
		printf("fw_info for given ip address is blank.%s\n",response);
		return -1;
	} 
	return 1;
	
	
}

/* initialize and start perl interpreter
 */
#ifdef REGEX
int perl_init(){
	int myargc=0;
	char **myenv = NULL;
	char **myargv = NULL;
	char *embedding[]={"","-e","0"};

	PERL_SYS_INIT3(&myargc, &myargv, &myenv);

	my_perl=perl_alloc();
        sv=NEWSV(1099,0);
        perl_construct(my_perl);

	PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
    
	perl_parse(my_perl, NULL, 3, embedding, NULL);
        perl_run(my_perl);
	
	return 1;
}	

void perl_reset()
{
	if (perl_finish()==1){
		printf(" Perl interpreter closed \n");
	}else{
		
		printf(" Perl interpreter close Error \n");
	}
	if (perl_reinit()==1){
		printf(" Perl interpreter restart \n");
	}else{
		printf(" Perl interpreter restart Error \n");
	}
}

int
perl_finish()
{
    if(!my_perl) {
        return 0;
    }
    perl_destruct(my_perl);
    perl_free(my_perl);

    //PERL_SYS_TERM();
    my_perl = NULL;
    return 1;
}


int
perl_reinit()
{
	int myargc=0;
        char **myenv = NULL;
        char **myargv = NULL;
        char *embedding1[]={"","-e","0"};

		if(my_perl) {
			return 0;
		}
       // PERL_SYS_INIT3(&myargc, &myargv, &myenv);

        my_perl=perl_alloc();
        sv=NEWSV(1099,0);
        perl_construct(my_perl);

       // PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
	PL_perl_destruct_level = 2;
        perl_parse(my_perl, NULL, 3, embedding1, NULL);
        perl_run(my_perl);
	return 1;
		
}


#endif

/*
 * Initialize ip_ fw map this is a temp implementation 
 * need to read mapping from file in future.
 */
int ip_fw_map_init(){
	
	struct _ip_fwtype_map  *obj_ifm;

	for(obj_ifm=g_ip_fwtype_map_hash; ( obj_ifm != NULL ) ; obj_ifm=(struct _ip_fwtype_map *) (obj_ifm->hh.next) ) {
		obj_ifm->fw=get_firewall_info_by_name(obj_ifm->fw_name);	
		printf("Added firewall to %s\n",obj_ifm->fw_name);
	}


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
 *      argstring - Arguments passed along with the ident line in input block.
 *      version - version of garner.
 *  handle - to store an pointer to internal state information.
 * Return Value:
 *      Returns 0 on success, -1 on failure.
 *  Pointer to internal state information in 'handle', if required.
 *      Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *      This routine would be called once by garner during initialization.
 *      Version mismatch can be check during init itself.
 */
int
fwstub_init(const char *argstring, u_int32_t version, void **handle)
{
    struct _plugin_data *pdata ;	
    /* standard event version validation */
    if(version != STD_EVENT_VERSION) {
        printf( "Version %d doesnt match with standard event version %d\n", version, STD_EVENT_VERSION);
        return -1;
    }

    /* if handle is NULL, return */
    if(!handle) {
        printf( "fwstub_init: plugin handle pointer NULL\n");
        return -1;
    }

#ifdef REGEX
    perl_init();
#endif
    printf( "Started perl interpreter successfully \n");


    /* allocating plugin's private data structure */
    pdata = (struct _plugin_data *) calloc(1, sizeof(struct _plugin_data));

    if(plugin_data_init(pdata, argstring) < 0) {
        free(pdata);
        return -1;
    }

    pdata->handle = (void *) pdata ;
	
    /* initialize plugin global state */
    g_lib_refcount++ ;
	printf("library_reference_count: %d\n",g_lib_refcount);
    if(g_lib_refcount == 1) {
        if ( fwstub_parse_conffile(pdata->conf_filepath) <0 ){
            printf( "Not able to parse conf file \n");
        fwstub_close(pdata);
        return -1;
        }
        parse_msgid_file(pdata->msgid_filepath);
    }

    if(ip_fw_map_init()>0){
	printf("ip_fw_map initialized successfully \n");
    }


#ifdef ENABLE_FWSTUB_ALLOW_ALL
    default_fw = get_firewall_info_by_name("cyberoam"); 
#endif

    *handle = (void *) pdata ;
    return 0;
}



/*
 * Frees the internal data-structures of the library.
 */
void
fwstub_close(void *handle)
{
	struct _plugin_data *pdata;

	if(!handle) printf("empty handle \n");
    if(!handle || (handle != ((struct _plugin_data *) handle)->handle) ){
        printf("fwstub_close: plugin handle invalid\n");
        return ;
    }

    pdata = (struct _plugin_data *) handle ;

    /* release configuratio file path memory */
    if(pdata->conf_filepath) {
        free(pdata->conf_filepath);
        pdata->conf_filepath = NULL;
    }

	/* release plugin data */
	free(handle);
	handle = NULL ;

    /* decrease reference count and if it became '0', release plugin's global resources */
    g_lib_refcount--;
    if(g_lib_refcount == 0) {
       // release_plugin_gdata(); 
		//Function not defined yet bcos 
		//config.c doesnt have a routine to free global data

        }
#ifdef REGEX
	perl_destruct(my_perl);
    perl_free(my_perl);

	PERL_SYS_TERM();
#endif
    return;
}

/* Returns position of the char next to the given char */
static int
next_to_char(char *str,char c)
{
    int i=0;
    while (str[i] != '\0' && str[i] != c) i++;
    if (str[i] == '\0')
        return i;
    str[i] = '\0';
    return i+1;
}


/*
 * Arguments:
 *      buffer - record buffer
 *      buflen - record buffer length
 *      searray - an array of standard events
 *      nse - number of elements in searray.
 *  handle - pointer to internal state information intialized in *_init()
 * Return Value:
 *      On success, it returns the number of records filled in searray,
 *      which may be zero if partial record is received.
 *      On failure, returns -1 in case of internal error.
 * Description:
 *      Record parser routine.
 */
int
fwstub_input(const u_int8_t *buffer, u_int32_t buflen,
                struct _std_event *searray, u_int32_t nse, void *handle)
{

    char *cptr = (char *)buffer;
    u_int16_t parse_rec = 0;
    int i;
    struct _std_event *ev_ptr = NULL; 
    struct _iplist *drop_ip = NULL;

    if(buffer==NULL || searray==NULL){
        printf("crstub_input: buffer is null or searray not initialized.\n");
        return 0;
    }
 //   ev_ptr = &searray[parse_rec];
    ev_ptr = searray + parse_rec;
//    memset(ev_ptr,0,sizeof(struct _std_event));	

    i = next_to_char(cptr, '\0');
    memcpy(&(ev_ptr->device.device_name), cptr, i+1);
    cptr += 16;
    i = next_to_char(cptr, '>');
    cptr +=i;
    //printf("crstub: Source IP Address : %s\n",ev_ptr->device.device_name);
    // lookup for ip_fw_map for given ipaddress and find out _firewall_info send it to set_record fn.
    //
    strcpy(ev_ptr->log.raw_log,cptr);	
    HASH_FIND_STR(g_ip_fwtype_map_hash , ev_ptr->device.device_name, found_ip_fwtype_map);
    if(found_ip_fwtype_map){
	//printf("string sent to set_record -%s-\n",cptr); 
	strcpy(ev_ptr->device.device_id,ev_ptr->device.device_name);
	strncat(ev_ptr->device.device_id,found_ip_fwtype_map->fw->fw_name,10);
	if(set_record(ev_ptr,cptr,found_ip_fwtype_map->fw)>0){
	    parse_rec++;
	}else{
	    memset(ev_ptr,0,sizeof(struct _std_event));   
	}
    }
    else{
#ifdef ENABLE_FWSTUB_ALLOW_ALL
	strcpy(ev_ptr->device.device_id,ev_ptr->device.device_name);
	strncat(ev_ptr->device.device_id,default_fw->fw_name,10);
	if(set_record(ev_ptr,cptr,default_fw)>0){
	    parse_rec++;
	}else{
	    memset(ev_ptr,0,sizeof(struct _std_event));   
	}
#else
	HASH_FIND_STR(drop_ip_map ,  ev_ptr->device.device_name , drop_ip);
	if(!drop_ip){ // Ip not found in drop list either
	    ev_ptr->gr_data.action = (u_int8_t)2;
		if (strstr(cptr, "device_name=\"CR")) {
				struct _firewall_info *default_fw = get_firewall_info_by_name("cyberoam");
				if(set_record(ev_ptr,cptr,default_fw)>0){
						struct _ip_fwtype_map * temp;
						printf("this is Cyberoam%s = %s\n", ev_ptr->device.device_name, ev_ptr->device.device_id);
						//ev_ptr->gr_data.action = (u_int8_t)3;
						if (!(temp=is_this_reg_appliance(ev_ptr->device.device_id))) {
							goto new_appliances;
						} 
						if (!update_ip_fwtype_map(ev_ptr->device.device_name, temp)) {
							goto new_appliances;
						}
						ev_ptr->gr_data.action = (u_int8_t)4;
						printf("Marked exiting appliances for device discovery list with action %d\n",ev_ptr->gr_data.action );
						parse_rec++;
						goto safe_exit;
				}else{
						memset(ev_ptr,0,sizeof(struct _std_event));
				}
		}

	new_appliances:
	    drop_ip= (struct _iplist *) calloc (1,sizeof (struct _iplist));
	    strcpy(drop_ip->ip,ev_ptr->device.device_name);
	    strcpy(ev_ptr->device.device_id,"new");
	    HASH_ADD_STR(drop_ip_map , ip,drop_ip);
	    printf("Added new IP to drop list \n");
	    //ev_ptr->gr_data.action = (u_int8_t)SE_ACTION_NEWDEV_ALERT;
	    printf("Marked new  IP for device discovery list with action %d\n",ev_ptr->gr_data.action );
	    parse_rec++;

	}else{	
	    printf ("Could not find fw mapping for ip address --%s-- So dropping the log\n",ev_ptr->device.device_name);
	}
#endif	
	/* Temporary code 
	 * need to deleted once we finalize ip address based device discovery
	 */
    }

	safe_exit:
    return parse_rec;
}



#ifdef TEST
main(int argc, char *argv[])
{
	
    if(argc < 2) {
	printf("usage: %s <conffile>\n", argv[0]);
	return -1;
    }

    printf("main: conf file: '%s'\n", argv[1]);
    fwstub_parse_conffile(argv[1]);
    	
    return 0;
}
#endif

