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

#ifndef _CYBEROAM_OP_ARCHIEVER_FORMAT_H_
#define _CYBEROAM_OP_ARCHIEVER_FORMAT_H_

#include <sys/types.h>

#define PLUGIN_NAME    "ARCHIEVER"
#define __FO(type, field) ((u_int32_t)&(((type *)0)->field))
#define __ROUTINES(TYPE) append_##TYPE 

struct _std_event_vars_arch {
    int (*appendlog) (char *, int, void *); 
    char *type;
    char *variable;
    int offset;
};

/*
struct _sev_data {
    const struct _std_event_vars_arch *sev;
    void *data;
};
*/

struct _logger {
    char *name;
    char *logfile;
    char *base_dir;
    int fd;
    u_int32_t file_size;
    u_int32_t max_filesize;
    u_int32_t fp_offset ;
    u_int8_t index_flag ;
    u_int8_t md5sum ;
    struct _logger *next;
};

struct _log_format {
    const void *data;	//pointer to string or struct _std_evnet_vars
    int datalen;    	//non-zero if string, will also serve as Type
    struct _log_format *next;
};

struct _logformatter {
    char *name;
    struct _log_format *logformat;
    struct _logformatter *next;
};

struct _archiever {
    char *name;
    u_int32_t rotation_period;
    struct _logger *logger;
    struct _logformatter *logformatter;	
    struct _archiever *next;
};

extern struct _logger *logger_list;
extern struct _logformatter *logformatter_list;
extern struct _archiever *archiever_list;

/* prototype */
const struct _std_event_vars_arch *get_var_by_name_arch(const char *name);

int compare_std_event_var(void *se, void *arg, char op);

struct _logger *new_logger();
struct _logger *get_logger_by_name(char *name);
void insert_logger_in_list(struct _logger *logger);
void reset_logger(struct _logger *logger);
void free_logger_list();

struct _logformatter *new_logformatter();
struct _logformatter *get_logformatter_by_name(char *name);
void insert_logformatter_in_list(struct _logformatter *logformatter);
void free_logformatter_list();

struct _archiever *new_archiever();
struct _archiever *get_archiever_by_name(char *name);
void insert_archiever_in_list(struct _archiever *archiever);
void free_archiever_list();

struct _log_format *prepare_log_format(char *string);
void free_log_format(struct _log_format *log_format);

void do_rotate_unrotated_archievefiles(void) ;
int archiever_prepare_logmsg(char *buffer, size_t size, const struct _log_format *log_format,
				                                                      void *se);

#endif	/* _ARCHIEVER_FORMAT_H_ */
