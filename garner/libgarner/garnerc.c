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
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/un.h>
#include <arpa/inet.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>
#include <fcntl.h>
#include <errno.h>

#ifdef GR_REENTRANT
#include <pthread.h>
#endif

#include "garnerc.h"


struct _gr {
    int fd;
    char *ident;
    char *server;
    u_int32_t flags;
    time_t lastconnecttime;
#ifdef GR_REENTRANT
    pthread_mutex_t lock;
#endif
};

#define MYNAME "garner"
#define log_printf printf

/*
 * Set the socket to non blocking
 */
static int
gr_socket_nonblocking(int sock)
{
    int flags;

    flags = fcntl(sock, F_GETFL, 0);
    return fcntl(sock, F_SETFL, flags | O_NONBLOCK);
}

/*
 * Set the socket to blocking - vinod
 */
static int
gr_socket_blocking(int sock)
{
    int flags;

    flags = fcntl(sock, F_GETFL, 0);
    return fcntl(sock, F_SETFL, flags & ~O_NONBLOCK);
}

static int
set_socket_rw_timeout(int fd, time_t tv_sec, suseconds_t tv_usec)
{
    struct timeval tv;
    tv.tv_sec = tv_sec;
    tv.tv_usec = tv_usec;
    if(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(struct timeval)) != 0) {
	log_printf("setsockopt(SO_RCVTIMEO): fd: %d, failed: %s\n",
					fd, strerror(errno));
	return -1;
    }
    if(setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(struct timeval)) != 0) {
	log_printf("setsockopt(SO_SNDTIMEO): fd: %d, failed: %s\n",
					fd, strerror(errno));
	return -1;
    }
    return 0;
}

/* on success, makes the sd blocking and returns sd.
 * on failure, it closes the fd, and returns -1.
 */
static int
check_nonblocking_connect(int sd)
{
    int res;
    struct timeval tv;
    fd_set myset;

    tv.tv_sec = 0; 
    tv.tv_usec = 10000; /* 10 milliseconds */

    FD_ZERO(&myset); 
    FD_SET(sd, &myset); 
 
    res = select(sd+1, NULL, &myset, NULL, &tv); 

    if(res < 0) {
	/* some error */
	log_printf("%s: select() failed: %s\n", MYNAME, strerror(errno));
    } else if(res > 0) {
	int valopt; 
	socklen_t lon = sizeof(int);

	// Socket selected for write 
	if (getsockopt(sd, SOL_SOCKET, SO_ERROR, (void*)(&valopt), &lon) == 0) { 
	    /* getsockopt success */
	    if (!valopt) {
		/* finally connected */
		gr_socket_blocking(sd);
		return sd;
	    }
	    log_printf("%s: Error in delayed connection(): %s\n", MYNAME, strerror(valopt));
	} else {
	    /* getsockopt failed */
	    log_printf("%s: getsockopt() failed: %s\n", MYNAME, strerror(errno));
	}
    } else {
	/* timeout */
	log_printf("%s: connect timedout\n", MYNAME);
    }

    /* something was wrong */
    close(sd);
    return -1;
}

static int
do_connect_unix(const char *server)
{
    int sd;
    struct sockaddr_un serveraddr;

    sd = socket(AF_UNIX, SOCK_STREAM, 0);
    if(sd < 0) {
	log_printf("%s: socket() failed: %s\n", MYNAME, strerror(errno));
	return -1;
    }

    /* fill the socket structure */
    memset(&serveraddr, 0, sizeof(struct sockaddr_un));
    serveraddr.sun_family        = AF_UNIX;
    strcpy((char*)&serveraddr.sun_path, server);

    gr_socket_nonblocking(sd);

    if(connect(sd, (struct sockaddr *)&serveraddr, 
		(strlen(serveraddr.sun_path) + 2)) == 0) {

	/* connect successful */
	gr_socket_blocking(sd);
	return sd;
    }

    /* some error occured in connect */
    if(errno == EINPROGRESS) {
	return check_nonblocking_connect(sd);
    } 

    log_printf("%s: connect(%s) failed: %s\n", MYNAME, server, strerror(errno));
    close(sd);
    return -1;
}

static int
do_connect_inet(const char *server)
{
    int port;
    int sd;
    char *pstr;
    struct sockaddr_in serveraddr;

    sd = socket(AF_INET, SOCK_STREAM, 0);
    if(sd < 0) {
	log_printf("%s: socket() failed: %s\n", MYNAME, strerror(errno));
	return -1;
    }

    pstr = strchr(server, ':');
    if(!pstr) {
	/* port not given */
	return -1;
    }

    port = strtol(pstr+1, NULL, 10);

    /* fill the socket structure */
    memset(&serveraddr, 0, sizeof(struct sockaddr_in));
    serveraddr.sin_family        = AF_INET;
    
    serveraddr.sin_port = htons(port);
    *pstr = '\0';
    serveraddr.sin_addr.s_addr = inet_addr(server);
    *pstr = ':';

    gr_socket_nonblocking(sd);

    /* connect to server */
    if(connect(sd, (struct sockaddr *) &serveraddr, sizeof(serveraddr)) == 0) {
	/* connect successful */
	gr_socket_blocking(sd);
	return sd;
    }

    /* some error occured in connect */
    if(errno == EINPROGRESS) {
	return check_nonblocking_connect(sd);
    } 

    log_printf("%s: connect(%s) failed: %s\n", MYNAME, server, strerror(errno));
    close(sd);
    return -1;
}

static int
gr_connect(struct _gr *gr)
{
    if(!gr || !gr->server) {
	return -1;
    }
    gr->lastconnecttime = time(NULL);
    if(*(gr->server) == '/') {
	gr->fd = do_connect_unix(gr->server);
    } else {
	gr->fd = do_connect_inet(gr->server);
    }
    
    if(gr->fd >= 0) {
	int n;
	char buffer[128];

	set_socket_rw_timeout(gr->fd, 0, 50000);

	/* do blocking handshake */
	n = read(gr->fd, buffer, sizeof(buffer));
	if(n <= 0) {
	    log_printf("%s: failed to read greetings from garner: %s\n", MYNAME, strerror(errno));
	    close(gr->fd);
	    gr->fd = -1;
	    return -1;
	}
	/* got the greeting from garner */
	n = sprintf(buffer, "%s\r\n", gr->ident);

	if(write(gr->fd, buffer, n) != n) {
	    log_printf("%s: failed to write ident to garner\n", MYNAME);
	    close(gr->fd);
	    gr->fd = -1;
	    return -1;
	}

	if((gr->flags & GR_FLAGS_NONBLOCK)) {
	    gr_socket_nonblocking(gr->fd);
	}
    }
    return gr->fd;
}

void *
gr_init(const char *ident, const char *server, u_int32_t flags)
{
    struct _gr *gr;

    if(!ident || !server) {
	errno = EINVAL;
	return NULL;
    }
    gr = calloc(1, sizeof(struct _gr));
    gr->ident = strdup(ident);
    gr->server = strdup(server);
    gr->flags = flags;
    gr->fd = -1;

#ifdef GR_REENTRANT
    pthread_mutex_init(&gr->lock, NULL);
#endif

    /* need not check fd validity at present */
    return gr;
}

void
gr_close(void *__gr)
{
    struct _gr *gr = __gr;
    if(!gr) {
	return;
    }
    free(gr->ident);
    free(gr->server);
    if(gr->fd >= 0) {
	close(gr->fd);
    }
#ifdef GR_REENTRANT
    pthread_mutex_destroy(&gr->lock);
#endif
    free(gr);
}

void
gr_io(void *__gr, u_int8_t *buffer, ssize_t buflen)
{
    struct _gr *gr = __gr;
    u_int32_t offset=0;
    int rc;

    if(buflen == 0) {
	/* nothing to write */
	return;
    }

#ifdef GR_REENTRANT
    pthread_mutex_lock(&gr->lock);
#endif
    if(gr->fd < 0) {
	time_t now = time(NULL);

	if(difftime(now, gr->lastconnecttime) < 30) {
	    /* this is to avoid connect flood */
	    goto cleanup;;
	}
	if(gr_connect(gr) < 0) {
	    goto cleanup;;
	}
    }

    /* i am avoiding select, and write is non-blocking */
    for(;;) {
	rc = write(gr->fd, buffer+offset, buflen);
	if(rc == buflen) {
	    goto cleanup;
	} else if(rc <= 0) {
	    /* 0 is not an error, but it makes us loop infinitely.
	     * Error may be EAGAIN which means the system is overloaded and
	     * therefore this connection is blocked.
	     * We are closing the connection as of now.
	     */
	    close(gr->fd);
	    gr->fd = -1;
	    goto cleanup;
	}
	offset += rc;
	buflen -= rc;
    }

cleanup:
    
#ifdef GR_REENTRANT
    pthread_mutex_unlock(&gr->lock);
#else
    /* to prevent gcc from complaining */
    (void)0;
#endif
}

void
gr_log(void *gr, const char *fmt, ...)
{
    int n;
    u_int8_t str[16384];
    va_list args;

    va_start(args, fmt);
    n = vsnprintf((char*)str, sizeof(str), fmt, args);
    if(n > 0 && n < sizeof(str)) {
	/* there was no overflow */
	gr_io(gr, str, n);
    }
    va_end(args);
}
