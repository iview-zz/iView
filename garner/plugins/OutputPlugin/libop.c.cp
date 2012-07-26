#include "libname.h"

/*
 * Arguments:
 *	argstring - Arguments passed along with the output line in output block.
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
 *	searray - an array of standard events
 *	nse - number of elements in searray.
 *	output_data_list - 2D pointer to output data list
 * Description:
 *      Output plugin, can be formatter or processor
 */
void
libname_output(struct _std_event *searray, u_int32_t nse,
				struct _output_data **output_data_list)
{
    return;
}
