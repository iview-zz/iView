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
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <dlfcn.h>

#include "../../../src/std_event.h"

#define	MAX_COUNT	100

int
init_se_smtp(struct _std_event *se)
{
		snprintf(se->device.device_id, sizeof(se->device.device_id), "%s", "Cyberoam");

		memset(se, 0, sizeof(struct _std_event));

		se->system.fwruleid = 123;
		se->system.applicationid = 555;
		snprintf(se->system.avaspolicy, sizeof(se->system.avaspolicy), "%s", "global policy");
//		snprintf(se->system.username, sizeof(se->system.username), "%s", "ankitpatel");
		snprintf(se->system.application, sizeof(se->system.application), "%s", "http");

		se->network.src_ip = 0xC0A8036F;
		se->network.dst_ip = 0xC0A80164;
		se->network.ip_protocol = 80;
		se->network.sentbytes = 12345;
		se->network.recvbytes = 54321;
		se->network.l4_dst = 8080;
		snprintf(se->network.protocol_group, sizeof(se->network.protocol_group), "%s", "web services");

        se->log.log_component = 66;  // LOGCOMP_SMTP ;  /* 11 */
        se->log.log_type = LOGTYPE_ANTIVIRUS;	/* 3 */
	    se->log.log_subtype = 77;  // LOGSTYPE_VIRUS; 	/* 6 */
    	se->log.severity = PRIORITY_CRITICAL;   /* 2 */
	    se->log.messageid = 10001;

        snprintf(se->virus.virusname, sizeof(se->virus.virusname),
                                        "%s", "test virus");

        snprintf(se->mail.sender, sizeof(se->mail.sender),
                    "%s", "ankit@elitecore.com");
        
        snprintf(se->mail.rcpts, sizeof(se->mail.rcpts),
                    "%s", "vishal@elitecore.com");

        snprintf(se->mail.srcdom, sizeof(se->mail.srcdom),
                    "%s", "elitecore.com");

        snprintf(se->mail.dstdom, sizeof(se->mail.dstdom),
                    "%s", "elitecore.com");

        snprintf(se->mail.subject, sizeof(se->mail.subject),
                    "%s", "sub: test message for wingarner");

        snprintf(se->mail.qname, sizeof(se->mail.qname),
                    "%s", "test.mail" );

        se->mail.mail_size = 1024 ;

        return 0;
}

int
main(int argc, char *argv[])
{
	
	void *handle1=NULL;
	void *libhandle1=NULL;
	void *libhandle2=NULL;
	
	void(*debug1)(void *) ;
	int (*init1)(const char *, u_int32_t, void **) ;
	int (*output1)(struct _std_event *, u_int32_t,
                          struct _output_data **, void *) ;
	void (*close1)(void *) ;

	struct _std_event se ;
	int count=1;

//	handle1 = dlopen("/usr/local/garner/garner/plugins/OutputPlugin/libpostgres/liboppostgres.so", RTLD_LAZY);
	handle1 = dlopen("/usr/local/garner/garner/plugins/OutputPlugin/libpostgres/liboppostgres.so", RTLD_LAZY);

	debug1=dlsym(handle1,"oppostgres_debug");
	init1=dlsym(handle1,"oppostgres_init");
	output1=dlsym(handle1,"oppostgres_output");
	close1=dlsym(handle1,"oppostgres_close");

	debug1(NULL);

	if(init1(argv[1], STD_EVENT_VERSION, &libhandle1) < 0) {
		printf("main: plugin initialization failed\n");
		return -1;
	}
/*
	if(init1(argv[2], STD_EVENT_VERSION, &libhandle2) < 0) {
		printf("archiever_init 2 fail\n");
		return -1;
	}
*/
	while(count <= MAX_COUNT) {
		printf("test: COUNT: %d\n", count);
		count++;
		
		init_se_smtp(&se);

		se.system.timestamp = time(NULL)-10 ;
        se.system.userid = count ;
		
		output1(&se, 1, NULL, libhandle1);
	//	output1(&se, 1, NULL, libhandle2);

		sleep(1);
	}

	close1(libhandle1);
	//close1(libhandle2);

	return 0;
}

