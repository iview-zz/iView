#ifndef _CYBEROAM_OP_HBTLVCLIENT_H_
#define _CYBEROAM_OP_HBTLVCLIENT_H_
#include "../../../src/std_event.h"

/*
 * This routine would be called once by garner during initialization.
 * Version mismatch can be check during init itself.
 */
int hbtlvclient_init(const char *argstring, u_int32_t version, void **handle);
/*
 * Frees the internal data-structures of the library.
 */
void hbtlvclient_close(void *handle);

/*
 * Description:
 *	Output plugin, can be formatter or processor
 */
void
hbtlvclient_output(struct _std_event *searray, u_int32_t nse,
                                struct _output_data **output_data_list, void *handle);

int hbtlvclient_reconfig(const char *argstring, void **handle);
#endif
