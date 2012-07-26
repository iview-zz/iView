#ifndef _CYBEROAM_OP_LIBNAME_H_
#define _CYBEROAM_OP_LIBNAME_H_
#include "../../../src/std_event.h"

/*
 * This routine would be called once by garner during initialization.
 * Version mismatch can be check during init itself.
 */
int libname_init(const char *argstring, u_int32_t version);
/*
 * Frees the internal data-structures of the library.
 */
void libname_close();

/*
 * Description:
 *	Output plugin, can be formatter or processor
 */
void
libname_output(struct _std_event *searray, u_int32_t nse,
                                struct _output_data **output_data_list);
#endif
