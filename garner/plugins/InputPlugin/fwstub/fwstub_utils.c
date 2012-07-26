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
#include <stdio.h>

#include "config.h"

#include <EXTERN.h>
#include <perl.h>

int
fwstub_typecast_u_int32_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_u_int16_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_u_int8_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_int32_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_date_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_char_array(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}

int
fwstub_typecast_ipaddr_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}


int
fwstub_typecast_direction_t(struct _se_vars_fws *se_vars, struct _std_event *se, void *sv)
{
	printf("%s called\n", __FUNCTION__);
    return 0;
}


int
fwstub_typecast_str_u_int32_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
	u_int32_t *dst,x;
	char *end=NULL;
    dst =  (u_int32_t *) ((u_int8_t *)se + se_vars->offset);

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
fwstub_typecast_str_u_int16_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
	u_int16_t *dst,x;
    char *end=NULL;
    dst = (u_int16_t *) ((u_int8_t *)se + se_vars->offset);

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
fwstub_typecast_str_u_int8_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{

	u_int8_t *dst,x;
    char *end=NULL;
    dst = (u_int8_t *)se + se_vars->offset;

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
fwstub_typecast_str_int32_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
	int32_t *dst,x;
    char *end=NULL;
    dst = (int32_t *) ((u_int8_t *)se + se_vars->offset);

    x = strtol(string, &end, 0);
    memcpy(dst, &x, sizeof(int32_t) );
    if(end && *end != '\0') {
           return 1;
    } else {
           return 0;
    }

    return 0;
}

int
fwstub_typecast_str_date_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
#if 0
	struct tm date;
	u_int8_t *temp;
	time_t time;
	char temp_str[32];
	memset(&date, 0, sizeof(date));
	temp = ((u_int8_t *) se) + se_vars->offset;
	/*if(!strcasecmp("date", key)) {
		strptime(string, "%Y-%m-%d", &date);
		}
	else if(!strcasecmp("time", key)){
		localtime_r((time_t *)temp, &date);
		strptime(string, "%H:%M:%S", &date);
	}else{
		printf("Error key is different in date conversion \n");
	}*/	
	strptime(string, "%Y-%m-%d %H:%M:%S", &date);
	time = mktime(&date);
	sprintf(temp_str, "%d", (u_int32_t)time);
	return fwstub_typecast_str_u_int32_t(key,se_vars,se,temp_str);		
#endif
	return fwstub_typecast_str_u_int32_t(key,se_vars,se, string);
	

}

int
fwstub_typecast_str_char_array(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
	u_int8_t *tmp;
    tmp = (u_int8_t *)se + se_vars->offset;
    strcpy((char *)tmp,string);
    return 0;
}

int
fwstub_typecast_str_ipaddr_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
	struct sockaddr_in addr;
	u_int8_t *tmp;
	memset(&addr, 0, sizeof(addr));
	inet_aton(string, &addr.sin_addr);
	addr.sin_addr.s_addr = ntohl(addr.sin_addr.s_addr);

    tmp = (u_int8_t *)se + se_vars->offset;
	memcpy(tmp,&(addr.sin_addr.s_addr),sizeof(ipaddr_t));

    return 0;
}


int
fwstub_typecast_str_direction_t(char *key,struct _se_vars_fws *se_vars, struct _std_event *se, char *string)
{
    u_int8_t *tmp;

    tmp = (u_int8_t *)se + se_vars->offset;

    (*tmp) = (string[0] == '1') ? 1:0;

    return 0;
}

