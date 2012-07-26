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
#include <unistd.h>

#include "../../../src/std_event.h"
#include "devdiscovery.h"

int
main(int argc, char *argv[])
{
	int i;
    void *handle;
    struct _std_event se;

	if(argc < 2) {
		printf("usage: %s <base dir path> [<device-id>,...]\n",argv[0]);
		return 0;
	}

    memset(&se, 0, sizeof(se));

    devdiscovery_init(argv[1], STD_EVENT_VERSION, &handle);

	for(i=2; i<argc; i++) {
	    strcpy(se.device.device_id, argv[i]);
    	printf("checking device_id: %s .....\n", se.device.device_id);
    	
		devdiscovery_output(&se, 1, NULL, handle);
	}

    devdiscovery_close(handle);

    return 0;
}
