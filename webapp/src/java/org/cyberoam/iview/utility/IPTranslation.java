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

/**
 * 
 */
package org.cyberoam.iview.utility;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * This class is used to resolve IP Address to Host name.
 * @author atitshah
 *
 */
public class IPTranslation {

	private static HashMap resolvedIP=new HashMap();
	private static final int MAX_CACHE_LIMIT=5000;
	/**
	 * This function is used to resolve IP Address to Host Name	
	 * @param ipAddress IP Address for resolving host name.
	 * @return hostname
	 */
	public static String getHostName(String ipAddress) {
		String hostName="";
		/*
		 * Search in the cache if not found then resolve by dns
		 */
		hostName=(String)resolvedIP.get(ipAddress);
		if(hostName == null) {			
			try {
				hostName=InetAddress.getByName(ipAddress).getHostName();
			} catch (UnknownHostException e) {
			CyberoamLogger.sysLog.debug("Host name for ip address " + ipAddress+ " not resolved due to " +e.getMessage());
			}
			if(!ipAddress.equalsIgnoreCase(hostName) && resolvedIP.size() <= MAX_CACHE_LIMIT){
				resolvedIP.put(ipAddress,hostName);
			}
		}
		if(hostName == null) hostName=ipAddress;
		
		return hostName;
	}
}
