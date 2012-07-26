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
#include <stdlib.h>
#include <stdarg.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <time.h>
#include <errno.h>
#include <wait.h>

#include "utils.h"
#include "format.h"
#include "../../../src/std_event.h"

#define MAX_LEN 2048

extern enum log_level_t log_level ;

void
arch_log_msg(int level, char *fmt, ...)
{
    va_list args;

    if(level > log_level) {
	return;
    }

    va_start(args, fmt);

    vprintf(fmt, args);

    va_end(args);
}

#define MD5SUM_CMD "md5sum %s"

int
make_archievefile_md5sum(const char *filepath)
{
    FILE *fp = NULL;
    int cmdlen;
    char cmd[(cmdlen=(filepath?strlen(filepath):0) +strlen(MD5SUM_CMD)+1)];
    char line[256];
    int ret, stat = 0;

    if (!filepath) {
	arch_log_msg(ARCH_LG_ERR, "%s: file path is not given\n", __FUNCTION__);
	return -1;
    }

    ret = sprintf(cmd, MD5SUM_CMD, filepath);

    if ((fp = popen(cmd, "r")) == NULL) {
	arch_log_msg(ARCH_LG_ERR, "%s: command '%s' failed '%s'\n", __FUNCTION__, cmd, strerror(errno));
	return -1;
    }

    if (!fgets(line, 255, fp)) {
	arch_log_msg(ARCH_LG_ERR, "%s: geting output failed '%s'\n", __FUNCTION__, strerror(errno));
    }

    ret = pclose(fp);

    if (WIFEXITED(ret)) {
	stat = WEXITSTATUS(ret);
    } else if (WIFSIGNALED(ret)) {
	stat = WTERMSIG(ret);
    }

    if (!stat) {
	char fname[(cmdlen+5)];
	char *ptr = NULL;

	ptr = strrchr(filepath, '.'); 

	if (ptr) {
	    *ptr = '\0';
	} 

	sprintf(fname, "%s.md5", filepath);

	ptr = strchr(line, ' ');
	if (ptr) {
	    *ptr = '\0';
	} else {
	    line[33] = '\0';
	}

	if (!(fp = fopen(fname, "w"))) {
	    arch_log_msg(ARCH_LG_ERR, "%s: fopen failed '%s'\n", __FUNCTION__, strerror(errno));
	    return -1;
	}
	fputs(line, fp);
	fclose(fp);
    }

    return stat;
}

int
rotate_unrotated_archievefiles(struct _logger *logger)
{
    int ret;
    DIR *dir;
    char oldfile[MAX_LEN], newfile[MAX_LEN] ;
/*
 * here we assumed that min. storage capacity requirement for d_name element of
 * dirent structure while using "readdir_r" is fulfilled by glibc itself.
 * d_name is usually defined as a char array of 255 elements. Its enough for us.
 * We can use "NAME_MAX" to overcome this restriction but in some cases value of
 * "NAME_MAX" is even set below 255 and we are not allocating dirent structure
 * dynamically here to use "NAME_MAX" more smartely.
 */
    struct dirent *dir_entry_ptr ;
    struct dirent dir_entry ;

    /* opening directory stream */
    if((dir = opendir(logger->base_dir)) == NULL) {
	arch_log_msg(ARCH_LG_ERR,"rotate_unrotated_archievefiles: directory stream for %s \
    	        			     	couldnt open\n", logger->base_dir);
        return -1;
      }

    /* get each file one by one from directory and deletes it */
    while((ret=readdir_r(dir, &dir_entry, &dir_entry_ptr)) == 0) {
    	if(dir_entry_ptr == NULL) {
	    /* end-of-file reached on directory stream */
            break;
    	}

	/* skip 'rotated', '.' and '..' directorys */
    	if((!strcmp(dir_entry.d_name,"rotated")) ||
        	    	(!strcmp(dir_entry.d_name,"."))	||
            		(!strcmp(dir_entry.d_name,"..")) ) {
            continue ;
    	}
    	/* prepare absolute path name for selected file */
        ret = snprintf(oldfile, sizeof(oldfile), "%s/%s", logger->base_dir, dir_entry.d_name);
	    if(ret >= sizeof(oldfile)) {
		/* this may only happens if MAX_LEN is reduced in between */
		arch_log_msg(ARCH_LG_ERR, "rotate_unrotated_archievefiles: old filename '%s' truncated\n", oldfile);
		/* continue as move will definitely be fail otherwise */
		continue ;
	    }

    	/* prepare new absolute path name for selected file */
        ret = snprintf(newfile, sizeof(newfile), "%s/rotated/%s", logger->base_dir, dir_entry.d_name);
	if(ret >= sizeof(newfile)) {
	    arch_log_msg(ARCH_LG_ERR, "rotate_unrotated_archievefiles: new filename '%s' truncated\n", newfile);
	}

	/* rotating file to rotated directory */
    	ret = rename(oldfile, newfile) ;
    	if(ret < 0 ){
            arch_log_msg(ARCH_LG_ERR,"rotate_unrotated_archievefiles: rotation fail from file '%s' to file '%s': %s\n",
                                                             oldfile, newfile, strerror(errno)) ;
	    continue ;
    	} else {
            arch_log_msg(ARCH_LG_DEBUG,"rotate_unrotated_archievefiles: file rotated to '%s'\n", newfile) ;
	    if (logger->md5sum) {
		make_archievefile_md5sum(newfile);
	    }
    	}
    }

    /* close directory stream  */
    closedir(dir);
    return 0 ;
}

static int
create_archievefile(struct _logger *logger, u_int32_t timestamp)
{
    int ret;
    char filename[MAX_LEN];

    ret = snprintf(filename, sizeof(filename), "%s_%lu_%d.log", logger->name, time(NULL), timestamp);
    if(logger->logfile) {
        free(logger->logfile) ;
    }
    logger->logfile = strdup(filename);
    if(!logger->logfile) {
	arch_log_msg(ARCH_LG_ERR, "create_archievefile: logfile name '%s' couldnt allocated\n",filename);
	return -1;
    }

    ret = snprintf(filename, sizeof(filename), "%s/%s", logger->base_dir, logger->logfile);
    if(ret >= sizeof(filename)) {
	arch_log_msg(ARCH_LG_DEBUG, "create_archievefile: log filename '%s' truncated\n",filename);
    }

    logger->fd = open(filename, O_RDWR | O_CREAT | O_APPEND, 0666);
    if(logger->fd < 0) {
	arch_log_msg(ARCH_LG_ERR, "create_archievefile: archieve file '%s' couldnt created: %s\n",
								filename,strerror(errno));
	free(logger->logfile);
	logger->logfile = NULL;
	logger->fd = -1;
	return -1;
    } else {
	logger->file_size = 0;
	arch_log_msg(ARCH_LG_DEBUG,"create_archievefile: initial file size : '%d' bytes\n", logger->file_size);
	logger->fp_offset = 0;
	arch_log_msg(ARCH_LG_DEBUG, "create_archievefile: file_offset: '%d'\n", logger->fp_offset);
    }

    return 0;
}

void
rotate_archievefile(void *arg)
{

    int ret ;
    char newfile[MAX_LEN];
    char oldfile[MAX_LEN];
    struct _archiever *arc;
    struct _logger *logger;
	
    if(!arg) {
	arch_log_msg(ARCH_LG_ERR,"rotate_archievefile: input argument NULL\n");
	return ;
    }
    arc = (struct _archiever *) arg;
    logger = arc->logger;

    if(logger->fd < 0) {
	arch_log_msg(ARCH_LG_DEBUG, "rotate_archievefile: files is not opened, not rotating file\n");
        return ;
    }

    ret = snprintf(oldfile, sizeof(oldfile), "%s/%s", logger->base_dir, logger->logfile) ;
    if(ret >= sizeof(oldfile)) {
	/* should not be reached, as this file is created with same filename length constraint */
	arch_log_msg(ARCH_LG_ERR,"rotate_archievefile: rotated file name '%s' truncated\n", oldfile);
	return ;
    }

    ret = snprintf(newfile, sizeof(newfile), "%s/rotated/%s", logger->base_dir, logger->logfile) ;
    if(ret >= sizeof(newfile)) {
	arch_log_msg(ARCH_LG_ERR,"rotate_archievefile: rotated file name '%s' truncated\n", newfile);
    }
	
    /* close the file */
    close(logger->fd) ;
    logger->fd = -1 ;

    /* move the file */
    ret = rename(oldfile, newfile) ;
    if(ret < 0 ){
	arch_log_msg(ARCH_LG_ERR,"rotate_archievefile: rotation fail from file '%s' to file '%s': %s\n",
							oldfile, newfile, strerror(errno)) ;
    } else {
	arch_log_msg(ARCH_LG_INFO,"rotate_archievefile: file rotated to '%s'\n", newfile) ;
	if (logger->md5sum) {
	    make_archievefile_md5sum(newfile);
	}
    }
    return ;
}

static int
write_to_file(struct _logger *logger, char *buf, unsigned int copylen)
{
    int ret, wlen, wtry;

    if(!logger) {
	arch_log_msg(ARCH_LG_ERR, "write_to_file: invalid input parameter\n");
	return -1;
    }
    if(logger->fd < 0) {
	arch_log_msg(ARCH_LG_ERR, "write_to_file: file is not opened\n");
	return -1;
    }
	
    wtry = 3;
    wlen = copylen;
    while(wlen && wtry--) {
        ret = write(logger->fd, buf, wlen);
        if(ret == wlen) {
            /* everything written to file */
            wlen = 0 ;
            break ;
        } else if(ret < 0) {
            arch_log_msg(ARCH_LG_ERR, "write_to_file: write() error on file '%s': %s\n",
                                        		logger->logfile, strerror(errno));
            break ; /* current entry couldnt be written */
        } else {
            /* part of data written - try again */
            wlen -= ret ;
        }
    }
    arch_log_msg(ARCH_LG_DEBUG, "write_to_file: '%d' bytes out of '%d' bytes written\n", 
							(copylen-wlen), copylen);
    return (copylen-wlen);
}


int
do_archieve(struct _archiever *arc, struct _std_event *se)
{
    char buf[2048] ;
    unsigned int size = sizeof(buf);
    int ret, copylen;

    struct _logger *logger;
    logger = arc->logger;

    arch_log_msg(ARCH_LG_DEBUG, "do_archieve: ARCHIEVER: '%s'\n",arc->name);

    if(logger->fd < 0) {
	ret = create_archievefile(logger, se->system.timestamp);
	if(ret < 0) {
	    return -1;
	}
    }	
    copylen = archiever_prepare_logmsg(buf, size, arc->logformatter->logformat, (void *)se);

    ret = write_to_file(logger, buf, copylen) ;
    if(ret <= 0) {
	arch_log_msg(ARCH_LG_ERR, "do_archieve: Zero bytes writen in file '%s'\n",logger->logfile);
	return -1;
    }
 
    logger->file_size += ret ;
    arch_log_msg(ARCH_LG_DEBUG, "do_archieve: updated file size: '%d'\n", logger->file_size);

    if(logger->index_flag) {
	/* Indexing information is expected from this archiever */
	
	/* store filename of logger to se */
	copylen = strlen(logger->logfile);
	size = sizeof(se->gr_data.filename);
	if(copylen > size-1) {
	    copylen = size-1;
	}
	memcpy(se->gr_data.filename, logger->logfile, copylen);
	se->gr_data.filename[copylen]='\0';
	arch_log_msg(ARCH_LG_DEBUG, "do_archieve: set logfile name into se: '%s'\n",
							se->gr_data.filename);
		
	/* store file offset for last event log */
	se->gr_data.file_offset = logger->fp_offset ;
	arch_log_msg(ARCH_LG_DEBUG, "do_archieve: set file_offset into se: '%d'\n",
						se->gr_data.file_offset);
    }

    /* update file offset */
    logger->fp_offset = logger->file_size;
    arch_log_msg(ARCH_LG_DEBUG, "do_archieve: updated file_offset: '%d'\n", logger->fp_offset);

    if(logger->file_size >= logger->max_filesize) {
	arch_log_msg(ARCH_LG_DEBUG, "do_archieve: file size > max size\n");
	rotate_archievefile(arc);
    }

    return 0;
}

void
archiever_assert(const char *msg, const char *file, int line)
{
    arch_log_msg(ARCH_LG_ERR, "file: %s:%d, Assertion '%s' failed\n", file, line, msg);
    fprintf(stderr, "%s:%d, Assertion '%s' failed\n", file, line, msg);
    abort();
}

