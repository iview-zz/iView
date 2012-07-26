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
 * @(#)ConnectionPool.java
 *
 * Copyright (c) 1999 Elitecore Techonologies Pvt. Ltd. All Rights Reserved.
 *
 * You may study, use, modify, and distribute this software for any
 * purpose provided that this copyright notice appears in all copies.
 *
 * This software is provided WITHOUT WARRANTY either expressed or
 * implied.
 *
 * @author  Ajay Iyer
 * @version 1.1
 * @date    27Apr1999
 * @modified by Abhilash V. Sonwane
 * @modified date 31Mar2001
 */

package org.cyberoam.iviewdb.helper;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import org.cyberoam.iview.audit.CyberoamLogger;

/**
 * <p>This class serves as a JDBC connection repository. Since
 * creating database connections is one of the most time
 * intensive aspects of JDBC, we'll create a pool of connections.
 * Each connection can be used and then replaced back into the
 * pool.
 *
 * <p>A properties file 'ConnectionPool.cfg' will be used to
 * specify the types of JDBC connections to create, as well as
 * the minimum and maximum size of the pool. The format of
 * the configuration file is:</p>
 *#(comment)
 *   JDBCDriver=&lt;JDBC driver name&gt;<br>
 *   JDBCConnectionURL=&lt;JDBC Connection URL&gt;<br>
 *   ConnectionPoolSize=&lt;minimum size of the pool&gt;<br>
 *   ConnectionPoolMax=&lt;maximum size of the pool, or -1 for none&gt;<br>
 *   ConnectionUseCount=&lt;maximum usage count for one connection&gt;<br>
 *   ConnectionTimeout=&lt;maximum idle lifetime (in minutes) of a connection&gt;<br>
 *  ConnectionAttempt=&lt;maximum attempts made before returning zero&gt;<br>
 *   &lt;other property for JDBC connection&gt;=&lt;value&gt;<br>
 *   Username=&lt;name of user for connecting with db&gt;<br>
 *   Password=&lt;passwd of user connecting&gt;<br>
 * <p>Any number of additional properties may be given (such
 * as username and password) as required by the JDBC driver.</p>
 * @author Cyberoam
 */

public class ConnectionPool
  implements org.cyberoam.iviewdb.helper.TimerListener
{
	
  // JDBC Driver name
  String m_JDBCDriver;

  // JDBC Connection URL
  String m_JDBCConnectionURL;

  // Minimum size of the pool
  int m_ConnectionPoolSize;

  // Maximum size of the pool
  int m_ConnectionPoolMax;

  // Maximum number of uses for a single connection, or -1 for
  // none
  int m_ConnectionUseCount;

  // Maximum connection idle time (in miliseconds)
  int m_ConnectionTimeout;

  // Interval in which the time checks for timed out connections(in seconds)
  int m_TimerInterval;

  
  // Maximum connection attempt
  int m_ConnectionAttempt;

  // Additional JDBC properties
  Properties m_JDBCProperties; //not used currently

  //user name
  String m_User;

  //password
  String m_Password;

  // The Connection pool. This is a ArrayList of ConnectionObject
  // objects
  ArrayList m_pool;

  // The maximum number of simultaneous connections as reported
  // by the JDBC driver
  int m_MaxConnections = -1;
  
  /**
   * Flag that states whether Mysql database is used or not.
   */
  public static boolean isMysql = false;
  /**
   * Flag that states whether PostgreSql database is used or not.
   */
  public static boolean isPostgreSql = false;

  // Our Timer object
  org.cyberoam.iviewdb.helper.Timer m_timer;

  /**
    * <p>Initializes the ConnectionPool object using
    * 'ConnectionPool.cfg' as the configuration file
    *
    * @return true if the ConnectionPool was initialized
    * properly
    */
  public boolean initialize() throws Exception
    {
      boolean success = initialize("ConnectionPool.cfg");
	  return success;
    }

  /**
    * <p>Initializes the ConnectionPool object with the specified
    * configuration file
    *
    * @param config Configuration file name
    * @return true if the ConnectionPool was initialized
    * properly
    */
  public boolean initialize(String config) throws Exception
    {
      // Load the configuration parameters. Any leftover parameters
      // from the configuration file will be considered JDBC
      // connection attributes to be used to establish the
      // JDBC connections
      boolean rc = loadConfig(config);
	  
	  if(rc){
  		if(m_JDBCDriver.indexOf("org.gjt.mm.mysql") != -1){
			  isMysql =true;
		}
  		if(m_JDBCDriver.indexOf("org.postgresql.Driver") != -1){
			  isPostgreSql =true;
		}
		CyberoamLogger.connectionPoolLog.debug("EQUALSIGNORECASE" + 
											   m_JDBCDriver.equalsIgnoreCase("org.gjt.mm.mysql.Driver"));
		CyberoamLogger.connectionPoolLog.debug("ISMYSQL: " + isMysql);
		CyberoamLogger.connectionPoolLog.debug("ISPOSTGRESSQL: " + isPostgreSql);
	  }

	  if (rc) {
        // Properties were loaded; attempt to create our pool
        // of connections
        createPool();
        // Start our timer so we can timeout connections. The
        // clock cycle will be 20 seconds
        m_timer = new org.cyberoam.iviewdb.helper.Timer(this, m_TimerInterval);
        m_timer.start();
      }
      return rc;
    }

  /**
    * <p>Destroys the pool and it's contents. Closes any open
    * JDBC connections and frees all resources
    */
  public void destroy(){
      try {
        // Stop our timer thread
        if (m_timer != null) {
          //m_timer.stop();
          m_timer.setExit(false);
          m_timer = null;
        }
        // Clear our pool
        if (m_pool != null) {
          // Loop throught the pool and close each connection
          for (int i = 0; i < m_pool.size(); i++) {
            close((ConnectionObject)m_pool.get(i));
          }
        }
        m_pool = null;
      }catch (Exception ex) {
		  CyberoamLogger.connectionPoolLog.error("Exception in destroy: " + ex,ex);
      }
    }

  /**
    * <p>Gets an available JDBC Connection. Connections will be
    * created if necessary, up to the maximum number of connections
    * as specified in the configuration file.
    *
    * @return JDBC Connection, or null if the maximum
    * number of connections has been exceeded
    */
  
  public synchronized Connection getConnection(){
      // If there is no pool it must have been destroyed
	  if (m_pool == null) {
        return null;
      }

      java.sql.Connection con = null;
      ConnectionObject connectionObject = null;
      //int poolSize = m_pool.size();
      // Get the next available connection
      for (int i = 0; i < m_pool.size(); i++) {
        // Get the ConnectionObject from the pool
        ConnectionObject co = (ConnectionObject)m_pool.get(i);
		CyberoamLogger.connectionPoolLog.debug("Connection object in pool getconnection: " + co);
        // If this is a valid connection and it is not in use,
        // grab it
        if (co.isAvailable()){
          connectionObject = co;
          break;
        } else {
        	try { 
	        	if(co.con.isClosed()){
	        		co.con.close();
	        		m_pool.remove(i);
	        	}
        	}catch (SQLException e) {
				
			}
        	
        }
      }

      // No more available connections. If we aren't at the
      // maximum number of connections, create a new entry
      // in the pool
      if (connectionObject == null){
        if ((m_ConnectionPoolMax < 0) ||
            ((m_ConnectionPoolMax > 0) &&
             (m_pool.size() < m_ConnectionPoolMax))) {

          // Add a new connection.
          int i = addConnection();
          // If a new connection was created, use it
          if (i >= 0) {
            connectionObject = (ConnectionObject)m_pool.get(i);
          }
        }
        else {
          trace("Maximum number of connections exceeded");
        }
      }

      // If we have a connection, set the last time accessed,
      // the use count, and the in use flag
      if (connectionObject != null) {
			connectionObject.inUse = true;
			connectionObject.useCount++;
			touch(connectionObject);
			con = connectionObject.con;
      }
	  trace("Connection pool size in getConnection: " + m_pool.size());
      return con;
    }

  /**
    * <p>Places the connection back into the connection pool,
    * or closes the connection if the maximum use count has
    * been reached
    *
    * @param Connection object to close
    */
  
  public synchronized void close(Connection con){
      // Find the connection in the pool
      int index = find(con);

      if (index != -1) {
        ConnectionObject co = (ConnectionObject)m_pool.get(index);
        // If the use count exceeds the max, remove it from
        // the pool.
        if ((m_ConnectionUseCount > 0) &&
            (co.useCount >= m_ConnectionUseCount)) {
          trace("Connection use count exceeded");
          removeFromPool(index);
        } else {
          // Clear the use count and reset the time last used
          touch(co);
          co.inUse = false;
        }
      }
    }

  /**
    * <p>Prints the contents of the connection pool to the
    * standard output device
    */
  public void printPool()
    {
      CyberoamLogger.connectionPoolLog.debug("--ConnectionPool--");
      if (m_pool != null) {
        for (int i = 0; i < m_pool.size(); i++) {
          ConnectionObject co = (ConnectionObject)
            m_pool.get(i);
          CyberoamLogger.connectionPoolLog.debug("" + i + "=" + co);
        }
      }
    }

  /**
    * <p>Removes the ConnectionObject from the pool at the
    * given index
    *
    * @param index Index into the pool ArrayList
    */
  private synchronized void removeFromPool(int index)
    {
      // Make sure the pool and index are valid
      if (m_pool != null) {
        if (index < m_pool.size()) {
          // Get the ConnectionObject and close the connection
          ConnectionObject co = (ConnectionObject)
            m_pool.get(index);
          close(co);
          // Remove the element from the pool
          m_pool.remove(index);
        }
      }
    }

  /**
    * <p>Closes the connection in the given ConnectionObject
    *
    * @param connectObject ConnectionObject
    */
  private void close(ConnectionObject connectionObject)
    {
      if (connectionObject != null) {
        if (connectionObject.con != null) {
          try {

            // Close the connection
            connectionObject.con.close();
          }
          catch (Exception ex) {
            // Ignore any exceptions during close
          }

          // Clear the connection object reference
          connectionObject.con = null;
        }
      }
    }

  /**
    * <p>Loads the given configuration file.  All global
    * properties (such as JDBCDriver) will be
    * read and removed from the properties list. Any leftover
    * properties will be returned. Returns null if the
    * properties could not be loaded
    *
    * @param name Configuration file name
    * @return true if the configuration file was loaded
    */
  private boolean loadConfig(String name)
    throws Exception
    {
      boolean rc = false;

      // Get our class loader
      ClassLoader cl = getClass().getClassLoader();

      // Attempt to open an input stream to the configuration file.
      // The configuration file is considered to be a system
      // resource.
      java.io.InputStream in;

      if (cl != null) {
        in = cl.getResourceAsStream(name);
      }else {
        in = ClassLoader.getSystemResourceAsStream(name);
      }

      // If the input stream is null, then the configuration file
      // was not found
      if (in == null) {
        throw new Exception("ConnectionPool configuration file '" +
                           name + "' not found");
      }
      else {
        try {
          m_JDBCProperties = new java.util.Properties();

          // Load the configuration file into the properties table
          m_JDBCProperties.load(in);

          // Got the properties. Pull out the properties that we
          // are interested in
          m_JDBCDriver = consume(m_JDBCProperties, "JDBCDriver");
          m_JDBCConnectionURL = consume(m_JDBCProperties,
                                        "JDBCConnectionURL");
          
		  m_ConnectionPoolSize = consumeInt(m_JDBCProperties,
                                            "ConnectionPoolSize");
          
		  m_ConnectionPoolMax = consumeInt(m_JDBCProperties,
                                           "ConnectionPoolMax");
          
		  //Convert the connectiontimeout to milliseconds for easier calculation
		  m_ConnectionTimeout = consumeInt(m_JDBCProperties,
                                           "ConnectionTimeout")*1000;
          
		  m_TimerInterval = consumeInt(m_JDBCProperties,
                                           "TimerInterval");

		  //m_ConnectionAttempt = consumeInt(m_JDBCProperties,
                                           //"ConnectionAttempt");
          
		  m_ConnectionUseCount = consumeInt(m_JDBCProperties,
                                            "ConnectionUseCount");
          
		  m_User = consume(m_JDBCProperties,"User");

		  
		  m_Password = consume(m_JDBCProperties,"Password");

          rc = true;
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.error("Exception in loadconfig: ", e);
		}
        finally {
          // Always close the input stream
          if (in != null) {
            try {
              in.close();
            }
            catch (Exception ex) {
            }
          }
        }
      }
      return rc;
    }

    /**
    * <p>Consumes the given property and returns the value.
    *
    * @param properties Properties table
    * @param key Key of the property to retrieve and remove from
    * the properties table
    * @return Value of the property, or null if not found
    */
   private String consume(java.util.Properties p, String key)
    {
      String s = null;

      if ((p != null) &&
          (key != null)) {

        // Get the value of the key
        s = p.getProperty(key);

        // If found, remove it from the properties table
        if (s != null) {
          p.remove(key);
        }
      }
	  if(s == null){
		  CyberoamLogger.connectionPoolLog.error("key is null: "  + key);
	  }
      return s.trim(); //in unix sometimes it gives an error of space<ajay>
    }

  /**
    * <p>Consumes the given property and returns the integer
    * value.
    *
    * @param properties Properties table
    * @param key Key of the property to retrieve and remove from
    * the properties table
    * @return Value of the property, or -1 if not found
    */
  private int consumeInt(java.util.Properties p, String key)
    {
      int n = -1;

      // Get the String value
      String value = consume(p, key);

      // Got a value; convert to an integer
      if (value != null) {
        try {
          n = Integer.parseInt(value);
        }
        catch (Exception ex) {
        }
      }
      return n;
    }

  /**
    * <p>Creates the initial connection pool. A timer thread
    * is also created so that connection timeouts can be
    * handled.
    *
    * @return true if the pool was created
    */
  private void createPool() throws Exception
    {
      // Sanity check our properties
      if (m_JDBCDriver == null) {
        throw new Exception("JDBCDriver property not found");
      }
      if (m_JDBCConnectionURL == null) {
        throw new Exception("JDBCConnectionURL property not found");
      }
      if (m_ConnectionPoolSize < 0) {
        throw new Exception("ConnectionPoolSize property not found");
      }
      if (m_ConnectionPoolSize == 0) {
        throw new Exception("ConnectionPoolSize invalid");
      }
      if (m_ConnectionPoolMax < m_ConnectionPoolSize) {
        trace("WARNING - ConnectionPoolMax is invalid and will " +
              "be ignored");
        m_ConnectionPoolMax = -1;
      }
      if (m_ConnectionTimeout < 0) {
        // Set the default to 5 minutes
        m_ConnectionTimeout = 300*1000;
      }
      if (m_ConnectionAttempt < 0){
        // Set the default to 1 attempt
        m_ConnectionAttempt = 1;
      }
      if (m_User == null ) {
        throw new Exception("UserName not found");
      }
      if (m_Password == null ) {
        throw new Exception("Password not found");
      }

      // Dump the parameters we are going to use for the pool.
      // We don't know what type of servlet environment we will
      // be running in - this may go to the console or it
      // may be redirected to a log file
      trace("JDBCDriver = " + m_JDBCDriver);
      trace("JDBCConnectionURL = " + m_JDBCConnectionURL);
      trace("ConnectionPoolSize = " + m_ConnectionPoolSize);
      trace("ConnectionPoolMax = " + m_ConnectionPoolMax);
      trace("ConnectionUseCount = " + m_ConnectionUseCount);
      trace("ConnectionTimeout = " + m_ConnectionTimeout/1000 +
            " seconds");
      trace("ConnectionAttempt = " + m_ConnectionAttempt +
            " times ");

      // Also dump any additional JDBC properties
      java.util.Enumeration enum1 = m_JDBCProperties.keys();
      while (enum1.hasMoreElements()) {
        String key = (String) enum1.nextElement();
        String value = m_JDBCProperties.getProperty(key);
        trace("(JDBC Property) " + key + " = " + value);
      }

      // Attempt to create a new instance of the specified
      // JDBC driver. Well behaved drivers will register
      // themselves with the JDBC DriverManager when they
      // are instantiated
      trace("Registering " + m_JDBCDriver);
      //java.sql.Driver d = (java.sql.Driver)
        //Class.forName(m_JDBCDriver).newInstance();

      // Create the ArrayList for the pool
      m_pool = new java.util.ArrayList();

      // Bring the pool to the minimum size
      fillPool(m_ConnectionPoolSize);
    }

  /**
    * <p>Adds a new connection to the pool
    *
    * @return Index of the new pool entry, or -1 if an
    * error has occurred
    */
  private int addConnection()
    {
      int index = -1;

      try {
    	// Calculate the new size of the pool
        int size = m_pool.size() + 1;

        // Create a new entry
        fillPool(size);

        // Set the index pointer to the new connection if one
        // was created
        if (size == m_pool.size()) {
          index = size - 1;
        }
      }
      catch (Exception ex) {
		  CyberoamLogger.connectionPoolLog.error("Exception in addConnection: " + ex,ex);
      }
      return index;
    }

  /**
    * <p>Brings the pool to the given size
    */
  private synchronized void fillPool(int size) throws java.sql.SQLException,java.lang.ClassNotFoundException{
      
	  // Loop while we need to create more connections
	  Properties properties=new Properties();
	  properties.setProperty("user", m_User);
	  properties.setProperty("password",m_Password);
	  properties.setProperty("profileSQL","true");
	  properties.setProperty("autoGenerateTestcaseScript", "true");
	  properties.setProperty("logSlowQueries","true");
	  
      while (m_pool.size() < size) {
        ConnectionObject co = new ConnectionObject();
        Class.forName( m_JDBCDriver );
		co.con  = DriverManager.getConnection( m_JDBCConnectionURL,m_User,m_Password);
		/**
		 *If unable to get connection then return from here. 
		 *@author Amit Maniar, Narendra Shah 
		 */
		if(co.con.isClosed()){
			return;
		}

        // Do some sanity checking on the first connection in
        // the pool
        if (m_pool.size() == 0) {

          // Get the maximum number of simultaneous connections
          // as reported by the JDBC driver
          java.sql.DatabaseMetaData md = co.con.getMetaData();
          m_MaxConnections = md.getMaxConnections();
        }

        // Give a warning if the size of the pool will exceed
        // the maximum number of connections allowed by the
        // JDBC driver
        if ((m_MaxConnections > 0) &&
            (size > m_MaxConnections)) {
          trace("WARNING: Size of pool will exceed safe maximum of " +
                m_MaxConnections);
        }
        // Clear the in use flag
        co.inUse = false;
        // Set the last access time
        touch(co);
        m_pool.add(co);
      }
    }

  /**
    * <p>Find the given connection in the pool
    *
    * @return Index into the pool, or -1 if not found
    */
  private int find(java.sql.Connection con){
      int index = -1;
      // Find the matching Connection in the pool
      if ((con != null) && (m_pool != null)){
        for (int i=0; i<m_pool.size(); i++){
			ConnectionObject co = (ConnectionObject)
            m_pool.get(i);
			if (co.con == con) {
				index = i;
				break;
			}
        }
      }
      return index;
    }

  /**
    * <p>Called by the timer each time a clock cycle expires.
    * This gives us the opportunity to timeout connections
    */
  public synchronized void TimerEvent(Object object)
    {
      // No pool means no work
      if (m_pool == null) {
        return;
      }

      // Get the current time in milliseconds
      long now = System.currentTimeMillis();

      /**
       * Check for any expired connections and remove them
       */
	  
       for (int i = m_pool.size() - 1; i >= 0; i--) {
		  ConnectionObject co = (ConnectionObject)m_pool.get(i);

		  // If the connection is not in use and it has not been
		  // used recently, remove it
		  if (!co.inUse) {
		    if ((m_ConnectionTimeout > 0) &&
		        (co.lastAccess +
		         (m_ConnectionTimeout) < now)) {
		      removeFromPool(i);
		      trace(" Time Out con "+ i);
		      trace(" source "+m_ConnectionTimeout);
		      trace(" dest "+now);

		    }
		  }
		}

      /** 
       * 
       * Remove any connections that are no longer open
       * This Check is not required for the org.gjt.mm.mysql.Driver
       * as the driver itself checks for connection sanity.
       * 
       * More than that this WAS CAUSING A DEADLOCK LIKE SITUATION
       * WHICH STOPPED THE CONNECTION POOL FROM SERVING ANY CONNECTIONS.
       * 
       * So this check should not be made for the org.gjt.mm.mysql.Driver
       * 
       * Should be reviewed for all other drivers
       */
	  if(!isMysql){
		  CyberoamLogger.connectionPoolLog.debug("IN REMOVE CLOSED CONNECTION");
	      for (int i = m_pool.size() - 1; i >= 0; i--) {
	        ConnectionObject co = (ConnectionObject)m_pool.get(i);
	        try{
	          // If the connection is closed, remove it from the pool
	          if (co.con.isClosed()) {
	//            ConnectionPoolLogger.log("Connection closed unexpectedly");
	            trace("Connection closed unexpectedly");
	            removeFromPool(i);
	          }
	        }
	        catch (Exception ex) {
	        }
	      }
	  }

      // Now ensure that the pool is still at it's minimum size
      try {
        if (m_pool != null) {
          if (m_pool.size() < m_ConnectionPoolSize) {
            fillPool(m_ConnectionPoolSize);
          }
        }
      }
      catch (Exception ex) {
		  CyberoamLogger.connectionPoolLog.error("Exception in addConnection:" + ex,ex);
      }
	  CyberoamLogger.connectionPoolLog.debug("Connection Pool Size in timer event: " + m_pool.size());
    }

  /**
    * <p>Sets the last access time for the given ConnectionObject
    */
  private void touch(ConnectionObject co)
    {
      if (co != null) {
        co.lastAccess = System.currentTimeMillis();
      }
    }

  /**
    * <p>Trace the given string
    */
  private void trace(String s)
    {
      CyberoamLogger.connectionPoolLog.debug(s);
    }
}


// This package-private class is used to represent a single
// connection object
class ConnectionObject{
  
	// The JDBC Connection
	public java.sql.Connection con;

	// true if this connection is currently in use
	public boolean inUse;

	// The last time (in milliseconds) that this connection was used
	public long lastAccess;

	// The number of times this connection has been used
	public int useCount;

	
	/**
    * <p>Determine if the connection is available
    *
    * @return true if the connection can be used
	*/
 
  public boolean isAvailable(){
	  boolean available = false;
      try {
        // To be available, the connection cannot be in use
        // and must be open
        if (con != null) {
			/**
			 * If the database is Mysql
			 * then should not check whether the connection is closed or not
			 * becos the driver itself checks whether the connection are 
			 * open or not
			 */
          if (!inUse &&
              (ConnectionPool.isMysql || !con.isClosed())) {
            available = true;
          }
        }
      }catch(Exception ex) {
      }
      return available;
    }
	
	/**
    * <p>Convert the object contents to a String
    */
	public String toString(){
      return "Connection=" + con + ",inUse=" + inUse + ",lastAccess=" + lastAccess + ",useCount=" + useCount;
    }
}
