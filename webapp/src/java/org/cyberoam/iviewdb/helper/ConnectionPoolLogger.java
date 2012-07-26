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

package org.cyberoam.iviewdb.helper;

import org.apache.tomcat.logging.*;

/**
 * 
 * This class is used to manage connection pool logs.
 * @author Cyberoam
 *
 */
public class ConnectionPoolLogger{
	
	private static Logger connectionPoollog = null;

	static{
		connectionPoollog = Logger.getLogger("CONNECTIONPOOL_LOG");
	}
	/**
	 * This method logs given message into log file.
	 * @param message message to be logged
	 */
	public final static void log(String message) {
		if (connectionPoollog == null)
		    connectionPoollog = Logger.getLogger("CONNECTIONPOOL_LOG");

		if (connectionPoollog != null)
		    connectionPoollog.log(message);
	}
	
	/**
	 * This method logs given message into log file with given verbosity level.
	 * @param message
	 * @param verbosityLevel
	 */
	public final static void log(String message,int verbosityLevel) {
		if (connectionPoollog == null)
		    connectionPoollog = Logger.getLogger("CONNECTIONPOOL_LOG");

		if (connectionPoollog != null)
		    connectionPoollog.log(message, verbosityLevel);
    }

	/**
	 * This method logs given message into log file for debugging purpose.
	 * @param message
	 * @param t
	 */
	public final static void  log(String message,Throwable t) {
		if (connectionPoollog == null)
		    connectionPoollog = Logger.getLogger("CONNECTIONPOOL_LOG");

		if (connectionPoollog != null)
		    connectionPoollog.log(message, t, Logger.ERROR);
								  
	}

	/**
	 * This method logs given message into log file for debugging purpose with given verbosity level.
	 * @param message
	 * @param t
	 * @param verbosityLevel
	 */
	public final static void  log(String message,Throwable t, int verbosityLevel) {
		if (connectionPoollog == null)
		    connectionPoollog = Logger.getLogger("CONNECTIONPOOL_LOG");

		if (connectionPoollog != null)
		    connectionPoollog.log(message, t, verbosityLevel);
    }
}
