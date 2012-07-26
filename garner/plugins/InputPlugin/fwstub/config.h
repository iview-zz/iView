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

#ifndef _CYBEROAM_FWSTUB_CONFIG_H_
#define _CYBEROAM_FWSTUB_CONFIG_H_

#include "fwstub_utils.h"
#include "uthash.h"

#define __FWS_FO(type, field)  	((u_int32_t)&(((type *)0)->field))
#define __FWS_ROUTINES(TYPE) 	fwstub_typecast_##TYPE, fwstub_typecast_str_##TYPE

#define KV_REL_FUNCTION_BLOCKSIZE 2

typedef int (*CONV_FN) ( struct _std_event *,char *);

struct _kv_rel {
    char *key;			 // key of keyvalue relation hash
    struct _se_vars_fws *se_var; // pointer to std event field related to key
    CONV_FN *conversion_fn;	 // array of conversion function pointers
    u_int8_t fn_index;		 
    u_int8_t fn_max;		
    u_int8_t type;		// 1 is for perl variable ("$srcip")  0 is for static value ("1")	
    struct _kv_rel *next;	// Link list to handle duplicate keys.
    UT_hash_handle hh;    
};

struct _kv_info {
    char delimiter;
    char escape;
    char wboundry;
    char kv_seperator;
    struct _kv_rel *kv_rel_hash;
};

struct _log_info {
	char *log_id;
    char *log_regex;		    // regex to get keyvalues
    struct _kv_rel *kv_rel_hash;    // head of keyvalue relation hash
    UT_hash_handle hh;
};

struct _firewall_info {
    char *fw_name;		// key of firewall hash
    char *fw_regex;		// regex to get log id
    union _un {
        struct _log_info *log_hash;	// head of log info hash
	struct _kv_info *kv;
    } un;
    UT_hash_handle hh;
    struct _firewall_info *next;
};

struct _ip_fwtype_map{
    char ip[16];            	// Key for ip-firewall relation hash
    char *fw_name;            	// name of firewall to be associate with ip
    char *fw_appid;            	// unique appid
    struct _firewall_info *fw; 	// link of firewall_info structure related to this ip.
    UT_hash_handle hh;
} ;

struct _msgid_hash{
    char msgid[64];		// Key for msgid hash
    struct _kv_rel *kv_list;	// Link list of kv_rel for assigning default value
    UT_hash_handle hh;
};


// Structure to manage ipaddress list.
struct _iplist{
	char ip[16];		//key
	UT_hash_handle hh;

};

CONV_FN config_get_func(char *fn_name);
struct _se_vars_fws *config_get_se_var_fws_by_name(const char *name);

struct _ip_fwtype_map * config_alloc_ip_fwtype_map(void);
int config_hash_ip_fwtype_map(struct _ip_fwtype_map *ip_fw_map);

struct _firewall_info * config_alloc_firewall_info(void);
struct _firewall_info * get_firewall_info_by_name(char *);
int config_insert_firewall(struct _firewall_info *fw);

struct _kv_info * config_alloc_kv_info(void);

struct _log_info * config_alloc_log_info(void);
int config_hash_log_info(struct _firewall_info *fw, struct _log_info *log);

struct _kv_rel *config_alloc_kv_rel(void);
int config_realloc_conversion_fn(struct _kv_rel *kv_rel);

int config_hash_kv_rel_to_log(struct _log_info *log, struct _kv_rel *kv_rel);
int config_hash_kv_rel_to_kv(struct _kv_info *kv, struct _kv_rel *kv_rel);

int parse_msgid_file(char *filename);

struct _ip_fwtype_map *is_this_reg_appliance(const char *appid);
int update_ip_fwtype_map(char *newip, struct _ip_fwtype_map *ip_fw_map);
#endif	
