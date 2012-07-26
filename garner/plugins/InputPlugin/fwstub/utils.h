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

#ifndef _CYBEROAM_FWSTUB_UTILS_H_
#define _CYBEROAM_FWSTUB_UTILS_H_
#include "../../../src/std_event.h"
/* compare returns 0 if condition is true
 *                 non-zero if condition is false
 * compare should be called with std_event and corresponding argument
 */


/* Define boolean values */
#ifndef FALSE
#define FALSE 0
#define TRUE (!FALSE)
#endif

#define xassert(EX)  ((EX)?((void)0):fwstub_assert(#EX, __FILE__, __LINE__))

extern int fwstub_parse_conffile(const char *conf_file);

void fwstub_assert(const char *msg, const char *file, int line);


int get_other_mid(struct _std_event *se,char *value);

int get_forti_mid(struct _std_event *se,char *value);

int get_sonic_mid(struct _std_event *se,char *value);

int get_sev( struct _std_event *se,char *value);

int get_date(struct _std_event *se,char *value);
int get_time(struct _std_event *se,char *value);

int sonic_get_ip(struct _std_event *se,char *value);

int sonic_get_port(struct _std_event *se,char *value);

int sonic_get_zone(struct _std_event *se,char *value);

int sonic_get_proto(struct _std_event *se,char *value);

int proto_normalize( struct _std_event *,char *value);

int ignore_con( struct _std_event *,char *value);

int  r_log_component( struct _std_event *,char *value);

int  r_log_subtype( struct _std_event *,char *value);

int r_priority( struct _std_event *,char *value);

int  r_fw_dir( struct _std_event *,char *value);

int r_ftp_dir( struct _std_event *,char *value);

int r_log_type( struct _std_event *,char *value);

int get_domain( struct _std_event *,char *value);

int r_sslvpn_resource_type( struct _std_event *,char *value);
int r_sslvpn_mode( struct _std_event *,char *value);
int r_im_action( struct _std_event *,char *value);
int r_im_protocol( struct _std_event *,char *value);
int r_im_receiver( struct _std_event *,char *value);
int r_status( struct _std_event *,char *value);
int r_messageid(struct _std_event *se, char *value);

#endif
