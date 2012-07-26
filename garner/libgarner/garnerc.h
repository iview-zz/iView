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

/* Project:	lib_garner.so
 * File:	garner.h
 * Description: Client for connecting to garner.
 * Author:	Vinod Patel
 */

#ifndef _LIB_GARNER_H_
#define _LIB_GARNER_H_

#define GR_FLAGS_NONBLOCK 1

/* gr_init
 * Arguments:
 * 	Ident - System identification alpha-numeric string (<16 chars)
 * 	Server - Address of garner (can be UNIX path or INET(address and port)).
 *	flags - Or'ed GR_FLAGS_* values.
 * Return Value:
 * 	Returns (struct _garner *) type-casted as (void*) to avoid exposing
 *	internal data structures.
 * Description:
 * 	Opens a connection with garner and does the initial handshake.
 * 
 */
void *gr_init(const char *ident, const char *server, u_int32_t flags);

/* gr_close
 * Arguments:
 *	gr - structure returned by gr_init.
 * Return Value:
 *	None
 * Description:
 * 	Frees the data-structures associated with gr and closes the connection.
 * 
 */
void gr_close(void *gr);

/* gr_io
 * Arguments:
 *	gr - structure returned by gr_init.
 *	buffer - data
 *	buflen - data length
 * Return Value:
 *	None
 * Description:
 *	Sends the buffer data to daemon. Handles IO.
 */
void gr_io(void *gr, u_int8_t *buffer, ssize_t buflen);


/* gr_log
 * Arguments:
 *	gr - structure returned by gr_init.
 *	format ... - prinf style arguments
 * Return Value:
 *	None
 * Description:
 *	Sends the formatted data to daemon. Internally calls gr_io.
 */
void gr_log(void *gr, const char*, ...) __attribute__((format(printf, 2, 3)));

#endif /* _LIB_GARNER_H_ */
