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

package org.cyberoam.iviewdb.utility;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.helper.ConnectionManager;


import org.cyberoam.iviewdb.helper.ConnectionPool;;

/**
 * This class is used to execute SQL statements into database.
 * @author Cyberoam
 *
 */
public class SqlReader{
	private static boolean DEBUG = false;
	private Connection transaction;
	private boolean connectionClosed = false;
	private long createTime = 0;
	public boolean pool;
	/**
	 * Default constructor for SQL reader.
	 * This constructor sets pool to false therefore connection instance will be stored in instance itself after getting from connection pool.  
	 */
	public SqlReader(){
		this.pool = false;
	}
	/**
		If pool is true always get the connection from the connection pool
		else store the connection in the instance itself after getting from 
		the connection pool.
	*/
	public SqlReader(boolean pool){
		this.pool = pool;
		createTime = System.currentTimeMillis();
	}
	/**
	 * Sets pool flag.
	 * @param pool
	 */
	public void setPool(boolean pool){
		this.pool = pool;
	}
	/**
	 * Returns current pool flag.
	 * @return
	 */
	public boolean getPool(){
		return pool;
	}
	/**
	 * Closes given connection.
	 * @param con
	 */
	public void close(Connection con){
		ConnectionManager.getSharedInstance().close(con);
		connectionClosed = true;
	}
	/**
	 * Closes connection contained with in instance.
	 */
	public void close(){
		try {
			ConnectionManager.getSharedInstance().close(transaction);
			transaction = null;
			connectionClosed = true;
		}catch (Exception e) {
			CyberoamLogger.connectionPoolLog.debug("SqlReader.close():"+e,e);
 		}
	}
	/**
	 * Returns string representation of SQL reader instance.
	 */
	public String toString(){
		return "SqlReader: " + createTime+ "Connection: " + transaction;
	}
	/**
	 * Returns connection instance.
	 * @return
	 */
	public Connection getConnection(){
		return ConnectionManager.getSharedInstance().getConnection();
	}
	/**
	 * Returns result set wrapper instance for given SQL query.
	 * @param query
	 * @return
	 * @throws java.lang.NullPointerException
	 */
	public static ResultSetWrapper getResultSetWrapper(String query)
		throws java.lang.NullPointerException{
		try{
			return new ResultSetWrapper(query);
		}catch(SQLException se){
			return null;
		}
	}
	/**
	 * Returns result set wrapper instance for given SQL query.
	 * @param query
	 * @return
	 * @throws java.sql.SQLException
	 * @throws java.lang.NullPointerException
	 */
	public ResultSetWrapper getInstanceResultSetWrapper(String query)
		throws java.sql.SQLException,java.lang.NullPointerException{
			return getInstanceResultSetWrapper(query,120);	
	}
	/**
	 * Returns result set wrapper instance for given SQL query.
	 * Here it is also possible to apply query time out.
	 * @param query
	 * @param queryTimeOut
	 * @return
	 * @throws java.sql.SQLException
	 * @throws java.lang.NullPointerException
	 */
	public ResultSetWrapper getInstanceResultSetWrapper(String query,int queryTimeOut)
		throws java.sql.SQLException,java.lang.NullPointerException{
		CyberoamLogger.sqlLog.debug("select query:" +query);
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		if (pool){
			transaction = getConnection();
		}else{
			if (transaction == null || transaction.isClosed()){
				trace("Using NEW NEW Connection");
				transaction = getConnection();
				if(ConnectionPool.isPostgreSql){
					transaction.setAutoCommit(true);
				}else{
					transaction.setAutoCommit(false);
				}
			}
		}
		if(ConnectionPool.isPostgreSql){
			stmt = transaction.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		}else {
			stmt = transaction.createStatement();
		}
		stmt.setQueryTimeout(queryTimeOut);
		rs = stmt.executeQuery( query );
		return new ResultSetWrapper(transaction,stmt,rs);
	}
	/**
	 * Returns ArrayList containing result of given SQL query.
	 * @param query
	 * @param queryTimeOut
	 * @return
	 * @throws java.sql.SQLException
	 * @throws java.lang.NullPointerException
	 */
	public static ArrayList getResultAsArrayList(String query,int queryTimeOut) throws java.sql.SQLException,java.lang.NullPointerException{
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		con = ConnectionManager.getSharedInstance().getConnection();
		stmt = con.createStatement();
		stmt.setQueryTimeout(queryTimeOut);
		rs = stmt.executeQuery(query);
		ArrayList temp = convertToArrayList(rs);
		rs.close();
		stmt.close();
		ConnectionManager.getSharedInstance().close(con);
		return temp;
	}

	/**
	 * This method executes SQL query and returns result as ArrayList.
	 * @param query
	 * @return
	 */
	public ArrayList executeSqlArrayList(String query){
		trace("before: "+query);
		// The JDBC Connection object
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			if (pool){
				con = getConnection();
			}else {
				if (transaction!=null){
					con =transaction;
				}else {
					transaction = con = getConnection();
					if(ConnectionPool.isPostgreSql){
						transaction.setAutoCommit(true);
					}else{ 
						transaction.setAutoCommit(false);
					}
				}
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			ArrayList temp = convertToArrayList(rs);
			if(pool){
				close(con);
			}
			return temp;
		}catch(java.sql.SQLException e){
			CyberoamLogger.connectionPoolLog.error("Error in executing Query: "+ query, e);
			return null;
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.debug("Error in executing Query: "+ query, e);
			transaction = null;
			ConnectionManager.getSharedInstance().close(con);
			return null;
		}finally {
			try{
				if (rs !=  null)rs.close();
			}catch(java.sql.SQLException e){}
			try{
				if (stmt !=  null)stmt.close();
			}catch(java.sql.SQLException e){}
			close(con);
		}
	}
	/**
	 * Executes update Query.
	 */
	public int executeUpdate (String update,int queryTimeOut) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int value;
		CyberoamLogger.sqlLog.debug("update query:" +update);
		try{
			CyberoamLogger.connectionPoolLog.debug("Execute Update: " + transaction);
			if (pool){
				transaction = getConnection();
				CyberoamLogger.connectionPoolLog.debug("Got the connection object: " + transaction);
			}else{
				if (transaction == null || transaction.isClosed()){
					CyberoamLogger.connectionPoolLog.debug("Using NEW NEW Connection");			
					transaction = getConnection();
					if(ConnectionPool.isPostgreSql){
						transaction.setAutoCommit(true);
					}else {
						transaction.setAutoCommit(false);
					}
					CyberoamLogger.connectionPoolLog.debug("Using NEW NEW Connection: " + transaction + ":autocommit: " + transaction.getAutoCommit());
				}
			}
			CyberoamLogger.connectionPoolLog.debug("Connection Object: " + transaction + " " + createTime);
			stmt = transaction.createStatement();
			stmt.setQueryTimeout(queryTimeOut);
			value = stmt.executeUpdate(update);
			CyberoamLogger.connectionPoolLog.debug("update value: " + value);
			if(pool){ 
				transaction.commit(); //commiting single transaction explicitly
				close(transaction);
			}
		}catch(java.sql.SQLException e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExceuteUpdate SQLException Exception:\n " + update, e );
			throw e;
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExceuteUpdate General Exception:\n " + update, e );
			return -1;
		}finally{
			try{
				stmt.close();
			}catch(Exception e){
				CyberoamLogger.connectionPoolLog.error("Statement closed in SqlReader execute update:" + update, e );
			}
		}
		return value;
	}
/**
 * A method specific for mysql which returns the last insert id
 */
/*
 * Requesting you to please pass insert query without auto increment field in any mysql or postgres case 
 * and provide fildname in second argument. 
 * This will return last insert id.
 * @returns last insert id.
 */
	
	/*public int executeInsertWithLastid(String update,int querytime) throws SQLException{
		return -1;
	}*/
	public int executeInsertWithLastid(String update,String fieldName) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int queryTimeOut=180;
		int value=-1;
		CyberoamLogger.sqlLog.debug("update query:" +update);
		try{
			CyberoamLogger.connectionPoolLog.debug("Execute Update: " + transaction);
			if (pool){
				transaction = getConnection();
				CyberoamLogger.connectionPoolLog.debug("Got the connection object: " + transaction);
			}else{
				if (transaction == null || transaction.isClosed()){
					CyberoamLogger.connectionPoolLog.debug("Using NEW NEW Connection");			
					transaction = getConnection();
					if(ConnectionPool.isPostgreSql){
						transaction.setAutoCommit(true);
					}else {
						transaction.setAutoCommit(false);
					}
					CyberoamLogger.connectionPoolLog.debug("Using NEW NEW Connection: " + transaction + ":autocommit: " + transaction.getAutoCommit());
				}
			}
			CyberoamLogger.connectionPoolLog.debug("Connection Object: " + transaction + " " + createTime);
			
			stmt = transaction.createStatement();
			stmt.setQueryTimeout(queryTimeOut);
			if(ConnectionPool.isMysql){
				value = stmt.executeUpdate(update);
				CyberoamLogger.connectionPoolLog.debug("update value: " + value);
				if(value > 0){
					/*
					 * ToDo : If you need postgres support for last id then you can get it with sequence.nextval. So you need to change 
					 * this function in arg with tablename/sequence name. 
					 */
					String lastInsertIdQuery = "SELECT LAST_INSERT_ID()";
					rs = stmt.executeQuery(lastInsertIdQuery);
					if(rs.next()){
						value = rs.getInt(1);
					}
					CyberoamLogger.connectionPoolLog.debug("postgres insert nextval: " + value);
				}
			}else if(ConnectionPool.isPostgreSql){
				rs = stmt.executeQuery(update + " returning "  + fieldName);
				
				if(rs.next()){
						value = rs.getInt(1);
				}
				CyberoamLogger.connectionPoolLog.debug("postgres insert nextval: " + value);
			}else {
				throw new Exception("Add support for other databases");
			}
			
			if(pool){ 
				transaction.commit(); //commiting single transaction explicitly
				close(transaction);
			}
		}catch(java.sql.SQLException e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExecuteUpdate: " + update, e);
			throw e;
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExcecuteUpdate General Exception: " + update,e);
			return -1;
		}finally{
			try{
				if(rs != null){
					rs.close();
				}
				stmt.close();
			}catch(Exception e){
				CyberoamLogger.connectionPoolLog.info("Statement closed in SqlReader execute update: ", e);
			}
		}
		return value;
	}

	/**
	 * Executes update Query.
	 */
	public int executeUpdateSingleStatement ( String update,int queryTimeOut ) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int value;
		CyberoamLogger.sqlLog.debug("update query:" +update);
		try{
			if (pool){
				transaction = getConnection();
			}else{
				if (transaction == null || transaction.isClosed()){
					CyberoamLogger.connectionPoolLog.debug("Using NEW NEW Connection");
					transaction = getConnection();
					if(ConnectionPool.isPostgreSql){
						transaction.setAutoCommit(true);
					}else {
						transaction.setAutoCommit(false);
					}
				}
			}
			stmt = transaction.createStatement();
			stmt.setQueryTimeout(queryTimeOut);
			value = stmt.executeUpdate( update );
			if(pool){ 
				transaction.commit(); //commiting single transaction explicitly
				close(transaction);
			}
		}catch(java.sql.SQLException e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExceuteUpdate: " + update,e);
			throw e;
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.error("SqlReader ExceuteUpdate General Exception: " + update,e);
			return -1;
		}finally{
			try{
				CyberoamLogger.connectionPoolLog.debug("Closing statement in executeUpdateSingleStatement");
				stmt.close();
			}catch(Exception e){
				CyberoamLogger.connectionPoolLog.info("Error in closing statement in executeUpdateSingleStatement: ", e);
			}
		}
		return value;
	}
	
	/**
	 * Executes Update stored procedure.
	 */
	public int executeStoredProcedureUpdate(String storedProcedure,int queryTimeOut){
		int updateCount= -1;
		CallableStatement cstatement= null;
		Connection  con= null;
		ResultSet resultSet = null;
		try{
			if (pool){
				con = getConnection();
			}else{
				if (transaction == null || transaction.isClosed()){
					con = transaction = getConnection();
					con.setAutoCommit(false);
				}else{
					con = transaction;
				}
			}
			if(ConnectionPool.isPostgreSql){
				con.setAutoCommit(true);
			}
			cstatement = con.prepareCall(storedProcedure);
			cstatement.setQueryTimeout(queryTimeOut);
			boolean isResult = cstatement.execute(storedProcedure);              // execute this statement, will return true if first result is a result set
			if(pool){ 
				con.commit(); //commiting single transaction explicitly
				close(con);
			}
			if(!isResult){// if it's a result set
				updateCount = cstatement.getUpdateCount();   // update count or -1 if we're done
				return updateCount;
			}
			return updateCount;
		}catch(SQLException sqlEx){
			CyberoamLogger.connectionPoolLog.error("Error in storedprocedure: " + storedProcedure,sqlEx);
			return -1;
		}catch(java.lang.NullPointerException e){
			CyberoamLogger.connectionPoolLog.error("Error in storedprocedure: " + storedProcedure,e);
			return -1;
		}
	}	

	/**
	 * This method is used to set auto commit of SQL transactions.
	 * Do not call this method in the middle of a transaction 
	 * as this will cause a commit default ( infact a commit is called )
	 * Hence call this method only in the 
	 * begining/end of some operation.
	*/
	public void setAutoCommit(boolean flag){
		try{
			if (flag == false){
				pool = false;
			}else{
				if (transaction != null){
					if(ConnectionPool.isPostgreSql){
						transaction.setAutoCommit(true);
					}else {
						transaction.setAutoCommit(false);
					}
					
					close(transaction);
					transaction = null;
				}
				pool = true;
			}
		}catch(SQLException e){
			CyberoamLogger.connectionPoolLog.error(getClass()+"Error occured in commit",e);
		}
	}

	/**
	 * This method is used to roll back SQL transaction.
	 */
	public void rollback(){
		CyberoamLogger.connectionPoolLog.debug("ROLLBACK CALLED: ");
		try{
			CyberoamLogger.connectionPoolLog.debug("Using OLD OLD Connection for rollback: " + transaction + ":autocommit: " + transaction.getAutoCommit());
			if(transaction!=null){
				transaction.rollback();
			}
		}catch(SQLException e){
			CyberoamLogger.connectionPoolLog.error(getClass()+"Error occured in rollback ",e);
		}
	}
	
	/**
	 * This method is used to commit SQL transactions.
	 * Here we are giving the connection back to the pool and
	 * making the connection variable null,
	 * hence when he comes the next time we know that he
	 * needs auto commit hence we will get a transaction then only.
	 * This will allow the connection to be pooled in the true sense.
	 */
	public void commit() throws SQLException{
		try{
			if(transaction!=null){
				transaction.commit();
			}
		}catch(SQLException e){
			throw e;
		}
	}

	/**
	 * This method is used to get next date based on given counter.
	 * @param part
	 * @param counter
	 * @return
	 */
	//keep this method in a utility class
	public static String getNextDate(int part,int counter){
		String date = "";
		String sql;
		sql = "SELECT CONVERT(char(12), DATEADD(MM,"+counter+", GETDATE()), 103) date";
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try	{
			con = ConnectionManager.getSharedInstance().getConnection();
			if(ConnectionPool.isPostgreSql){
				con.setAutoCommit(true);
			}
			stmt = con.createStatement();
			stmt.setQueryTimeout(10);
			rs = stmt.executeQuery( sql );
			rs.next();
			date = rs.getString(1);
		}catch(java.sql.SQLException e){
			CyberoamLogger.connectionPoolLog.error(sql);
			CyberoamLogger.connectionPoolLog.error("\nError in getting date:\n", e);
		}catch(java.lang.NullPointerException ex){}
		finally{
			if (rs != null){
				try {rs.close();}catch(java.sql.SQLException e1){}
			}
			if (stmt != null){
				try {stmt.close();}catch(java.sql.SQLException e1){}
			}
			if (con != null){
				ConnectionManager.getSharedInstance().close(con);
			}
		}
		return date;
	}
	/**
	 * This method executes stored procedure and gets result into ArrayList.
	 */
	public ArrayList executeStoredProcedureQuery(String storedProcedure,int queryTimeOut)
	{
		CallableStatement cstatement= null;
		Connection  con= null;
		ResultSet resultSet = null;
		try
		{
			con = getConnection();
			if(ConnectionPool.isPostgreSql){
				con.setAutoCommit(true);
			}
			cstatement = con.prepareCall(storedProcedure);
			cstatement.setQueryTimeout(queryTimeOut);
			boolean isResult = cstatement.execute(storedProcedure);              // execute this statement, will return true if first result is a result set
	
			if(isResult){
				resultSet = cstatement.getResultSet(); // get current result set
				ArrayList v = convertToArrayList (resultSet);
				return v;
			}else{// could be an update count or we could be done
				int updateCount = cstatement.getUpdateCount();   // update count or -1 if we're done
				if(updateCount != -1)                           // if this is an update count
				{
					return new ArrayList();
				}
				return null;
			}
		}catch(SQLException sqlEx){
			// catch problems here
			CyberoamLogger.connectionPoolLog.error("\nError in executing storedProcedure:\n");
			CyberoamLogger.connectionPoolLog.error(storedProcedure,sqlEx);
			return null;
		}catch(java.lang.NullPointerException e){
			CyberoamLogger.connectionPoolLog.error("\nError in executing storedProcedure:\n");
			CyberoamLogger.connectionPoolLog.error(storedProcedure,e);
			return null;
		}finally{
			try{
				if (resultSet !=  null)resultSet.close();
			}catch(java.sql.SQLException e){}
			try{
				if (cstatement !=  null)cstatement.close();
			}catch(java.sql.SQLException e){}
			close(con);
		}
	}
	/**
	 * This method is used to convert result set wrapper to ArrayList.
	 * @param rs
	 * @return
	 */
	public static ArrayList convertToArrayList(ResultSet rs){
		ArrayList rows = new ArrayList();
		try{
			ResultSetMetaData rsmd = rs.getMetaData();
			int numberOfCol = rsmd.getColumnCount();
			while(rs.next()){
				ArrayList colus = new ArrayList();
				Object temp;
				for( int i=1;i<=numberOfCol; i++){
					temp = (rs.getObject(i));
					if (rs.wasNull()){
						switch(rsmd.getColumnType(i)){
						case java.sql.Types.DECIMAL:
							temp = new java.math.BigDecimal(0.0);
							break;
						case java.sql.Types.NUMERIC: //small money 2
							temp = new java.math.BigDecimal(0.0);
							break;
						case java.sql.Types.BIGINT:
							temp = new java.math.BigDecimal(0.0);
							break;
						case java.sql.Types.INTEGER:
							temp = new Integer(0);
							break;
						case java.sql.Types.SMALLINT:
							temp = new Integer(0);
							break;
						case java.sql.Types.TINYINT:
							temp = new Integer(0);
							break;
						case java.sql.Types.FLOAT:
							break;
						case java.sql.Types.REAL:
							temp = new Float(0.0);
							break;
						case java.sql.Types.CHAR:
							break;
						case java.sql.Types.VARCHAR:
							break;
						case java.sql.Types.LONGVARCHAR:
							temp = " ";
							break;
						case java.sql.Types.DATE:
							temp = " ";
							break;
						}
					}
					colus.add(temp);
				}
				colus.trimToSize();
				rows.add(colus);
			}

		}catch(Exception se){
			CyberoamLogger.connectionPoolLog.debug("Returning ArrayList Exception: ",se);
			return null;
		}
		rows.trimToSize(); //this will trim the ArrayList
		return rows;
	}
	/**
	 * Used to debug given message. 
	 * @param message
	 */
	private void trace(String message){
		if (DEBUG){
			CyberoamLogger.connectionPoolLog.debug(message);
		}
	}
	/**
	 * Closes all connections.
	 */
	protected void finalize(){
		try{
			if(!this.connectionClosed){
				this.close();
			}
		}catch(Exception e){
		}
	}
}
