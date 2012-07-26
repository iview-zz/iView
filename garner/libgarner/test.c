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
#include <sys/types.h>
#include <string.h>
#include <errno.h>
#include "garnerc.h"

int main()
{
    void *gr;
    //gr = gr_init("test", "127.0.0.1:6785", 0);
    //gr = gr_init("test", "192.168.13.101:9001", 0);
    printf("init\n");
    gr = gr_init("test", "/var/run/garner.sock", 0);
    printf("gr_log1\n");
    gr_log(gr, "test\n");
    sleep(5);
    gr_log(gr, "test\n");
    printf("gr_log2\n");
    gr_close(gr);

#if 0
    u_int8_t buffer[1024];
    int len;
    memset(buffer, 0, sizeof(buffer));
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_log(gr, "MAIL FROM: <vinod@rhel5>\r\n");
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_log(gr, "RCPT To: <vinod@rhel5>\r\n");
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_log(gr, "DATA\r\n");
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_log(gr, "Subject: test mail from gr\r\n\r\nThis is test.\r\n.\r\n");
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_log(gr, "QUIT\r\n");
    len = gr_read(gr, buffer, sizeof(buffer));
    printf("got %d errno=%s: %s\n", len, strerror(errno), buffer);
    buffer[0] = '\0';
    gr_close(gr);
#endif

    return 0;
}
