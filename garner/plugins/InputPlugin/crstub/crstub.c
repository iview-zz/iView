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

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <arpa/inet.h>

#include "crstub.h"
#include "utils.h"

#define NUM_OF_KEYS 72
#define __FO(type, field)    ((u_int32_t)&(((type *)0)->field))
#define __ROUTINES(TYPE)   crstub_cast_##TYPE

/* key value map  */
kv_map key_value[] = {

	{ "date"  , __FO(struct _std_event, system.timestamp) , __ROUTINES(date_t), PROCESS },
	{ "time"  , __FO(struct _std_event, system.timestamp) , __ROUTINES(date_t), PROCESS },
	{ "protocol"  , -1 , NULL, PROCESS },
	{ "recv_bytes"  , -1 , NULL, PROCESS },
	{ "filename"  , -1 , NULL, PROCESS },
	{ "vconnid"  , __FO(struct _std_event, fw.v_conn_id) , __ROUTINES(u_int32_t), PROCESS },
	{ "src_ip"  , __FO(struct _std_event, network.src_ip) , __ROUTINES(ipaddr_t), PROCESS },
    
	{ "dst_ip"  , __FO(struct _std_event, network.dst_ip) , __ROUTINES(ipaddr_t), NO_CONVERTION },
    { "tran_src_ip"  , __FO(struct _std_event, fw.t_src_ip) , __ROUTINES(ipaddr_t), NO_CONVERTION },
    { "tran_dst_ip"  , __FO(struct _std_event, fw.t_dst_ip) , __ROUTINES(ipaddr_t), NO_CONVERTION },

	{ "log_component"  , __FO(struct _std_event, log.log_component) , __ROUTINES(u_int8_t), GET_INDEX },
	{ "log_subtype"  , __FO(struct _std_event, log.log_subtype) , __ROUTINES(u_int8_t), GET_INDEX },
	{ "priority"  , __FO(struct _std_event, log.severity) , __ROUTINES(u_int8_t), GET_INDEX },
	{ "dir_disp"  , __FO(struct _std_event, fw.direction) , __ROUTINES(u_int32_t), GET_INDEX },
	{ "FTP_direction"  , __FO(struct _std_event, http_ftp.direction) , __ROUTINES(direction_t), GET_INDEX },
	{ "log_type" , __FO(struct _std_event, log.log_type) , __ROUTINES(u_int8_t), GET_INDEX },

	{ "tran_src_port"  , __FO(struct _std_event, fw.t_src_port) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "tran_dst_port"  , __FO(struct _std_event, fw.t_dst_port) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "icmp_type"  , __FO(struct _std_event, network.l4_src) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "icmp_code"  , __FO(struct _std_event, network.l4_dst) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "src_port"  , __FO(struct _std_event, network.l4_src) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "dst_port"  , __FO(struct _std_event, network.l4_dst) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "src_mac"  , __FO(struct _std_event, network.src_mac) , __ROUTINES(char_array), NO_CONVERTION },
	{ "category"  , __FO(struct _std_event, content_filter.category) , __ROUTINES(char_array), NO_CONVERTION },
	{ "file_size"  , __FO(struct _std_event, content_filter.contentlength) , __ROUTINES(int32_t), NO_CONVERTION },
	{ "contenttype"  , __FO(struct _std_event, content_filter.contenttype) , __ROUTINES(char_array), NO_CONVERTION },
	{ "deployment_mode"  , __FO(struct _std_event, device.deployment_mode) , __ROUTINES(u_int8_t), NO_CONVERTION },
	{ "device_id"  , __FO(struct _std_event, device.device_id) , __ROUTINES(char_array), NO_CONVERTION },
	/*{ "device_name"  , __FO(struct _std_event, device.device_name) , __ROUTINES(char_array), NO_CONVERTION },*/
	{ "srczonetype"  , __FO(struct _std_event, fw.src_zone) , __ROUTINES(char_array), NO_CONVERTION },
	{ "dstzonetype"  , __FO(struct _std_event, fw.dst_zone) , __ROUTINES(char_array), NO_CONVERTION },
	{ "dstname"  , __FO(struct _std_event, fw.dst_zone) , __ROUTINES(char_array), NO_CONVERTION },
	{ "duration"  , __FO(struct _std_event, fw.duration) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "srcname"  , __FO(struct _std_event, fw.src_zone) , __ROUTINES(char_array), NO_CONVERTION },
	{ "connid"  , __FO(struct _std_event, fw.conn_id) , __ROUTINES(u_int32_t), NO_CONVERTION },

	{ "domainname"  , __FO(struct _std_event, http_ftp.domain) , __ROUTINES(char_array), NO_CONVERTION },
	{ "dstdomain"  , __FO(struct _std_event, http_ftp.domain) , __ROUTINES(char_array), NO_CONVERTION },
	{ "ftpcommand"  , __FO(struct _std_event, http_ftp.req_command) , __ROUTINES(char_array), NO_CONVERTION },
	{ "httpresponsecode"  , __FO(struct _std_event, http_ftp.response) , __ROUTINES(char_array), NO_CONVERTION },
	{ "url"  , __FO(struct _std_event, http_ftp.url) , __ROUTINES(char_array), NO_CONVERTION },
	{ "FTP_url"  , __FO(struct _std_event, http_ftp.url) , __ROUTINES(char_array), NO_CONVERTION },
	{ "file_path"  , __FO(struct _std_event, http_ftp.url) , __ROUTINES(char_array), NO_CONVERTION },
	{ "classification"  , __FO(struct _std_event, idp.classification) , __ROUTINES(char_array), NO_CONVERTION },
	{ "rule_priority"  , __FO(struct _std_event, idp.rule_priority) , __ROUTINES(u_int8_t), NO_CONVERTION },
	{ "signature_id"  , __FO(struct _std_event, idp.signature_id) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "signature_msg"  , __FO(struct _std_event, idp.signature_msg) , __ROUTINES(char_array), NO_CONVERTION },
	{ "status"  , __FO(struct _std_event, log.status) , __ROUTINES(u_int8_t), NO_CONVERTION },
	{ "dst_domainname"  , __FO(struct _std_event, mail.dstdom) , __ROUTINES(char_array), NO_CONVERTION },
	{ "mailsize"  , __FO(struct _std_event, mail.mail_size) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "mailid"  , __FO(struct _std_event, mail.messageid) , __ROUTINES(char_array), NO_CONVERTION },
	{ "quarantine"  , __FO(struct _std_event, mail.qname) , __ROUTINES(char_array), NO_CONVERTION },
	{ "to_email_address"  , __FO(struct _std_event, mail.rcpts) , __ROUTINES(char_array), NO_CONVERTION },
	{ "from_email_address"  , __FO(struct _std_event, mail.sender) , __ROUTINES(char_array), NO_CONVERTION },
	{ "src_domainname"  , __FO(struct _std_event, mail.srcdom) , __ROUTINES(char_array), NO_CONVERTION },
	{ "subject"  , __FO(struct _std_event, mail.subject) , __ROUTINES(char_array), NO_CONVERTION },
	{ "email_subject"  , __FO(struct _std_event, mail.subject) , __ROUTINES(char_array), NO_CONVERTION },
	{ "out_interface"  , __FO(struct _std_event, network.dst_port_name) , __ROUTINES(char_array), NO_CONVERTION },
	{ "recv_pkts"  , __FO(struct _std_event, network.recvpackets) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "sent_bytes"  , __FO(struct _std_event, network.sentbytes) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "sent_pkts"  , __FO(struct _std_event, network.sentpackets) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "in_interface"  , __FO(struct _std_event, network.src_port_name) , __ROUTINES(char_array), NO_CONVERTION },
	{ "spamaction"  , __FO(struct _std_event, spam.spam_action) , __ROUTINES(char_array), NO_CONVERTION },
	{ "reason"  , __FO(struct _std_event, spam.spam_reason) , __ROUTINES(char_array), NO_CONVERTION },
	{ "application"  , __FO(struct _std_event, system.application) , __ROUTINES(char_array), NO_CONVERTION },
	{ "application_id"  , __FO(struct _std_event, system.applicationid) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "av_policy_name"  , __FO(struct _std_event, system.avaspolicy) , __ROUTINES(char_array), NO_CONVERTION },
	{ "spam_policy_name"  , __FO(struct _std_event, system.avaspolicy) , __ROUTINES(char_array), NO_CONVERTION },
	{ "fw_rule_id"  , __FO(struct _std_event, system.fwruleid) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "iap"  , __FO(struct _std_event, system.iapid) , __ROUTINES(u_int16_t), NO_CONVERTION },
	{ "idp_policy_id"  , __FO(struct _std_event, system.idppolicyid) , __ROUTINES(u_int32_t), NO_CONVERTION },
	{ "user_gp"  , __FO(struct _std_event, system.usergpname) , __ROUTINES(char_array), NO_CONVERTION },
	{ "user_name"  , __FO(struct _std_event, system.username) , __ROUTINES(char_array), NO_CONVERTION },
	{ "virus"  , __FO(struct _std_event, virus.virusname) , __ROUTINES(char_array), NO_CONVERTION }

};

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

static int
set_record(struct _std_event *ev_ptr, char *response, char delim, char esc, char bound)
{
	int len = strlen(response), i=0, j, k, l;
        char *key;
        while(i<len) {
                j = get_kv_pair(&k, response, delim, esc, bound);
                if(j==0) break;
                i += j;
                response += k;
                j -= k;
                l = get_key(&k, response, '=', esc);
                if(l==0){
                        printf("crstub: Invalid Key found\n");
                        response += j;
                        continue;
                } else {
                        key = strdup(response);
                        response += l;
                        j -= l;
                        l = get_value(&k, response, '=', esc, bound);
                        response += k;
                        if(l==0 && response[0]!='\0')
                                printf("crstub: Invalid Value found for %s:%s\n",key,response);
                        else{
				if(set_kv_pair(key_value, NUM_OF_KEYS, ev_ptr, key, response)==-2){
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

/*
 * Arguments:
 *	argstring - Arguments passed along with the ident line in input block.
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
crstub_init(const char *argstring, u_int32_t version, void **handle)
{
        init_map(key_value, NUM_OF_KEYS);

	return 0;
}

/*
 * Frees the internal data-structures of the library.
 */
void
crstub_close(void *handle)
{
    return;
}

/*
 * Arguments:
 *	buffer - record buffer
 *	buflen - record buffer length
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 *  handle - pointer to internal state information intialized in *_init()
 * Return Value:
 *	On success, it returns the number of records filled in searray,
 *	which may be zero if partial record is received.
 *	On failure, returns -1 in case of internal error.
 * Description:
 *	Record parser routine.
 */
int
crstub_input(const u_int8_t *buffer, u_int32_t buflen,
		struct _std_event *searray, u_int32_t nse, void *handle)
{
    char *cptr = (char *)buffer;
    u_int16_t parse_rec = 0;
    int i;

    if(buffer==NULL || searray==NULL){
	printf("crstub_input: buffer is null or searray not initialized.\n");
	return 0;
    }
    struct _std_event *ev_ptr = &searray[parse_rec];
	i = next_to_char(cptr, '\0');
    memcpy(&(ev_ptr->device.device_name), cptr, i);
    cptr += 16;
//  printf("crstub: Source IP Address : %s\n",ev_ptr->device.device_name);

    i = next_to_char(cptr, '>');
    cptr += i;

    //printf("Buffer value -%s- \n", cptr);
    if(set_record(ev_ptr, cptr, ' ', '\\', '"')>0) {
	parse_rec++;
    }
    return parse_rec;
}
