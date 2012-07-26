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
import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Array;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Ref;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Map;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.helper.ConnectionManager;



/**
 * This wrapper class is used to manage result sets obtained as a result of execution of database queries.
 * @author Cyberoam
 *
 */
public class ResultSetWrapper {
	public Connection connection = null; 
	private Statement statement = null;
	private ResultSet resultSet = null;
	private boolean update = false;
	private int resultCount = -1;
	  
	private long createTime = 0;
	
	private boolean closeConnection = false;
	
	/**
	 * Take care to close the ResultSetWrapper
	 * Otherwise it will create garbage collection problems.
	 */	

	 
	//Sarting of Methods having blank created by Muliya Paresh 13, Feb 2007

	public void updateBlob(int columnIndex,Blob x) throws SQLException
	{}

	public void updateArray(String columnName,Array x) throws SQLException
	{}

	public void updateRef(int columnIndex,Ref x) throws SQLException
	{}

	public void updateClob(String columnName,Clob x) throws SQLException
	{}

	public void updateArray(int columnIndex,Array x) throws SQLException
	{}

	public void updateBlob(String columnName,Blob x) throws SQLException
	{}

	public void updateRef(String columnName,Ref x) throws SQLException
	{}

	public void updateClob(int columnIndex,Clob x) throws SQLException
	{}
	
	public URL getURL(int columnIndex) throws SQLException
	{
		URL temp = null;
		try
		{
			temp = new URL("xyz");	
		}
		catch (Exception e)
		{
			CyberoamLogger.appLog.error("Exception in ResultSetWrapper->getURL() : "+e);
		}
		return temp;
	}

	public URL getURL(String columnName) throws SQLException
	{
		URL temp = null;
		try
		{
			temp = new URL("xyz");	
		}
		catch (Exception e)
		{
			CyberoamLogger.appLog.error("Exception in ResultSetWrapper->getURL() : "+e);
		}
		return temp;
	}
	//Ending of Methods having blank created by Muliya Paresh 13, Feb 2007
	/**
	 * This constructor is used to create result set wrapper and execute given query and maintain its result set.
	 */
	public ResultSetWrapper(String query)	
		throws java.sql.SQLException,java.lang.NullPointerException{
		CyberoamLogger.sqlLog.debug("select query:"+query);
		connection = ConnectionManager.getSharedInstance().getConnection();
		try{
			statement = connection.createStatement();
			statement.setQueryTimeout(300);
			resultSet = statement.executeQuery( query );
		}catch(Exception e){
			CyberoamLogger.connectionPoolLog.error("EXCEPTION IN RESULTSET WRAPPER WHILE EXECUTING QUERY: " + e,e);
			ConnectionManager.getSharedInstance().close(connection);
			throw new SQLException();
		}
		createTime = System.currentTimeMillis();
		closeConnection = true;
		CyberoamLogger.connectionPoolLog.debug("Creating ResultSetWrapper: " + createTime + " " + this.connection);
	}

	/**
	 * This constructor is used to create result set wrapper using given entities of {@link Connection}, {@link Statement} and {@link ResultSet}.
	 * @param connection
	 * @param statement
	 * @param resultSet
	 */
	public ResultSetWrapper(Connection connection,
							Statement statement,
							ResultSet resultSet){
		this.connection = connection;
		this.statement = statement;
		this.resultSet = resultSet;
		update = false;
		resultCount = -1;
		createTime = System.currentTimeMillis();
		closeConnection = false;
		CyberoamLogger.connectionPoolLog.debug("Creating ResultSetWrapper: " + createTime + " " + this.connection);
	}
	
	/**
	 * This constructor is used to create result set wrapper using given entities of {@link ResultSet}.
	 * @param resultSet
	 */
	
	public ResultSetWrapper(ResultSet resultSet){		
		this.resultSet = resultSet;
		update = false;
		resultCount = -1;
		createTime = System.currentTimeMillis();
		closeConnection = false;
		CyberoamLogger.connectionPoolLog.debug("Creating ResultSetWrapper: " + createTime + " " + this.connection);
	}

	/**
	 * This constructor is used to create result set wrapper using given entities of {@link Connection}, {@link Statement} and {@link ResultSet}.
	 * This also initializes isUpdate flag and result count.
	 * @param connection
	 * @param statement
	 * @param resultSet
	 * @param isUpdate
	 * @param resultCount
	 */
	public ResultSetWrapper(Connection connection,
							Statement statement,
							ResultSet resultSet,
							boolean isUpdate,
							int resultCount){
		this.connection = connection;
		this.statement = statement;
		this.resultSet = resultSet;
		this.update = isUpdate;
		this.resultCount = resultCount;
		closeConnection = false;
	}

	/**
	 * Returns isUpdate flag.
	 */
	public boolean isUpdateResult(){
		return update;
	}
	
	/**
	 * Returns contained result set.
	 * @return
	 */
	public ResultSet getResultSet(){
		return resultSet;
	}
	
	/**
	 * Returns result set count.
	 * @return
	 */
	public int getResultCount(){
		return resultCount;
	}
	
	/**
	 * Returns string representation of result set wrapper. 
	 */
	public String toString(){
		return connection.toString()+ ":" + createTime;
	}
	/**
	 * Checks that next record is available or not.
	 */
	public boolean next() throws SQLException {
		return resultSet.next();
	}
	/**
	 * Closes result set.
	 * @throws SQLException
	 */
	public void closeResultSet() throws SQLException{
		resultSet.close();
	}
	/**
	 * Checks whether result set was null or not.
	 */
	public boolean wasNull()
	throws SQLException{
		return resultSet.wasNull();
	}
	/**
	 * Returns string from result set based on column index.
	 */
	public String getString(int columnIndex)throws SQLException{
		return resultSet.getString(columnIndex);
	}
	/**
	 * Returns boolean value from result set based on column index.
	 */
	public boolean getBoolean(int columnIndex)throws SQLException{
		return resultSet.getBoolean(columnIndex);
	}
	/**
	 * Returns byte from result set based on column index.
	 */
	public byte getByte(int columnIndex)throws SQLException{
		return resultSet.getByte(columnIndex);
	}
	/**
	 * Returns short value from result set based on column index.
	 */
	public short getShort(int columnIndex)throws SQLException{
		return resultSet.getShort(columnIndex);
	}
	/**
	 * Returns integer from result set based on column index.
	 */
	public int getInt(int columnIndex)throws SQLException{
		return resultSet.getInt(columnIndex);
	}
	/**
	 * Returns long value from result set based on column index.
	 */
	public long getLong(int columnIndex) throws SQLException{
		return resultSet.getLong(columnIndex);
	}
	/**
	 * Returns float value from result set based on column index.
	 */
	public float getFloat(int columnIndex)throws SQLException{
		return resultSet.getFloat(columnIndex);
	}
	/**
	 * Returns double value from result set based on column index.
	 */
	public double getDouble(int columnIndex) throws SQLException{
		return resultSet.getDouble(columnIndex);
	}
	/**
	 * Returns big decimal value from result set based on column index and scale.
	 */
	public BigDecimal getBigDecimal(int columnIndex,int scale)throws SQLException{
		return resultSet.getBigDecimal(columnIndex,scale);
	}
	/**
	 * Returns array of bytes from result set based on column index.
	 */
	public byte[] getBytes(int columnIndex)throws SQLException{
		return resultSet.getBytes(columnIndex);
	}
	/**
	 * Returns instance of {@link Date} from result set based on column index.
	 */
	public Date getDate(int columnIndex)throws SQLException{
		return resultSet.getDate(columnIndex);
	}
	/**
	 * Returns instance of {@link Time} from result set based on column index. 
	 */
	public Time getTime(int columnIndex)
		throws SQLException{
		return resultSet.getTime(columnIndex);
	}
	/**
	 * Returns instance of {@link Timestamp} from result set based on column index.
	 */
	public Timestamp getTimestamp(int columnIndex)
		throws SQLException{
		return resultSet.getTimestamp(columnIndex);
	}
	/**
	 * Returns ASCII {@link InputStream} from result set based on column index.
	 */
	public InputStream getAsciiStream(int columnIndex)
		throws SQLException{
		return resultSet.getAsciiStream(columnIndex);	
	}
	/**
	 * Returns Unicode {@link InputStream} from result set based on column index.
	 */
	public InputStream getUnicodeStream(int columnIndex)
		throws SQLException{
		return resultSet.getUnicodeStream(columnIndex);
	}
	/**
	 * Returns Binary {@link InputStream} from result set based on column index.
	 */
	public InputStream getBinaryStream(int columnIndex)
		throws SQLException{
		return resultSet.getBinaryStream(columnIndex);
	}
	/**
	 * Returns string from result set based on database column name.
	 */
	public String getString(String columnName)
		throws SQLException{
		return resultSet.getString(columnName);
	}
	/**
	 * Returns boolean value from result set based on database column name.
	 */
	public boolean getBoolean(String columnName)
		throws SQLException{
		return resultSet.getBoolean(columnName);
	}
	/**
	 * Returns byte from result set based on database column name.
	 */
	public byte getByte(String columnName)
		throws SQLException{
		return resultSet.getByte(columnName);
	}
	/**
	 * Returns short value from result set based on database column name.
	 */
	public short getShort(String columnName)
		throws SQLException{
		return resultSet.getShort(columnName);
	}
	/**
	 * Returns integer from result set based on database column name.
	 */
	public int getInt(String columnName)
		throws SQLException{
		return resultSet.getInt(columnName);
	}
	/**
	 * Returns long value from result set based on database column name.
	 */
	public long getLong(String columnName)
		throws SQLException{
		return resultSet.getLong(columnName);
	}
	/**
	 * Returns float value from result set based on database column name.
	 */
	public float getFloat(String columnName)
		throws SQLException{
		return resultSet.getFloat(columnName);
	}
	/**
	 * Returns double value from result set based on database column name.
	 */
	public double getDouble(String columnName)
		throws SQLException{
		return resultSet.getDouble(columnName);
	}
	/**
	 * Returns big decimal value from result set based on database column name and scale.
	 */
	public BigDecimal getBigDecimal(String columnName,int scale)
		throws SQLException{
		return resultSet.getBigDecimal(columnName,scale);
	}
	/**
	 * Returns array of bytes from result set based on database column name.
	 */
	public byte[] getBytes(String columnName)
		throws SQLException{
		return resultSet.getBytes(columnName);
	}
	/**
	 * Returns instance of {@link Date} from result set based on database column name.
	 */
	public Date getDate(String columnName)
		throws SQLException{
		return resultSet.getDate(columnName);
	}
	/**
	 * Returns instance of {@link Time} from result set based on database column name.
	 */
	public Time getTime(String columnName)
		throws SQLException{
		return resultSet.getTime(columnName);
	}
	/**
	 * Returns instance of {@link Timestamp} from result set based on database column name.
	 */
	public Timestamp getTimestamp(String columnName)
		throws SQLException{
		return resultSet.getTimestamp(columnName);
	}
	/**
	 * Returns ASCII {@link InputStream} from result set based on database column name.
	 */
	public InputStream getAsciiStream(String columnName)
		throws SQLException{
		return resultSet.getAsciiStream(columnName);
	}
	/**
	 * Returns Unicode {@link InputStream} from result set based on database column name.
	 */
	public InputStream getUnicodeStream(String columnName)
		throws SQLException{
		return resultSet.getUnicodeStream(columnName);
	}
	/**
	 * Returns Binary {@link InputStream} from result set based on database column name.
	 */
	public InputStream getBinaryStream(String columnName)
		throws SQLException{
		return resultSet.getBinaryStream(columnName);
	}
	/**
	 * Returns warning received from database.
	 */
	public SQLWarning getWarnings()
		throws SQLException{
		return resultSet.getWarnings();
	}
	/**
	 * Clears all warnings.
	 */
	public void clearWarnings()
		throws SQLException{
		resultSet.clearWarnings();
	}
	/**
	 * Returns cursor name used in database.
	 */
	public String getCursorName()
		throws SQLException{
		return resultSet.getCursorName();
	}
	/**
	 * Returns meta data of result set.
	 */
	public ResultSetMetaData getMetaData()
		throws SQLException{
		return resultSet.getMetaData();
	}
	/**
	 * Returns object based on column index.
	 */
	public Object getObject(int columnIndex)
		throws SQLException{
		return resultSet.getObject(columnIndex);
	}
	/**
	 * Returns object based on database column name.
	 */
	public Object getObject(String columnName)
		throws SQLException{
		return resultSet.getObject(columnName);
	}
	/**
	 * Returns number of column based on database column name. 
	 */
	public int findColumn(String columnName)
		throws SQLException{
		return resultSet.findColumn(columnName);
	}

	/**
	 * This method closes connection.
	 */
	public void close(){
		try {
			if(resultSet != null){
				resultSet.close();
				resultSet = null;
			}
			if(statement != null){
				statement.close();
				statement = null;
			}
			if(closeConnection == true && connection !=null){
				ConnectionManager.getSharedInstance().close(connection);
				closeConnection = false;
			}
		}catch (Exception e) {
			CyberoamLogger.connectionPoolLog.debug("ResultSetWrappter.close():"+e,e);
		}
	}
	
	/**
	 * This method closes all connections.
	 * @throws SQLException
	 */
	public void closeAll()	throws SQLException{
		if(resultSet != null){
			resultSet.close();
			resultSet = null;
		}
		if(statement != null){
			statement.close();
			statement = null;
		}
		if(this.closeConnection == true &&  connection != null ){
			ConnectionManager.getSharedInstance().close(connection);
		}
//		CyberoamLogger.connectionPoolLog.debug("CLOSING THE CONNECTION RSW this.close: " + this);
	}
	/**
	 * Returns character stream from result set based on column index.
	 */
	public Reader getCharacterStream(int columnIndex)throws SQLException{
		return resultSet.getCharacterStream(columnIndex);
	}
	/**
	 * Returns character stream from result set based on database column name.
	 */
	public Reader getCharacterStream(String columnName)throws SQLException{
		return resultSet.getCharacterStream(columnName);
	}
	/**
	 * Returns {@link BigDecimal} from result set based on column index.
	 */
	public BigDecimal getBigDecimal(int columnIndex)throws SQLException{
		return resultSet.getBigDecimal(columnIndex);
	}
	/**
	 * Returns {@link BigDecimal} from result set based on database column name.
	 */
	public BigDecimal getBigDecimal(String columnName)throws SQLException{
		return resultSet.getBigDecimal(columnName);
	}
	/**
	 * Checks whether cursor is before the first record or not.
	 */
	public boolean isBeforeFirst()throws SQLException{
		return resultSet.isBeforeFirst();
	}
	/**
	 * Checks whether cursor is after the last record or not.
	 */
	public boolean isAfterLast()throws SQLException{
		return resultSet.isAfterLast();
	}
	/**
	 * Checks whether cursor is at first record or not.
	 */
	public boolean isFirst()throws SQLException{
		return resultSet.isFirst();
	}
	/**
	 * Checks whether cursor is at last record or not.
	 */
	public boolean isLast()throws SQLException{
		return resultSet.isLast();
	}
	/**
	 * Sets result set cursor before first record.
	 */
	public void beforeFirst()throws SQLException{
		resultSet.beforeFirst();
	}
	/**
	 * Sets result set cursor after last record.
	 */
	public void afterLast()throws SQLException{
		resultSet.afterLast();
	}
	/**
	 * Sets result set cursor at first record.
	 */
	public boolean first()throws SQLException{
		return resultSet.first();
	}
	/**
	 * Sets result set cursor at last record.
	 */
	public boolean last()throws SQLException{
		return resultSet.last();
	}
	/**
	 * Returns row from current position of cursor.
	 */
	public int getRow()throws SQLException{
		return resultSet.getRow();
	}
	/**
	 * Returns row from starting position of cursor.
	 */
	public boolean absolute(int row)throws SQLException{
		return resultSet.absolute(row);
	}
	/**
	 * Returns row from current position of cursor.
	 */
	public boolean relative(int rows)throws SQLException{
		return resultSet.relative(rows);
	}
	/**
	 * Checks that previous record is available or not.
	 */
	public boolean previous()throws SQLException{
		return resultSet.previous();
	}
	/**
	 * Sets result set direction.
	 */
	public void setFetchDirection(int direction)throws SQLException{
		resultSet.setFetchDirection(direction);
	}
	/**
	 * Returns result set direction.
	 */
	public int getFetchDirection()throws SQLException{
		return resultSet.getFetchDirection();
	}
	/**
	 * Sets result set record fetch size.
	 */
	public void setFetchSize(int rows)throws SQLException{
		resultSet.setFetchSize(rows);
	}
	/**
	 * Returns result set record fetch size.
	 */
	public int getFetchSize()throws SQLException{
		return resultSet.getFetchSize();
	}
	/**
	 * Returns type of result set field.
	 */
	public int getType()throws SQLException{
		return resultSet.getType();
	}
	/**
	 * Retrieves the concurrency mode of this ResultSet object.
	 */
	public int getConcurrency()throws SQLException{
		return resultSet.getConcurrency();
	}
	/**
	 * Retrieves whether the current row has been updated.
	 */
	public boolean rowUpdated()throws SQLException{
		return resultSet.rowUpdated();
	}
	/**
	 * Retrieves whether the current row has had an insertion.
	 */
	public boolean rowInserted()throws SQLException{
		return resultSet.rowInserted();
	}
	/**
	 * Retrieves whether a row has been deleted. 
	 */
	public boolean rowDeleted()throws SQLException{
		return resultSet.rowDeleted();
	}
	/**
	 * Gives a nullable column a null value.
	 */
	public void updateNull(int columnIndex)throws SQLException{
		resultSet.updateNull(columnIndex);
	}
	/**
	 * Updates the designated column with a boolean value.
	 */
	public void updateBoolean(int columnIndex,boolean x)throws SQLException	{
		resultSet.updateBoolean(columnIndex,x);
	}
	/**
	 * Updates the designated column with a byte value.
	 */
	public void updateByte(int columnIndex,byte x)throws SQLException{
		resultSet.updateByte(columnIndex,x);
	}
	/**
	 * Updates the designated column with a short value.
	 */
	public void updateShort(int columnIndex,short x)throws SQLException{
		resultSet.updateShort(columnIndex,x);
	}
	/**
	 * Updates the designated column with an int value.
	 */
	public void updateInt(int columnIndex,int x)throws SQLException{
		resultSet.updateInt(columnIndex,x);
	}
	/**
	 * Updates the designated column with a long value.
	 */
	public void updateLong(int columnIndex,long x)throws SQLException{
		resultSet.updateLong(columnIndex,x);
	}
	/**
	 * Updates the designated column with a float value.
	 */
	public void updateFloat(int columnIndex,float x)throws SQLException{
		resultSet.updateFloat(columnIndex,x);
	}
	/**
	 * Updates the designated column with a double value.
	 */
	public void updateDouble(int columnIndex,double x)throws SQLException{
		resultSet.updateDouble(columnIndex,x);
	}
	/**
	 * Updates the designated column with a java.math.BigDecimal value.
	 */
	public void updateBigDecimal(int columnIndex,BigDecimal x)throws SQLException{
		resultSet.updateBigDecimal(columnIndex,x);
	}
	/**
	 * Updates the designated column with a String value.
	 */
	public void updateString(int columnIndex,String x)throws SQLException{
		resultSet.updateString(columnIndex,x);
	}
	/**
	 * Updates the designated column with a byte array value.
	 */
	public void updateBytes(int columnIndex,byte[] x)throws SQLException{
		resultSet.updateBytes(columnIndex,x);
	}
	/**
	 * Updates the designated column with a java.sql.Date value.
	 */
	public void updateDate(int columnIndex,Date x)throws SQLException{
		resultSet.updateDate(columnIndex,x);
	}
	/**
	 * Updates the designated column with a java.sql.Time value.
	 */
	public void updateTime(int columnIndex,Time x)throws SQLException{
		resultSet.updateTime(columnIndex,x);
	}
	/**
	 * Updates the designated column with a java.sql.Timestamp value.
	 */
	public void updateTimestamp(int columnIndex,Timestamp x)throws SQLException{
		resultSet.updateTimestamp(columnIndex,x);
	}
	/**
	 * Updates the designated column with an ascii stream value.
	 */
	public void updateAsciiStream(int columnIndex,InputStream x,int length)throws SQLException{
		resultSet.updateAsciiStream(columnIndex,x,length);
	}
	/**
	 * Updates the designated column with a binary stream value.
	 */
	public void updateBinaryStream(int columnIndex,InputStream x,int length)throws SQLException{
		resultSet.updateBinaryStream(columnIndex,x,length);
	}
	/**
	 * Updates the designated column with a character stream value.
	 */
	public void updateCharacterStream(int columnIndex,Reader x,int length)throws SQLException{
		resultSet.updateCharacterStream(columnIndex,x,length);
	}
	/**
	 * Updates the designated column with an Object value.
	 */
	public void updateObject(int columnIndex,Object x,int scale)throws SQLException{
		resultSet.updateObject(columnIndex,x,scale);
	}
	/**
	 * Updates the designated column with an Object value.
	 */
	public void updateObject(int columnIndex,Object x)throws SQLException{
		resultSet.updateObject(columnIndex,x);
	}
	/**
	 * Updates the designated column with a null value.
	 */
	public void updateNull(String columnName)throws SQLException{
		resultSet.updateNull(columnName);
	}
	/**
	 * Updates the designated column with a boolean value.
	 */
	public void updateBoolean(String columnName,boolean x)throws SQLException{
		resultSet.updateBoolean(columnName,x);
	}
	/**
	 * Updates the designated column with a byte value.
	 */
	public void updateByte(String columnName,byte x)throws SQLException{
		resultSet.updateByte(columnName,x);
	}
	/**
	 * Updates the designated column with a short value.
	 */
	public void updateShort(String columnName,short x)throws SQLException{
		resultSet.updateShort(columnName,x);
	}
	/**
	 * Updates the designated column with an int value.
	 */
	public void updateInt(String columnName,int x)throws SQLException{
		resultSet.updateInt(columnName,x);
	}
	/**
	 * Updates the designated column with a long value.
	 */
	public void updateLong(String columnName,long x)throws SQLException{
		resultSet.updateLong(columnName,x);
	}
	/**
	 * Updates the designated column with a float value.
	 */
	public void updateFloat(String columnName,float x)throws SQLException{
		resultSet.updateFloat(columnName,x);
	}
	/**
	 * Updates the designated column with a double value.
	 */
	public void updateDouble(String columnName,double x)throws SQLException{
		resultSet.updateDouble(columnName,x);
	}
	/**
	 * Updates the designated column with a java.sql.BigDecimal value.
	 */
	public void updateBigDecimal(String columnName,BigDecimal x)throws SQLException{
		resultSet.updateBigDecimal(columnName,x);
	}
	/**
	 * Updates the designated column with a String value.
	 */
	public void updateString(String columnName,String x)throws SQLException{
		resultSet.updateString(columnName,x);
	}
	/**
	 * Updates the designated column with a byte array value.
	 */
	public void updateBytes(String columnName,byte[] x)throws SQLException{
		resultSet.updateBytes(columnName,x);
	}
	/**
	 * Updates the designated column with a java.sql.Date value.
	 */
	public void updateDate(String columnName,Date x)throws SQLException{
		resultSet.updateDate(columnName,x);
	}
	/**
	 * Updates the designated column with a java.sql.Time value.
	 */
	public void updateTime(String columnName,Time x)throws SQLException{
		resultSet.updateTime(columnName,x);
	}
	/**
	 * Updates the designated column with a java.sql.Timestamp value.
	 */
	public void updateTimestamp(String columnName,Timestamp x)throws SQLException{
		resultSet.updateTimestamp(columnName,x);
	}
	/**
	 * Updates the designated column with a java.sql.Timestamp  value.
	 */
	public void updateAsciiStream(String columnName,InputStream x,int length)throws SQLException{
		resultSet.updateAsciiStream(columnName,x,length);
	}
	/**
	 * Updates the designated column with an ascii stream value.
	 */
	public void updateBinaryStream(String columnName,InputStream x,int length)throws SQLException{
		resultSet.updateBinaryStream(columnName,x,length);
	}
	/**
	 * Updates the designated column with a binary stream value.
	 */
	public void updateCharacterStream(String columnName,Reader reader,int length)throws SQLException{
		resultSet.updateCharacterStream(columnName,reader,length);
	}
	/**
	 * Updates the designated column with a character stream value.
	 */
	public void updateObject(String columnName,Object x,int scale)throws SQLException{
		resultSet.updateObject(columnName,x,scale);
	}
	/**
	 * Updates the designated column with an Object value.
	 */
	public void updateObject(String columnName,Object x)throws SQLException{
		resultSet.updateObject(columnName,x);
	}
	/**
	 * Updates the designated column with an Object value.
	 */
	public void insertRow()throws SQLException{
		resultSet.updateRow();
	}
	/**
	 * Inserts the contents of the insert row into this ResultSet object and into the database.
	 */
	public void updateRow()throws SQLException{
		resultSet.updateRow();
	}
	/**
	 * Updates the underlying database with the new contents of the current row of this ResultSet object.
	 */
	public void deleteRow()throws SQLException{
		resultSet.deleteRow();
	}
	/**
	 * Deletes the current row from this ResultSet object and from the underlying database.
	 */
	public void refreshRow()throws SQLException{
		resultSet.refreshRow();
	}
	/**
	 * Refreshes the current row with its most recent value in the database.
	 */
	public void cancelRowUpdates()throws SQLException{
		resultSet.cancelRowUpdates();
	}
	/**
	 * Cancels the updates made to the current row in this ResultSet object.
	 */
	public void moveToInsertRow()throws SQLException{
		resultSet.moveToInsertRow();
	}
	/**
	 * Moves the cursor to the insert row.
	 */
	public void moveToCurrentRow()throws SQLException{
		resultSet.moveToCurrentRow();
	}
	/**
	 * Moves the cursor to the remembered cursor position, usually the current row.
	 */
	public Statement getStatement()throws SQLException{
			return resultSet.getStatement();
	}
	/**
	 * Retrieves the Statement object that produced this ResultSet object.
	 */
	public Object getObject(int i,Map map)throws SQLException{
			return resultSet.getObject(i,map);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as an Object  in the Java programming language.
	 */
	public Ref getRef(int i)throws SQLException{
			return resultSet.getRef(i);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Ref object in the Java programming language.
	 */
	public Blob getBlob(int i)throws SQLException{
			return resultSet.getBlob(i);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Blob object in the Java programming language.
	 */
	public Clob getClob(int i)throws SQLException{
			return resultSet.getClob(i);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Clob object in the Java programming language.
	 */
	public Array getArray(int i)throws SQLException{
			return resultSet.getArray(i);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as an Array object in the Java programming language.
	 */
	public Object getObject(String colName,Map map)throws SQLException{
			return resultSet.getObject(colName,map);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as an Object  in the Java programming language.
	 */
	public Ref getRef(String colName)throws SQLException{
			return resultSet.getRef(colName);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Ref object in the Java programming language.
	 */
	public Blob getBlob(String colName)throws SQLException{
			return resultSet.getBlob(colName);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Blob object in the Java programming language.
	 */
	public Clob getClob(String colName)throws SQLException{
			return resultSet.getClob(colName);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a Clob object in the Java programming language.
	 */
	public Array getArray(String colName)throws SQLException{
			return resultSet.getArray(colName);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as an Array object in the Java programming language.
	 */
	public Date getDate(int columnIndex,Calendar cal)throws SQLException{
			return resultSet.getDate(columnIndex,cal);
	}
	/**
	 *  Retrieves the value of the designated column in the current row of this ResultSet object as a java.sql.Date object in the Java programming language.
	 */
	public Date getDate(String columnName,Calendar cal)throws SQLException{
			return resultSet.getDate(columnName,cal);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a java.sql.Date object in the Java programming language.
	 */
	public Time getTime(int columnIndex,Calendar cal)throws SQLException{
			return resultSet.getTime(columnIndex,cal);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a java.sql.Time object in the Java programming language.
	 */
	public Time getTime(String columnName,Calendar cal)throws SQLException{
			return resultSet.getTime(columnName,cal);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a 
	 * java.sql.Time object in the Java programming language.
	 */
	public Timestamp getTimestamp(int columnIndex,Calendar cal)throws SQLException{
			return resultSet.getTimestamp(columnIndex,cal);
	}
	/**
	 * Retrieves the value of the designated column in the current row of this ResultSet object as a 
	 * java.sql.Timestamp object in the Java programming language.
	 */
	public Timestamp getTimestamp(String columnName,Calendar cal)throws SQLException{
			return resultSet.getTimestamp(columnName,cal);
	}
	/**
	 * To close all allocated instances in this entity.
	 */
	protected void finalize(){
		try{
//			CyberoamLogger.connectionPoolLog.debug("finalize CLOSING THE CONNECTION RSW: " + createTime);
			this.closeAll();			
		}catch(Exception e){
		}
	}
}
