#include "libname.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct libname {
    u_int8_t libname;
};

/*
 * Used to store partial record.
 */
struct libname *libname_record = NULL;

/*
 * In case record received in multiple chunks, libname_record_len will
 * indicate (struct libname) filled len.
 */
u_int32_t libname_record_len = 0;

void *buffptr = NULL;

#define LIBNAME_RECORD_SIZE (sizeof(struct libname))

/*
 * Arguments:
 *	argstring - Arguments passed along with the ident line in input block.
 *	version - version of garner.
 * Return Value:
 *	Returns 0 on success, -1 on failure.
 *	Can directly write the errors on standard out and error.
 *        They will be reflected to log file. Also errno can be used.
 * Description:
 *	This routine would be called once by garner during initialization.
 *	Version mismatch can be check during init itself.
 */
int
libname_init(const char *argstring, u_int32_t version)
{
    assert(libname_record == NULL);

    if (STD_EVENT_VERSION != version) {
        printf("libname_init: STD_EVENT_VERSION mismamtch\n");
        return -1;
    }

    libname_record = calloc(1, LIBNAME_RECORD_SIZE);
    return 0;
}


/*
 * Frees the internal data-structures of the library.
 */
void
libname_close()
{
    assert(libname_record != NULL);
    free(libname_record);
    libname_record = NULL;
    buffptr = NULL;
    libname_record_len = 0;
    return;
}

/*
 * Arguments:
 *	buffer - record buffer
 *	buflen - record buffer length
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 * Return Value:
 *	On success, it returns the number of records filled in searray,
 *	which may be zero if partial record is received.
 *	On failure, returns -1 in case of internal error.
 *	returns -2 in case it wants garner to increase the size of searray.
 *	In this case, garner would realloc searray with a new size and call this routine again.
 * Description:
 *	Record parser routine.
 */
int
libname_input(const u_int8_t *buffer, u_int32_t buflen,
		struct _std_event *searray, u_int32_t nse)
{
    u_int8_t *cptr = (u_int8_t *)buffer;
    u_int32_t rlen = buflen;
    u_int16_t parse_rec = 0;
    struct libname *record_ptr = NULL;
    struct _std_event *ev_ptr = &searray[parse_rec];

    if (nse < (rlen/(LIBNAME_RECORD_SIZE))) {
	/* 
	 * Don't have enough space to accomodate all records in searray.
	 * Tell garner to give more space to searray. 
	 */
	return -2;
    }

    while (rlen) {
        if (libname_record_len) {
            /*
             * We have received partial record in previous conversation,
             * continue filling remaining portion.
             */
            assert(buffptr != NULL);

            if (rlen >= (LIBNAME_RECORD_SIZE-libname_record_len)) {
                /*
                 * Complete record received in this transaction.
                 */
                memcpy((buffptr+libname_record_len), cptr, (LIBNAME_RECORD_SIZE-libname_record_len));
                cptr += (LIBNAME_RECORD_SIZE-libname_record_len);
                rlen -= (LIBNAME_RECORD_SIZE-libname_record_len);
                buffptr = NULL;
		libname_record_len = 0;

                /*
                 * Fill standard event here (In this case, ev_ptr)
                 */

		/* 
		 * Lets move on next record, we alreay have assurance here
		 * abt ev_ptr space.
		 */
		parse_rec++;
		ev_ptr = &searray[parse_rec];
		continue;
            } else {
                /*
                 * Haven't got complete record yet.
                 */
                memcpy(buffptr+libname_record_len, cptr, rlen);
                libname_record_len += rlen;
                return parse_rec;
            }
        }
        if (rlen >= LIBNAME_RECORD_SIZE) {
            /*
             * We have one full record, fill hrecord
             */
	    record_ptr = (struct libname *)cptr;
            cptr += LIBNAME_RECORD_SIZE;
            rlen -= LIBNAME_RECORD_SIZE;

            /*
             * Fill standard event here
             */


	    /* 
	     * Lets move on next record, we alreay have assurance here
	     * abt ev_ptr space.
	     */
	    parse_rec++;
	    ev_ptr = &searray[parse_rec];
        } else {
            /*
             * Partial record, fill partial hrecord and expect remaining in
             * the next chunk
             */
            buffptr = (void *)libname_record;
            memcpy(buffptr, cptr, rlen);
            libname_record_len = rlen;
            rlen = 0;
        }
    }

    return parse_rec;
}
