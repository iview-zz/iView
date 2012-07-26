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
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>


#define __USE_XOPEN
#include <time.h>
#include "utils.h"

#define CR_MAX_LOG_TYPE 5
#define CR_MAX_LOG_COMPONENT 19	
#define CR_MAX_LOG_SUBTYPE 8
#define CR_MAX_LOG_PRIORITY 7 
#define CR_MAX_IP_PROTOCOL 137
#define CR_MAX_FTP_DIRECTION 1
#define CR_MAX_FW_DIRECTION 2

static char *log_type[] = {
    "",
    "Firewall",
    "IDP",
    "Anti Virus",
    "Anti Spam",
    "Content Filtering"
};

static char *log_component[] = {
    "",
    "Firewall Rule",
    "Invalid Traffic",
    "Local ACLs",
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
    "IP Spoof"
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
    "Probable Spam"
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

static void
swap_kv_map(kv_map *kv1,kv_map *kv2){
	kv_map *temp = (kv_map *) calloc (1, sizeof(kv_map));
	memcpy(temp , kv1, sizeof(kv_map));
	memcpy(kv1, kv2, sizeof(kv_map));
	memcpy(kv2, temp, sizeof(kv_map));
	free(temp);
}

static void
sort_map(kv_map *key_value, int no_of_records){
	int i=0, j=0;

	for(i=0; i<no_of_records; i++){
		for(j=i+1; j<no_of_records; j++){
			if(strcasecmp(key_value[i].key, key_value[j].key) > 0){
				swap_kv_map(&key_value[i], &key_value[j]);
			}
		}
	}

}

void
init_map(kv_map *key_value, int no_of_records){
	sort_map(key_value, no_of_records);
}

static int
get_key_index(kv_map *key_value, char *key, int start, int end){
	int mid;
	int cond = 0;
	
	while(start <= end) {
		mid = (start + end) / 2;
		cond = strcasecmp(key_value[mid].key, key);
		if(cond == 0)
			return mid;
		else if(cond < 0)
			start = mid + 1;
		else
			end = mid - 1;
	}
	return -1;
}

static int
get_array_index(char **array, int arr_len, char* str){
	int index = 0;
	for(index=0; index<=arr_len; index++){
		if(!strcasecmp(str, array[index])){
			return index;
		}
	}
	return 0;
}

static int
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

/*
* return 
* index of key
* -1 if undefined key or process is undefined
* -2 if event needs to be dropped.
*/
int
set_kv_pair(kv_map *key_value, int no_of_records, struct _std_event *sptr, char *key, char *value){
	int index=0, arr_ind = 0, err;
	u_int8_t *temp = NULL;
	time_t time;
	char temp_str[32];

	index = get_key_index(key_value, key, 0, no_of_records-1);
	if(index >= 0){
		if(key_value[index].convert == GET_INDEX){
			if(!strcasecmp("log_type", key))              
				arr_ind = get_array_index(log_type, CR_MAX_LOG_TYPE, value);
			else if(!strcasecmp("log_component", key))		
				arr_ind = get_array_index(log_component, CR_MAX_LOG_COMPONENT, value);
			else if(!strcasecmp("log_subtype", key))	
				arr_ind = get_array_index(log_subtype, CR_MAX_LOG_SUBTYPE, value);
			else if(!strcasecmp("priority", key))		
				arr_ind = get_array_index(priority, CR_MAX_LOG_PRIORITY, value);
			else if(!strcasecmp("dir_disp", key))		
				arr_ind = get_array_index(fw_direction, CR_MAX_FW_DIRECTION, value);
			else if(!strcasecmp("FTP_direction", key))	
				arr_ind = get_array_index(ftp_direction, CR_MAX_FTP_DIRECTION, value);
			else{
				printf("crstub: Array undefined for key : %s\n",key);
				return -1;
			}
			temp = ((u_int8_t *) sptr) + key_value[index].offset;
			sprintf(temp_str, "%d", arr_ind);
			err = key_value[index].typecast(temp_str, temp);
		} else if(key_value[index].convert == PROCESS) {
			if(!strcasecmp("date", key)) {
				struct tm date;
				memset(&date, 0, sizeof(date));
				strptime(value, "%Y-%m-%d", &date);
				time = mktime(&date);
				temp = ((u_int8_t *) sptr) + key_value[index].offset;
				sprintf(temp_str, "%d", (u_int32_t)time);
				err = key_value[index].typecast(temp_str, temp);
			}
			else if(!strcasecmp("time", key)){
				struct tm date;
				memset(&date, 0, sizeof(date));
				temp = ((u_int8_t *) sptr) + key_value[index].offset;
				localtime_r((time_t *)temp, &date);
				strptime(value, "%H:%M:%S", &date);
				time = mktime(&date);
				sprintf(temp_str, "%d", (u_int32_t)time);
				err = key_value[index].typecast(temp_str, temp);
			}
			else if(!strcasecmp("protocol", key)) {
				if(is_numeric(value)){
					crstub_cast_u_int16_t(value, ((u_int8_t *)&(sptr->network.ip_protocol)));
				} else {
					arr_ind = get_array_index(protocols, CR_MAX_IP_PROTOCOL, value);
					temp = ((u_int8_t *) sptr) + key_value[index].offset;
					sprintf(temp_str, "%d", arr_ind);
					crstub_cast_u_int16_t(temp_str, ((u_int8_t *)&(sptr->network.ip_protocol)));
				}
			}
			else if(!strcasecmp("recv_bytes", key)) {
				if(sptr->log.log_type == LOGTYPE_FIREWALL)
					crstub_cast_u_int32_t(value, ((u_int8_t *)&(sptr->network.recvbytes)));
				else
					crstub_cast_int32_t(value, ((u_int8_t *)&(sptr->content_filter.contentlength)));
			}
			else if(!strcasecmp("filename", key)) {
				if(sptr->log.log_component == LOGCOMP_FTP)
					crstub_cast_char_array(value, ((u_int8_t *)&(sptr->content_filter.contentname)));
				else
					crstub_cast_char_array(value, ((u_int8_t *)&(sptr->mail.qname)));
			}
			else if(!strcasecmp("vconnid", key)) {
				temp = ((u_int8_t *) sptr) + key_value[index].offset;
                err = key_value[index].typecast(value, temp);
				if((sptr->fw.v_conn_id) > 0) {
					return -2;
				}
			}
			else if(!strcasecmp("src_ip", key)) {
				temp = ((u_int8_t *) sptr) + key_value[index].offset;
				err = key_value[index].typecast(value, temp);
				/*if(strlen(sptr->system.username) <= 0) {
					strcpy(sptr->system.username, value);
				}*/
			}
			else{
				printf("crstub: Process undefined for key : %s\n",key);
				return -1;
			}
		} else {
			temp = ((u_int8_t *) sptr) + key_value[index].offset;
			err = key_value[index].typecast(value, temp);
		}
		return index;
	}
	return -1;
}

int
crstub_cast_u_int32_t(const char *string, u_int8_t *dst)
{
    u_int32_t x;
    char *end=NULL;
    x = strtoul(string, &end, 0);
	memcpy(dst, &x, sizeof(u_int32_t) );
    if(end && *end != '\0') {
		return 1;
	} else {
		return 0;
	}
	return 0;
}

int
crstub_cast_u_int16_t(const char *string, u_int8_t *dst)
{
    u_int16_t x;
    char *end=NULL;
    x = strtoul(string, &end, 0);
	memcpy(dst, &x, sizeof(u_int16_t) );
    if(end && *end != '\0') {
		return 1;
	} else {
		return 0;
	}
	return 0;
}

int
crstub_cast_u_int8_t(const char *string, u_int8_t *dst)
{
    u_int8_t x;
    char *end=NULL;
    x = strtoul(string, &end, 0);
	memcpy(dst, &x, sizeof(u_int8_t) );
    if(end && *end != '\0') {
		return 1;
	} else {
		return 0;
	}
	return 0;
}

int
crstub_cast_date_t(const char *string, u_int8_t *dst)
{
    return crstub_cast_u_int32_t(string, dst);
}

int
crstub_cast_ipaddr_t(const char *string, u_int8_t *dst)
{
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    inet_aton(string, &addr.sin_addr);
    addr.sin_addr.s_addr = ntohl(addr.sin_addr.s_addr);
    memcpy(dst,&(addr.sin_addr.s_addr),sizeof(ipaddr_t));
    return 1;
}

int
crstub_cast_direction_t(const char *string, u_int8_t *dst)
{
    return crstub_cast_u_int8_t(string, dst);
}

int
crstub_cast_char_array(const char *string, u_int8_t *dst)
{
	dst = (u_int8_t *) strcpy((char *)dst,string);
    return 0;
}

int
crstub_cast_int32_t(const char *string, u_int8_t *dst)
{
    int x;
    char *end=NULL;
    x = strtol(string, &end, 0);
	memcpy(dst, &x, sizeof(int32_t) );
	if(end) {
	    return 1;
	} else {
	    return 0;
	}
    return 0;
}
