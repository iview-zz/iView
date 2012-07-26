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
#include <stdarg.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <ctype.h>
#include <time.h>

#include "config.h"
#include "uthash.h"
#include "utils.h"
#include "fwstub_log.h"

#define MAX_LEN 2048
#define CR_MAX_LOG_TYPE 6
#define CR_MAX_LOG_COMPONENT 48
#define CR_MAX_LOG_SUBTYPE 11
#define CR_MAX_LOG_PRIORITY 7
#define CR_MAX_IP_PROTOCOL 137
#define CR_MAX_FTP_DIRECTION 1
#define CR_MAX_FW_DIRECTION 2

extern char *strptime(const char *s, const char *format, struct tm *tm);

#define GET_TOK(n,delim,value)		\
do{					\
 char *val=value;			\
        int i=0,j=0;			\
        for (j=0;j<n;j++){		\
                val=val+i;		\
                i=0;			\
                while (val[i]!=delim && val[i]!='\0') i++; \
               if(val[i]==delim){	\
                        val[i]='\0';	\
                        i++;		\
					\
                }			\
        }				\
        val[i]='\0';			\
        strcpy(value,val);		\
					\
}while(0);				\



extern struct _msgid_hash *fortigate_msgid_hash;
extern struct _msgid_hash *other_msgid_hash;
extern struct _msgid_hash *sonicwall_msgid_hash;
static char *log_type[] = {
    "",
    "Firewall",
    "IDP",
    "Anti Virus",
    "Anti Spam",
    "Content Filtering",
	"Event"
};

static char *log_component[] = {
    "",
    "Firewall Rule",
    "Invalid Traffic",
    "Appliance Access",
    "DoS Attack",
    "ICMP Redirection",
    "Source Routed",
    "Anomaly",
    "Signatures",
    "HTTP",
    "FTP",
    "SMTP",
    "POP3",
    "IMAP4",
    "Fragmented Traffic",
    "Invalid Fragmented Traffic",
    "HA",
    "Foreign Host",
    "IPMAC Filter",
    "IP Spoof",
    "GUI",
    "CLI", 
    "Console",
    "CCC",
    "IM", 
    "IPSec", 
    "L2TP", 
    "PPTP", 
    "SSL VPN", 
    "Firewall Authentication", 
    "VPN Authentication",
    "SSL VPN Authentication", 
    "My Account Authentication", 
    "Appliance", 
    "DHCP Server", 
    "Interface", 
    "Gateway",
    "DDNS", 
    "WEBCAT", 
    "IPS", 
    "Anti-Virus", 
    "Dial-In Authentication", 
    "Dial-In", 
    "Quarantine", 
    "Application",
    "Landing Page",
    "WLAN", 
    "ARP Flood",
    "HTTPS"
};

static char *log_subtype[] = {
    "",
    "Allowed",
    "Denied",
    "Detect",
    "Drop",
    "Clean",
    "Virus",
    "Spam",
    "Probable Spam",
	"Admin",
	"Authentication", 
	"System"
};

static char *priority[] = {
    "Emergency",
    "Alert",
    "Critical",
    "Error",
    "Warning",
    "Notice",
    "Information",
    "Debug"
};

static char *protocols[] = {
    "IP", "ICMP", "IGMP", "GGP", "IP_ENCAP", "ST", "TCP", "CBT", "EGP", "IGP", 
    "BBN-RCC-MON", "NVP-II", "PUP", "ARGUS", "EMCON", "XNET", "CHAOS", "UDP", "MUX", "DCN-MEAS",
    "HMP", "PRM", "XNS-IDP", "TRUNK-1", "TRUNK-2", "LEAF-1", "LEAF-2", "RDP", "IRTP", "ISO-TP4", 
    "NETBLT", "MFE-NSP", "MERIT-INP", "DCCP", "3PC", "IDPR", "XTP", "DDP", "IDPR-CMTP", "TP++",
    "IL", "IPV6", "SDRP", "IPV6-Route", "IPV6-Frag", "IDRP", "RSVP", "GRE", "DSR", "BNA", 
    "AH", "I-NLSP", "SWIPE", "NARP", "MOBILE", "TLSP", "SKIP", "IPV6-ICMP", "IPV6-NoNxt", "IPv6-Opts",
    "", "CFTP", "", "SAT-EXPAK", "KRYPTOLAN", "RVD", "IPPC", "", "SAT-MON",
    "VISA", "IPCV", "CPNX", "CPHB", "WSN", "PVP", "BR-SAT-MON", "SUN-ND", "WB-MON", "WB-EXPAK",
    "ISO-IP", "VMTP", "SECURE-VMTP", "VINES", "TTP", "NSFNET-IGP", "DGP", "TCF", "EIGRP", "OSPFIGP",
    "Sprite-RPC", "LARP", "MTP", "AX.25", "IPIP", "MICP", "SCC-SP", "ETHERIP", "ENCAP", "",
    "GMTP", "IFMP", "PNNI", "PIM", "ARIS", "SCPS", "QNX", "A/N", "IPComp", "SNP",
    "Compaq-Peer", "IPX-in-IP", "VRRP", "PGM", "", "L2TP", "DDX", "IATP", "STP", "SRP", 
    "UTI", "SMP", "SM", "PTP", "ISIS", "FIRE", "CRTP", "CRUDP", "SSCOPMCE", "IPLT",
    "SPS", "PIPE", "SCTP", "FC", "RSVP-E2E-IGNORE", "", "UDPLite", "MPLS-in-IP" 
};

static char *ftp_direction[] = {
    "Upload",
    "Download"
};

static char *fw_direction[] = {
    "",
    "Original",
    "Reply"
};

static char *status_str[] = {
    "", "Allow", "Deny", "Allow Session", "Deny Session",
    "Successful", "Failed", "Established", "Terminated",
    "Renew", "Release", "Expire", "Success"
};

static char *im_receiver_str[] = {
    "Non-Suspect", "Suspect"
};

static char *im_protocol_str[] = {
    "None", "Yahoo", "MSN"
};

static char *im_action_str[] = {
    "Login", "Message", "Webcam", "Filetransfer", "Logout"
};

static char *sslvpn_mode_str[] = {
    "Tunnel Access" , "Web Access" , "Application Access"
};
static char *sslvpn_resource_type_str[] = {
    "HTTP" , "HTTPS" , "RDP" , "TELNET" , "SSH" , "FTP"
};

#define ARRAY_LEN(X) (sizeof(X)/sizeof(*X))
#define CR_STATUS_MAX   ARRAY_LEN(status_str)
#define IM_RECEIVER_MAX ARRAY_LEN(im_receiver_str)
#define IM_PROTOCO_MAX  ARRAY_LEN(im_protocol_str)
#define IM_ACTION_MAX   ARRAY_LEN(im_action_str)
#define SSLVPN_MODE_MAX  ARRAY_LEN(sslvpn_mode_str)
#define SSLVPN_RES_T_MAX   ARRAY_LEN(sslvpn_resource_type_str)

/* local utility function */

int
r_sslvpn_resource_type(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < SSLVPN_RES_T_MAX; index++){
        if(!strcasecmp(value, sslvpn_resource_type_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_sslvpn_mode(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < SSLVPN_MODE_MAX; index++){
        if(!strcasecmp(value, sslvpn_mode_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_im_action(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < IM_ACTION_MAX; index++){
        if(!strcasecmp(value, im_action_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_im_protocol(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < IM_PROTOCO_MAX; index++){
        if(!strcasecmp(value, im_protocol_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_im_receiver(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < IM_RECEIVER_MAX; index++){
        if(!strcasecmp(value, im_receiver_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_status(struct _std_event *se, char *value)
{
    int index;
    for(index=0; index < CR_STATUS_MAX; index++){
        if(!strcasecmp(value, status_str[index])){
	    break;
        }
    }
    sprintf(value, "%d", index);
    return 0;
}

int
r_messageid(struct _std_event *se, char *value)
{
    char *ptr = NULL;

    if (!value || !se) {
	return 0;
    }

    xassert(strlen(value) == 12);

    ptr = &value[7];
    sprintf(value, "%s", ptr);
    return 0;
}

int 
r_protocol(char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_IP_PROTOCOL; index++){
        if(!strcasecmp(value, protocols[index])){
            return index;
        }
    }
	return 0;
}

int
is_numeric(const char *str){
    if(str){
        char c;
            while((c = *str++)){
                if(!isdigit(c))
                    return 0;
            }
    }
    return 1;
}

/*int 
get_tok(int n,char *value1,char delim){
	char *value=value1;
	int i=0,j=0;
	for (j=0;j<n;j++){
		value=value+i;
		i=0;
		while (value[i]!=delim && value[i]!='\0') i++;
		if(value[i]==delim){
			value[i]='\0';
			i++;
			
		}
	}
	value[i]='\0';
	strcpy(value1,value);	
}

*/
void
fwstub_assert(const char *msg, const char *file, int line)
{
	fwstub_log_message(FWSLG_ERR, "file: %s:%d, Assertion '%s' failed\n", file, line, msg);
	fprintf(stderr, "%s:%d, Assertion '%s' failed\n", file, line, msg);
	abort();
}

/* Function available in config file starts from here
 * and return value is handled in following way
 * -1 is dont call any conversion function after this
 * -2 is drop this standard event 
 * -3 is dont call translation and conversion fn after call of this fn
 */


//SONIC WALL SPECIFIC FUNCTIONC START HERE
/*
int
r_sonic_mid(struct _std_event *se,char *value){
// Very basic implementation of this function need to update soon
	if (!strcmp(value,"537")){
	//Allowed Firewall logs
		se->log.log_type =1;
		se->log.log_subtype=1;
		return -3;
	}else if (!strcmp(value,"97")){
	//Allowed web usage logs
                se->log.log_component =9;
                se->log.log_subtype=1;
		return -3;
	}else{
		return -2;
	}
}
*/

int
get_forti_mid(struct _std_event *se,char *value){
	struct _msgid_hash *obj_msg=NULL;
	struct  _kv_rel *kv=NULL;

	//printf ( " fortigate msgid = -%s-\n",value);
	HASH_FIND(hh,fortigate_msgid_hash,value,strlen(value),obj_msg);	

	if(obj_msg){
		kv=obj_msg->kv_list;	
			//printf ( " obj found and not null\n");
		while(kv!=NULL){
			//printf ( " called type cast for key = %s\n",kv->key);
			kv->se_var->typecast_st(kv->key,kv->se_var,se,kv->key);
			kv=kv->next;
		}
		return -3;
	}else{
		return -2;
	}
	
}

int
get_sonic_mid(struct _std_event *se,char *value){
	struct _msgid_hash *obj_msg=NULL;
	struct  _kv_rel *kv=NULL;


	HASH_FIND(hh,sonicwall_msgid_hash,value,strlen(value),obj_msg);	

	if(obj_msg){
		kv=obj_msg->kv_list;	
		while(kv!=NULL){
			kv->se_var->typecast_st(kv->key,kv->se_var,se,kv->key);
			kv=kv->next;
		}
		return -3;
	}else{
		return -2;
	}
	
}

int
get_other_mid(struct _std_event *se,char *value){
	struct _msgid_hash *obj_msg=NULL;
	struct  _kv_rel *kv=NULL;


	HASH_FIND(hh,other_msgid_hash,value,strlen(value),obj_msg);	

	if(obj_msg){
		kv=obj_msg->kv_list;	
		while(kv!=NULL){
			kv->se_var->typecast_st(kv->key,kv->se_var,se,kv->key);
			kv=kv->next;
		}
		return -3;
	}else{
		return -2;
	}
	
}


int 
get_date(struct _std_event *se,char *value){
	struct tm date;
        memset(&date, 0, sizeof(date));
	strptime(value, "%Y-%m-%d", &date);
	se->system.timestamp=mktime(&date);
	return -3;
}


int 
get_time(struct _std_event *se,char *value){
	struct tm date;
        memset(&date, 0, sizeof(date));
        localtime_r((time_t *)&se->system.timestamp, &date);
        strptime(value, "%H:%M:%S", &date);
	se->system.timestamp=mktime(&date);
	return -3;
}
        


int
get_sev( struct _std_event *se,char *value){
	//Values mapped to priority defined above
	if(!strcasecmp(value,"low")){
		strcpy(value,"6");
	}else if(!strcasecmp(value,"high")){
		strcpy(value,"2");
	}else{
		strcpy(value,"7");
	}
	return 0;
}

int
sonic_get_ip(struct _std_event *se,char *value){
	GET_TOK(1,':',value);
	return 0;
}


int
sonic_get_port(struct _std_event *se,char *value){
	GET_TOK(2,':',value);
	//get_tok(2,value,':');
	return 0;
}


int
sonic_get_zone(struct _std_event *se,char *value){
	GET_TOK(3,':',value);
	//get_tok(3,value,':');
	return 0;
}


int
sonic_get_proto(struct _std_event *se,char *value){
	printf ("b PROTO -%s-",value);
	GET_TOK(1,'/',value);
	//get_tok(1,value,'/');
	//printf ("PROTO -%s-",value);
	return 0;
}
// SONICWALL SPECIFIC FUNCTIONS ENDS HERE


int 
proto_normalize( struct _std_event *se,char *value){
	int i;
	if(is_numeric(value)){	
		return 0;
	}else{
		i = r_protocol(value);	
		sprintf(value, "%d", i);
		return 0;
	}
}

int 
ignore_con( struct _std_event *se,char *value){
	 if (isdigit(value[0]) && value[0]!='\0' && value[0]!=0){
		printf("Drop event  for '%s'\n", value);
		return -2;
		}
	return 0;
}

int 
r_log_component( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<= CR_MAX_LOG_COMPONENT; index++){
        if(!strcasecmp(value, log_component[index])){
             break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}

int  
r_log_subtype( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_LOG_SUBTYPE; index++){
        if(!strcasecmp(value, log_subtype[index])){
			break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}

int 
r_priority( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_LOG_PRIORITY; index++){
        if(!strcasecmp(value, priority[index])){
			break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}
int  
r_fw_dir( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_FW_DIRECTION; index++){
        if(!strcasecmp(value,fw_direction[index])){
            break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}

int 
r_ftp_dir( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_FTP_DIRECTION; index++){
        if(!strcasecmp(value, ftp_direction[index])){
			break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}

int 
r_log_type( struct _std_event *se,char *value){
	int index = 0;
    for(index=0; index<=CR_MAX_LOG_TYPE; index++){
        if(!strcasecmp(value, log_type[index])){
			break;
        }
    }
	sprintf(value, "%d", index);
	return 0;
}

int 
get_domain( struct _std_event *se,char *value){
	int i=0;
	char *rtrn=value;
	if(strncmp(value,"http://",7)==0){
		rtrn=value+7;
	}
	while(rtrn[i]!='/' && rtrn[i]!='\0')i++;
	rtrn[i]='\0';
	memcpy(value,rtrn,i+1);
	return 0;
	
}
