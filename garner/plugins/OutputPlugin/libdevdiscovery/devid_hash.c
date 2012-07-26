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

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#include "uthash.h"
#include "devid_hash.h"

struct _hash_table {
    char devid[64];
    u_int8_t status;
    UT_hash_handle hh;
};

int
devid_hash_add(void **handle, char *devid, u_int8_t status)
{
    struct _hash_table **head = NULL;
    struct _hash_table *entry = NULL;
	
    if(handle==NULL) {
	fprintf(stderr, "devid_hash_add: invalid handle\n");
	return -1; 
    }
    head = (struct _hash_table **) handle;
	
    //fprintf(stdout, "devid_hash_add: HASH HANDLE: %p\n", *head);
	
    if(!devid) {
	fprintf(stderr, "devid_hash_add: invalid device-id\n");
	return -1; 
    }

    /* allocate memory for devid entry */
    entry = (struct _hash_table *) calloc(1, sizeof(struct _hash_table));
    if(!entry) {
	fprintf(stderr, "devid_hash_add: memory allocation failed\n");
	return -1;
    }

    /* initialize devid entry */
    strcpy(entry->devid, devid);
    entry->status	=	status;
		
    /* add devid entry into hash table */
    HASH_ADD_STR(*head, devid, entry);

    //fprintf(stdout, "devid_hash_add: HASH ENTRY HANDLE: %p\n", entry);
    //fprintf(stdout, "devid_hash_add: device id '%s' added with status '%d'\n", devid, status);

    return 0;
}

u_int8_t
devid_hash_get_status(void **handle, char *devid)
{
    struct _hash_table **head = NULL;
    struct _hash_table *entry = NULL;
	
    if(!handle) {
	fprintf(stderr, "devid_hash_get_status: invalid handle\n");
	return -1; 
    }
    head = (struct _hash_table **) handle;

    //fprintf(stdout, "devid_hash_get_status: HASH HANDLE: %p\n", *head);

    /* find devid entry in hash table */
    HASH_FIND_STR(*head, devid, entry);

    if(entry) {
	/* return status of devid */
	//fprintf(stdout, "devid_hash_get_status: HASH ENTRY HANDLE: %p\n", entry);
	//fprintf(stdout, "devid_hash_get_status: device id '%s' found with status '%d'\n", 
	//							entry->devid, entry->status);
	return (entry->status);
    }

    /* devid not found */
    return DEVICEID_STATUS_NOT_FOUND ;
}

int
devid_hash_delete(void **handle, char *devid)
{
    struct _hash_table **head = NULL;
    struct _hash_table *entry = NULL;
	
    if(!handle) {
	fprintf(stderr, "devid_hash_delete: invalid handle\n");
	return -1; 
    }
    head = (struct _hash_table **) handle;
	
    //fprintf(stdout, "devid_hash_delete: HASH HANDLE: %p\n", *head);

    if(!devid) {
	fprintf(stderr, "devid_hash_delete: invalid device-id\n");
	return -1;
    }
    
    /* find entry in hash table */
    HASH_FIND_STR(*head, devid, entry);

    if(entry) {
	/* delete the entry from hash table */
	//fprintf(stdout, "devid_hash_delete: HASH ENTRY HANDLE: %p\n", entry);
	//fprintf(stdout, "devid_hash_delete: deleting device-id '%s' with status '%d'\n", entry->devid, entry->status);

    	HASH_DEL(*head, entry);
    	free(entry);
    }

    return 0;
}


void
devid_hash_delete_all(void **handle)
{
    struct _hash_table **head = NULL;
    struct _hash_table *entry = NULL;
	
    if(!handle) {
	fprintf(stderr, "devid_hash_delete_all: invalid handle\n");
	return ; 
    }
    head = (struct _hash_table **) handle;

    //fprintf(stdout, "devid_hash_delete_all: HASH HANDLE: %p\n", *head);

    while(*head) {
	entry = *head;
	//fprintf(stdout, "devid_hash_delete_all: HASH ENTRY HANDLE: %p\n", entry);
	//fprintf(stdout, "devid_hash_delete_all: deleting device-id '%s' with status '%d'\n", 
	//							entry->devid, entry->status);

        HASH_DEL(*head, entry);
	free(entry);
    }
	
    return;
}

