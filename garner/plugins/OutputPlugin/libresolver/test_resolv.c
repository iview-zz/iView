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
#include "resolver.h"

int
main()
{
    void *handle;
    void *handle1;
    struct _std_event se[2];


    memset(se, 0, sizeof(se));

    resolver_init("./test_resolv.conf, proto_resolv", 0, &handle);
    resolver_init("./test_resolv.conf, user_resolv", 0, &handle1);

    se[0].network.ip_protocol = 3;
    strcpy(se[0].network.src_port_name, "25");

    se[1].system.userid = 3;
    se[1].system.usergpid = 2;

    resolver_output(se, 2, NULL, handle1);
    printf("\n\n");
    resolver_output(se, 2, NULL, handle);

    printf("network.protocol_group: %s\nsystem.application: %s", se[0].network.protocol_group, se[0].system.application);

    printf("\n\nsystem.username: %s\nsystem.usergpname: %s\n", se[1].system.username, se[1].system.usergpname);

    resolver_close(handle1);
    resolver_close(handle);

    return 0;
}
