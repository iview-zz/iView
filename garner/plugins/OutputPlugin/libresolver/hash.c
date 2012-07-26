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
#include <stdlib.h>

#include "hash_private.h"
#include "hash.h"

#undef uthash_fatal
#undef uthash_bkt_malloc
#undef uthash_bkt_free
#undef uthash_tbl_malloc
#undef uthash_tbl_free
#undef uthash_noexpand_fyi 
#undef uthash_expand_fyi

#define uthash_fatal(msg)        hash_fatal(msg)   
#define uthash_bkt_malloc(sz)    new_block("bucket", sz)
#define uthash_bkt_free(ptr)     free_block("bucket", ptr)
#define uthash_tbl_malloc(sz)    new_block("hash_table", sz)
#define uthash_tbl_free(ptr)     free_block("hash_table", ptr)

#define uthash_noexpand_fyi(tbl) table_expand(0, tbl)
#define uthash_expand_fyi(tbl)   table_expand(1, tbl)

void
hash_fatal(const char *msg)
{
    resolver_log_message(RLG_CRIT, "hash_fatal : %s\n", msg);
    exit(-1);
}

void*
new_block(const char *msg, u_int32_t size)
{
    resolver_log_message(RLG_INFO, "new_%s: Created of size :- %d\n", msg, size);
    return calloc(1, size);
}

void
free_block(const char *msg, void *ptr)
{
    resolver_log_message(RLG_INFO, "free_%s: calld\n", msg);
    free(ptr);
}

void
table_expand(u_int8_t flag, void *ptr)
{
    UT_hash_table *tlb = ptr;

    if (!ptr) return;

    if (flag) {
	resolver_log_message(RLG_INFO, "Hash table: Expanding to %d Buckets\n", tlb->num_buckets);
    } else {
	resolver_log_message(RLG_ERR, 
		"Hash table: Not Expanding the size of Bucket from %d\n", tlb->num_buckets);
    }
}


int
hash_add(struct _hash_table **Table, struct _hash_table *element, u_int32_t keylen)
{
    if (!element) return 1;

    HASH_ADD(hh, (*Table), key[0], keylen, element);

    return 0;
}

int
hash_delete(struct _hash_table **Table, struct _hash_table *element)
{
    if (!element) return 1;

    HASH_DEL((*Table), element);
    free(element);

    return 0;
}

void
hash_delete_all(struct _hash_table **Table)
{
    struct _hash_table *table = (*Table);
    struct _hash_table *eleptr;

    while (table) {
	eleptr = table;
        HASH_DEL(table, eleptr);
	free(eleptr);
    }
}

int
hash_search(struct _hash_table *Table, u_int8_t *key, u_int32_t keylen, struct _hash_table **element)
{
    struct _hash_table *table  = Table;
    struct _hash_table *eleptr = NULL;

    HASH_FIND(hh, table, key, keylen, eleptr);

    if (eleptr) {
	(*element) = eleptr;
	return 0;
    }
    return 1;
}

void
print_hash_table(struct _hash_table *Table, u_int32_t keylen, u_int32_t vallen)
{
    struct _hash_table *table;
    char *str;
    int i;

    for (table = Table; table != NULL; table = table->hh.next) {
	str = calloc(1, keylen);
	for (i = 0; i < keylen - 1; i++) {
	    if (table->key[i] == 0) {
		str[i] = ' ';
		continue;
	    }
	    str[i] = (char) table->key[i];
	}

	printf("\nKey: %s\nvalues :", str);
	free(str);

	str = calloc(1, vallen);
	for (i = 0; i < vallen - 1; i++) {
	    if (table->value[i] == 0) {
		str[i] = ' ';
		continue;
	    }
	    str[i] = (char) table->value[i];
	}
	printf("%s\n", str);
	free(str);
    }
}
