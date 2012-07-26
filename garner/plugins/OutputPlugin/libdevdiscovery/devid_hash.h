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

#ifndef _CYBEROAM_OP_DEVICE_DESCOVERY_DEVID_HASH_H_
#define _CYBEROAM_OP_DEVICE_DISCOVERY_DEVID_HASH_H_

#define	DEVICEID_STATUS_NOT_FOUND	0x01
#define	DEVICEID_STATUS_REGISTERED	0x02
#define	DEVICEID_STATUS_UNREGISTERED	0x03

int  devid_hash_add(void **handle, char *devid, u_int8_t status);
int  devid_hash_delete(void **handle, char *devid);
void devid_hash_delete_all(void **handle);

u_int8_t devid_hash_get_status(void **handle, char *devid);

#endif
