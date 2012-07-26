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

#ifndef _CYBEROAM_STD_EVENT_
#define _CYBEROAM_STD_EVENT_
#include <sys/types.h>

#define STD_EVENT_VERSION 0x00000011

#define STRING8 	8
#define STRING16	16
#define STRING32	32
#define STRING64	64
#define STRING128	128
#define STRING256	256
#define STRING384	384
#define STRING512	512
#define STRING1024	1024
#define STRING2048	2048
#define STRING4096	4096

/* this is done to separate a routine for char* and char */
typedef char char_array;
typedef u_int32_t date_t;
typedef u_int32_t ipaddr_t;
typedef u_int16_t port_t;
typedef u_int8_t direction_t;

/* action type to be performed on standard event */
#define SE_ACTION_ACCEPT	0
#define SE_ACTION_DROP		1
#define SE_ACTION_NEWDEV_ALERT 	2

/* log types */
#define LOGTYPE_FIREWALL 	1
#define LOGTYPE_IDP 		2
#define LOGTYPE_ANTIVIRUS 	3
#define LOGTYPE_ANTISPAM 	4
#define LOGTYPE_CONTENTFILTER   5
#define LOGTYPE_EVENT		6

/* log components */
#define LOGCOMP_FIREWALL_RULES			1
#define LOGCOMP_INVALID_TRAFFIC	 		2
#define LOGCOMP_LOCAL_ACLS			3
#define LOGCOMP_DOS_ATTACK	 		4
#define LOGCOMP_ICMP		 		5
#define LOGCOMP_SOURCE_ROUTED	 		6
#define LOGCOMP_ANOMALY		 		7
#define LOGCOMP_SIGNATURES	 		8
#define LOGCOMP_HTTP		 		9
#define LOGCOMP_FTP		       		10
#define LOGCOMP_SMTP				11
#define LOGCOMP_POP3				12
#define LOGCOMP_IMAP4				13
#define LOGCOMP_FRAGMENTED_TRAFFIC		14
#define LOGCOMP_INVALID_FRAGMENTED_TRAFFIC      15
#define LOGCOMP_HA                              16
#define LOGCOMP_FOREIGN_HOST                    17
#define LOGCOMP_IPMAC_FILTER                    18
#define LOGCOMP_IP_SPOOF                        19
#define LOGCOMP_GUI	                        20
#define LOGCOMP_CLI	                        21
#define LOGCOMP_CONSOLE	                        22
#define LOGCOMP_CCC	                        23
#define LOGCOMP_IM	                        24
#define LOGCOMP_IPSEC	                        25
#define LOGCOMP_L2TP	                        26
#define LOGCOMP_PPTP	                        27
#define LOGCOMP_SSLVPN	                        28
#define LOGCOMP_FIREWALL_AUTH	                29
#define LOGCOMP_VPN_AUTH	                30
#define LOGCOMP_SSLVPN_AUTH	                31
#define LOGCOMP_MY_ACC_AUTH	                32
#define LOGCOMP_APPLIANCE                       33
#define LOGCOMP_DHCP_SERVER	                34
#define LOGCOMP_INTERFACE			35
#define LOGCOMP_GATEWAY				36
#define LOGCOMP_DDNS                            37
#define LOGCOMP_WEBCAT                          38
#define LOGCOMP_IPS                             39
#define LOGCOMP_AV                              40
#define LOGCOMP_DIAL_IN_AUTH                    41
#define LOGCOMP_DIAL_IN                         42
#define LOGCOMP_QUARANTINE                      43
#define LOGCOMP_APPLICATION_FILTER		44
#define LOGCOMP_LANDING_PAGE			45
#define LOGCOMP_WLAN				46
#define LOGCOMP_ARPFLOOD			47
#define LOGCOMP_HTTPS		 		48


/* Log Subtypes */
#define LOGSTYPE_ALLOWED	 1
#define LOGSTYPE_DENIED		 2
#define LOGSTYPE_DETECT		 3
#define LOGSTYPE_DROP		 4
#define LOGSTYPE_CLEAN		 5
#define LOGSTYPE_VIRUS		 6
#define LOGSTYPE_SPAM		 7
#define LOGSTYPE_PROBABLE_SPAM	 8
#define LOGSTYPE_ADMIN		 9
#define LOGSTYPE_AUTHENTICATION	 10
#define LOGSTYPE_SYSTEM		 11

/* log priorities */
#define PRIORITY_EMERGENCY      0
#define PRIORITY_ALERT          1
#define PRIORITY_CRITICAL       2
#define PRIORITY_ERROR          3
#define PRIORITY_WARNING        4
#define PRIORITY_NOTIFICATION   5
#define PRIORITY_INFORMATION    6
#define PRIORITY_DEBUG          7

/* status values */
#define STATUS_ALLOW		1
#define STATUS_DENY		2
#define STATUS_ALLOW_SESSION	3
#define STATUS_DENY_SESSION	4
#define STATUS_SUCCESSFUL	5
#define STATUS_FAILED		6
#define STATUS_ESTABLISHED	7
#define STATUS_TERMINATED	8
#define STATUS_RENEW		9
#define STATUS_RELEASE		10
#define STATUS_EXPIRE		11

struct _std_event {
    u_int32_t   datalen;

    struct _gr_data {
    	u_int8_t 	action;
	u_int32_t	file_offset;
	char_array 	filename[STRING256];
    } gr_data;

    struct _device {
	char_array	device_id[STRING32];
	char_array	device_name[STRING16];
	u_int8_t	deployment_mode;
    } device;

    struct _log {
	u_int8_t	log_type;
	u_int8_t	log_component;
	u_int8_t	log_subtype;
	u_int8_t	severity;
	u_int8_t	status;
	u_int16_t	messageid;
	char_array      raw_log[STRING2048];
    } log;

    struct _system {
	date_t	timestamp;
	u_int32_t	userid;
	char_array	username[STRING64];
	u_int32_t	usergpid;
	char_array	usergpname[STRING64];
	u_int16_t	iapid;
	char_array	iap[STRING64];
	u_int16_t	applicationid;
	char_array	application[STRING64];
	char_array	avaspolicy[STRING32];
	u_int32_t	fwruleid;
	char_array	fwrule[STRING32];
	u_int32_t	idppolicyid;
	//Change for VPN Reports
	u_int16_t	appfltid;
	char_array	idp_policy[STRING64];
	//Change for VPN Reports
	char_array	appfilter_policy[STRING64];
	u_int32_t	sessionid;
	char_array	log_string[STRING128];	 
    } system;

    struct _network {
	ipaddr_t       src_ip;
	ipaddr_t       dst_ip;
	u_int16_t       l4_src;
	u_int16_t       l4_dst;
	u_int32_t       in_interface;
	u_int32_t       out_interface;
	u_int16_t       ip_protocol;
	char_array	src_port_name[STRING64];
	char_array	dst_port_name[STRING64];
	u_int32_t	recvbytes;
	u_int32_t	sentbytes;
	u_int32_t	recvpackets;
	u_int32_t	sentpackets;
	char_array      src_mac[STRING32];
	char_array	protocol_group[STRING64];	
    } network;
 
 
   struct _fw {
	u_int32_t	conn_id;		/* connection id */
	u_int32_t	v_conn_id;		/* virtual connection id */
	u_int32_t	direction;
	u_int32_t	duration;
	char_array	module_name[STRING32];
	char_array	src_zone[STRING32];
	char_array	dst_zone[STRING32];
	ipaddr_t       t_src_ip;
	u_int16_t       t_src_port;
	ipaddr_t       t_dst_ip;
	u_int16_t       t_dst_port;
	u_int32_t       flags;
	//Change for VPN Reports
	 u_int16_t	conn_event;
    } fw;
 
    struct _idp {
	u_int32_t       signature_rev;
	u_int32_t	signature_id;
	u_int32_t	classification_id;
	char_array      classification[STRING64];
	u_int8_t	rule_priority;
	char_array      signature_msg[STRING128];
	u_int32_t	reference_id;
	char_array      reference[STRING64];
    } idp;

    struct _virus {
	char_array	virusname[STRING32];
	char_array	virusinfo[STRING32];
    } virus;

    struct _spam {
	char_array	spam_action[STRING32];
	char_array	spam_reason[STRING64];
    } spam;
	
    struct _content_filter {
	char_array	category[STRING64];
	char_array	contenttype[STRING64];
	char_array	contentname[STRING64];
	int32_t		contentlength;
        char_array	category_type[STRING64];
	//Change for VPN Reports
	u_int32_t	categoryid;	
    } content_filter;

    struct _mail {
	char_array	sender[STRING64];
	char_array	rcpts[STRING1024];
	char_array	srcdom[STRING64];
	char_array	messageid[STRING64];
	char_array	subject[STRING64];
	char_array	dstdom[STRING64];
	char_array	ctrefid[STRING64];
	char_array	qname[STRING64];
	u_int32_t	mail_size;
    } mail;
 
    struct _http_ftp {
	char_array	url[STRING1024];
	char_array	domain[STRING512];
	direction_t	direction;
	char_array	req_command[STRING64];
	char_array	response[STRING64];
    } http_ftp;
 
	//Change for IM Reports
	struct _im {
	    u_int8_t proto;
	    u_int8_t action;
	    u_int8_t recflag;
	    char_array suspect [STRING64];
	    char_array non_suspect [STRING128];
	    char_array message[STRING1024];
	    char_array reqstatus[STRING32];
	} im;
		//Change for Authenticaltion Reports
	struct _auth {
	    char_array auth_client[STRING32];
	    char_array auth_mechanism[STRING16];
	    char_array reason[STRING128];
	    u_int32_t upload;
    	    u_int32_t download;
	    date_t    starttime;
	} auth;

	//Change for VPN Reports
	struct _vpn {
	    char_array conn_name[STRING32];
	    u_int8_t conn_type;
	    ipaddr_t ip_addr;
	    char_array local_LAN[STRING32];
	    char_array remote_LAN[STRING32];
	    char_array reason[STRING64];
	    char_array raw_data[1400];
	} vpn;

	//Change for SSL VPN Reports
	struct _sslvpn {
	    date_t starttime;
	    u_int8_t mode;
	    u_int8_t resource_type;
	    char_array sslvpn_sessionid[STRING64];
	    char_array sslvpn_url[STRING256];
	    char_array raw_data[STRING1024];
        } sslvpn;

	struct _link {
	    char_array ifname[STRING32];
	    u_int8_t index;
	    u_int8_t opr_status;
	    u_int8_t link_status;
	} link;

	struct _ddns {
	    ipaddr_t last_ip;
	    char_array host_name[STRING256];
	    char_array failure_reason[STRING128];
	    u_int8_t last_update_status;
	} ddns;
	
	char_array raw_data[1536];
	
};

struct _output_data {
    void (*freehandler)(void*);
    u_int32_t se_id;
    u_int32_t flag;
    void *data;
    struct _output_data *next;
};

#endif /* _CYBEROAM_STD_EVENT_ */
