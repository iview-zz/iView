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

#ifndef _CYBEROAM_OP_DEVICE_DESCOVERY_H_
#define _CYBEROAM_OP_DEVICE_DISCOVERY_H_

#include "../../../src/std_event.h"

/*
 * This routine would be called once by garner during initialization.
 * Version mismatch can be check during init itself.
 */
int devdiscovery_init(const char *argstring, u_int32_t version, void **handle);

/*
 * Frees the internal data-structures of the library.
 */
void devdiscovery_close(void *handle);

/*
 * Description:
 *	Output plugin, can be formatter or processor
 */
void devdiscovery_output(struct _std_event *searray, u_int32_t nse,
		struct _output_data **output_data_list, void *handle);

void devdiscovery_debug(void);

#endif
