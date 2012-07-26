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


import java.sql.Connection;

import org.cyberoam.iview.audit.CyberoamLogger;

import org.cyberoam.iviewdb.helper.ConnectionPool;

/**
 * 
 * This class is used for managing connection pool with database.
 * @author Cyberoam
 *
 */
public class ConnectionManager extends Object{
    private static ConnectionManager instance=null;
    private ConnectionPool m_connectionPool;
    /**
     * Default constructor for connection pool manager.This constructor initializes the connection pool.
     */
	public ConnectionManager(){
        init();
    }
	
	/**
	 * This method initializes pool of the connection manager.
	 */
    public void init(){
	  CyberoamLogger.connectionPoolLog.info("Initializing ConnectionManager");
      // Create our connection pool
      m_connectionPool = new ConnectionPool();
      // Initialize the connection pool. This will start all
      // of the connections as specified in the connection
      // pool configuration file
      try {
        //m_connectionPool.initialize
        //  ("pool/jdbc/ConnectionPool.cfg");
        m_connectionPool.initialize
          ("ConnectionPool.cfg");
		
      }
      catch (Exception ex) {
        // Convert the exception
		  CyberoamLogger.connectionPoolLog.error("Exception in addConnection:" + ex,ex);
      }
    }
    
    /**
     * This method returns shared instance of connection manager.
     * @return
     */
    public static synchronized ConnectionManager getSharedInstance(){
		if (instance == null){
			CyberoamLogger.connectionPoolLog.error("instance is null");
            instance = new ConnectionManager();
		}
        return instance;
    }
	/**
	 * This method returns connection from connection pool.
	 * @return
	 */
    public Connection getConnection(){
        boolean attempt = true;
        int i=0;
        while (attempt) {
        	java.sql.Connection con = m_connectionPool.getConnection();
			i++;
			if (con == null){
			    CyberoamLogger.connectionPoolLog.error(getClass() + " Error in getting Connection");
			    CyberoamLogger.connectionPoolLog.error("Trying again "+ i);
			    /**
			     * Reduced reconnection attempts.
			     * @author Narendra Shah, Amit Maniar
			     */
			    if (i < 5)
			        continue;
			}
			CyberoamLogger.connectionPoolLog.debug("GOT connection from connection manager: ");
			//new Exception().printStackTrace(System.out);
			return con;
        }
        return null;
    }
	// we can rely on the close method as connection validity is checked for both
    // accounts
    /**
     * This method closes connections in connection manager.
     */
    public void close(Connection con){
		CyberoamLogger.connectionPoolLog.debug("Closing connection in connection manager " + con);
        m_connectionPool.close(con);
    }
    
    /**
     * This method destroys connection pool if it was created.
     */
	public void destroy(){
      // Tear down our connection pool if it was created
      if (m_connectionPool != null) {
        m_connectionPool.destroy();
      }
    }	
}
