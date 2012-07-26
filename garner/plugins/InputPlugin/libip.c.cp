#include "libname.h"

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
    return 0;
}


/*
 * Frees the internal data-structures of the library.
 */
void
libname_close()
{
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
    return 0;
}
