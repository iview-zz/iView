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

package org.cyberoam.iview.beans;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.IViewPropertyReader;
import org.cyberoam.iviewdb.helper.ConnectionPool;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This bean handle all index file information.
 * index file information will be We stored in table named tblfilelist.
 * @author Narendra Shah
 */

public class FileHandlerBean {
	private int fileID;
	private String fileName;
	private String filecreationtimestamp;
	private String fileeventtimestamp;
	private long fileSize;
	private int isLoaded ;
	private String appID;
	private String lastAccessTimeStamp;

	/**
	 * Returns fileId.
	 * @return
	 */
	public int getFileId() {
		return fileID;
	}
	
	/**
	 * Sets fileId.
	 * @return
	 */
	public void setFileId(int fileid) {
		this.fileID = fileid;
	}
	
	/**
	 * Returns file name.
	 */
	public String getFileName() {
		return fileName;
	}
	
	/**
	 * Sets file name.
	 * @param filename
	 */
	public void setFileName(String filename) {
		this.fileName = filename;
	}
	
	/**
	 * Returns file creation time stamp.
	 * @return
	 */
	public String getFileCreationTimestamp() {
		return filecreationtimestamp;
	}
	
	/**
	 * Sets file creation time stamp.
	 * @param filecreationtimestamp
	 */
	public void setFileCreationTimestamp(String filecreationtimestamp) {
		this.filecreationtimestamp = filecreationtimestamp;
	}
	
	/**
	 * Returns file event time stamp.Event time stamp contains time stamp of first event placed into file.
	 * @return
	 */
	public String getFileEventTimestamp() {
		return fileeventtimestamp;
	}
	
	/**
	 * Sets file event time stamp.
	 * @param fileeventtimestamp
	 */
	public void setFileEventTimestamp(String fileeventtimestamp) {
		this.fileeventtimestamp = fileeventtimestamp;
	}
	
	/**
	 * Returns size of file.
	 * @return
	 */
	public long getFileSize() {
		return fileSize;
	}
	
	/**
	 * Sets size of file.
	 * @param filesize
	 */
	public void setFileSize(long filesize) {
		this.fileSize = filesize;
	}
	
	/**
	 * Checks whether file is loaded or not.
	 * @return
	 */
	public int getIsLoaded() {
		return isLoaded;
	}
	
	/**
	 * Sets file isLoaded flag.
	 * @param isloaded
	 */
	public void setIsLoaded(int isloaded) {
		this.isLoaded = isloaded;
	}
	
	/**
	 * Returns last accessed time stamp of this file.
	 * @return
	 */
	public String getLastAccessTimeStamp() {
		return lastAccessTimeStamp;
	}
	
	/**
	 * Sets last accessed time stamp of this file.
	 * @param lastAccessTimeStamp
	 */
	public void setLastAccessTimeStamp(String lastAccessTimeStamp) {
		this.lastAccessTimeStamp = lastAccessTimeStamp;
	}
	
	/**
	 * Returns appliance id for which file is created.
	 * @return
	 */
	public String getAppID() {
		return appID;
	}
	
	/**
	 * Sets appliance id for which file is created.
	 * @param appID
	 */
	public void setAppID(String appID) {
		this.appID = appID;
	}
	
	/**
	* Inserts SQL Record of index file into tblfilelist.
	*/
	public int insertRecord(){		
		int retStatus = 0;
		
		String strQuery=null;
		SqlReader sqlReader = null;
		ResultSetWrapper rsw = null;
		try {			
			sqlReader = new SqlReader(false);
			strQuery = "select insert_tblFileList('" 
			+this.getFileName()+ "','"
			+ this.getFileCreationTimestamp()+ "','"
			+ this.getFileEventTimestamp()+ "',"
			+ this.getFileSize()+ ","
			+ this.getIsLoaded()+ ",'"
			+ this.getLastAccessTimeStamp()+ "','"
			+ this.getAppID() + "');"; 			
			
			rsw = SqlReader.getResultSetWrapper(strQuery);
			if(rsw == null){
				retStatus=-1;
				//CyberoamLogger.appLog.info("FileHandlerBean.insertRecord:: Resultset is null");
			}else {
				retStatus=1;
			}
		}catch (Exception e) {
			CyberoamLogger.appLog.error("FileHandlerBean.insertRecord:Exception : "+ e, e);
			retStatus = -1;
		} finally {
			if(rsw != null ) rsw.close();
			if(sqlReader != null) sqlReader.close();
		}
		CyberoamLogger.appLog.debug("FileHandlerBean.insertRecord:retstatus: " + retStatus);
		return retStatus;
	}
	
	/**
	 * Returns load status of given index file.
	 * It return 1(true) if file is loaded in database else 0(false).
	 */
	public static int getIndexFileLoadStatus(String indexfilename,String tablename){
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		int returnStatus=-1;
		
    	try{
    		sqlReader = new SqlReader(false);
    		strQuery=null;
    		strQuery="select isloaded from "  + tablename + " where filename='"+indexfilename+"';";    		
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		if(rsw.next()){
    			returnStatus=rsw.getInt("isloaded");
    		}
    	}catch(SQLException e){
    		CyberoamLogger.appLog.error("Exception in getIndexFileLoadStatus():FileHandlerBean :"+e,e);
    		returnStatus=-1;
    	}catch(Exception e){
    		CyberoamLogger.appLog.error("Exception in getIndexFileLoadStatus():FileHandlerBean :"+e,e);
    		returnStatus=-1;
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	  }catch(Exception e){}
	    }	 	 
    	return returnStatus;
    }
	
	/**
	 * This method updates status of loaded index files to 1(true). 
	 */
	public static int updateLoadedIndexedFileStatus(String indexfilelist,String tablename,int statusVal){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		
			try {
				strQuery="update "+tablename+" set isloaded="+statusVal+",lastaccesstimestamp=now() where filename in('"+indexfilelist+"');";
				retStatus = sqlReader.executeUpdate(strQuery,1000);
				retStatus=1;
			} catch (SQLException e) {
				CyberoamLogger.appLog.error("Sqlexception->updateLoadedIndexedFileStatus()->FileHandlerBean : "+ e, e);
				retStatus = -1;
			} catch (Exception e) {
				CyberoamLogger.appLog.error("Exception->updateLoadedIndexedFileStatus()->FileHandlerBean : "+ e, e);
				retStatus = -1;
			} finally {
				try {
					sqlReader.close();
				} catch (Exception e) {
				}
			}
		
		return retStatus;
	}
	
	public static int updateLoadedindexFileStatusForDateRange(String whereCriteria, String tableName, int statusVal){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		
			try {
				strQuery="update "+tableName+" set isloaded="+statusVal+",lastaccesstimestamp=now() "+whereCriteria;
				retStatus = sqlReader.executeUpdate(strQuery,1000);
				retStatus=1;
			} catch (SQLException e) {
				CyberoamLogger.appLog.error("Sqlexception->updateLoadedIndexedFileStatus()->FileHandlerBean : "+ e, e);
				retStatus = -1;
			} catch (Exception e) {
				CyberoamLogger.appLog.error("Exception->updateLoadedIndexedFileStatus()->FileHandlerBean : "+ e, e);
				retStatus = -1;
			} finally {
				try {
					sqlReader.close();
				} catch (Exception e) {
				}
			}
			return retStatus;
	}
	
	/**
	 * Function return array list of all index files from requested table which are 
	 * filtered by requested criteria & range of records and  
	 * ordered by creation timestamp and grouped by day.
	 */
	
	public static ArrayList getFileList(String criteria,String limit,String sDate,String eDate){
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ArrayList recordArrayList = null;
		
    	try{    		
    		sqlReader = new SqlReader(false);
    		strQuery=null;
    		if(ConnectionPool.isPostgreSql){
	    		if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
	    			strQuery="select *,from_unixtime(int4(fileeventtimestamp)) as date from select_tblFileList('" + sDate +"',' "+ eDate +"')" + criteria  +" order by date desc "+limit;
	    		}else{
	    			strQuery="select *,from_unixtime(int4(filecreationtimestamp)) as date from select_tblFileList('" + sDate +"',' "+ eDate +"')"+ criteria +limit ;
	    		}
	    		
    		}else {
    			if(IViewPropertyReader.IndexFileTimeStampUsed == 2){
    				strQuery="select *,from_unixtime(fileeventtimestamp) as date from select_tblFileList('" + sDate +"',' "+ eDate +"')"+ criteria +" order by date desc "+limit;
	    		}else{
	    			strQuery="select *,from_unixtime(filecreationtimestamp) as date from select_tblFileList('" + sDate +"',' "+ eDate +"')"+ criteria + " group by date " +limit;
	    		}
    		}
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);    		    		
    		recordArrayList = new ArrayList();
			while(rsw.next()){
				FileHandlerBean fileHandlerBean = FileHandlerBean.getBeanByResultSetWrapper(rsw);
				recordArrayList.add(fileHandlerBean);
	    	}
    	}catch(SQLException e){
    		CyberoamLogger.appLog.error("Exception in getFileList():FileHandlerBean :"+e,e);
    	}catch(Exception e){    		
    		CyberoamLogger.appLog.error("Exception in getFileList():FileHandlerBean :"+e,e);
    	}finally{
    		sqlReader.close();
			rsw.close();
	    }	 	 
    	return recordArrayList;
    }
	/**
	 * Returns instance of {@link FileHandlerBean} by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static FileHandlerBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
    	FileHandlerBean fileHandlerBean = new FileHandlerBean();
    	try {
    		fileHandlerBean.setFileId(rsw.getInt("fileid"));
    		fileHandlerBean.setFileName(rsw.getString("filename").trim());
    		fileHandlerBean.setFileCreationTimestamp(rsw.getString("filecreationtimestamp").trim());
    		fileHandlerBean.setFileEventTimestamp(rsw.getString("fileeventtimestamp").trim());
    		fileHandlerBean.setFileSize(rsw.getInt("filesize"));
    		fileHandlerBean.setIsLoaded(rsw.getInt("isloaded"));
    		fileHandlerBean.setLastAccessTimeStamp(rsw.getString("lastaccesstimestamp"));
    		fileHandlerBean.setAppID(rsw.getString("appid"));
    	}catch(Exception e) {
    		CyberoamLogger.appLog.error("Exception->getBeanByResultSetWrapper()->FileHandlerBean: " + e,e);
    	}
    	return fileHandlerBean;
    }
	

	/**
	 * Returns 1(true) if table with given name exists else returns 0(false).
	 */
	public static int isTableExists(String tablename){
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		int returnStatus=-1;
    	try{
    		sqlReader = new SqlReader(false);
    		strQuery=null;
    		if(ConnectionPool.isPostgreSql){
    			strQuery="select table_name from information_schema.tables where table_schema='public' and table_type='BASE TABLE' and table_name like '" +tablename+"';";
    		}else {
    			strQuery=" show tables like '"  + tablename + "';";
    		}
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		if(rsw.next()){
    			returnStatus=1;
    		}
    	}catch(SQLException e){
    		CyberoamLogger.appLog.error("Exception in getFileList():FileHandlerBean :"+e,e);
    		returnStatus=-1;
    	}catch(Exception e){
    		CyberoamLogger.appLog.error("Exception in getFileList():FileHandlerBean :"+e,e);
    		returnStatus=-1;
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	  }catch(Exception e){}
	    }	 	 
    	return returnStatus;
    }
	
	/**
	 * This method will create table with given name and columns of  
	 * table will be read from configuration file.
	 * This also creates index on table column(s).
	 * List of column(s) which are to be indexed will be read from configuration file.
	 */
	public static int createTable(String tablename,String mainTable){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		try {
			
			strQuery="create table "+tablename + "("
				+ IViewPropertyReader.IndexTableCreationCommand
				+ ",rowfilename varchar(255),"
				+ "offsetvalue varchar(25)"
				+ ")"  + (ConnectionPool.isMysql?" engine=MyISAM;":" INHERITS ("+mainTable+") ;");
			sqlReader.executeUpdate(strQuery,1000);
			retStatus=1;		
		} catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->insertRecord()->FileHandlerBean : "+ e, e);
			retStatus = -1;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->insertRecord()->FileHandlerBean : "+ e, e);
			retStatus = -1;
		} finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	/**
	 * Creates index for given table name.
	 * @param tableName
	 * @return
	 */
	public static int createIndexTableForTable(String tableName){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		try {
			StringTokenizer indexcolumntoken = new StringTokenizer(IViewPropertyReader.ColumnsListForIndexingOnIndexTable,",");
			while(indexcolumntoken.hasMoreTokens()){
					try{
						String colName=indexcolumntoken.nextToken();
						strQuery="create index "+colName+"_" + tableName+ " on "+tableName+"("+colName+");";
						sqlReader.executeUpdate(strQuery,1000);
					}catch(Exception e){
						CyberoamLogger.appLog.debug("Exception while creating index createTable()->FileHandlerBean->Create index strQuery: " + strQuery+" : "+e,e);
					}
			}
			CyberoamLogger.appLog.debug("createTable()->FileHandlerBean->Create index successfully : ");
			retStatus=1;		
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->insertRecord()->FileHandlerBean : "+ e, e);
			retStatus = -1;
		} finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	/**
	 * This method will create merge table of given comma separated table list. 
	 */
	public static int createMergeTable(String tablename,String mergetablelist){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String existLoadedFileTableList="";
		String strQuery=null;
		try {
			/* We drop table if merge table for requested day already exists */
			if(isTableExists(tablename) == 1){
				dropTable(tablename);
			}
			/* Create merge table only if atleast one file loaded for requested day */
			if(!"".equalsIgnoreCase(mergetablelist)){
				CyberoamLogger.appLog.debug(tablename+" is merge of tables " + mergetablelist); 
				strQuery="create table "+tablename+"("
					+ IViewPropertyReader.IndexTableCreationCommand
					+ ",rowfilename varchar(255),"
					+ "offsetvalue varchar(25)"
					+ ")ENGINE=MERGE UNION=("+mergetablelist+")";
				sqlReader.executeUpdate(strQuery,1000);
			}else{
				CyberoamLogger.appLog.debug("Not a single file loaded in database for day "+tablename.substring(7));
			}
			retStatus=1;		
		} catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->insertRecord()->FileHandlerBean : "+ e, e);
			retStatus = -1;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->insertRecord()->FileHandlerBean : "+ e, e);
			retStatus = -1;
		} finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	/**
	 * This method drops requested table.  
	 */
	public static int dropTable(String tablename){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		strQuery = "drop table "+tablename;
		try {
			sqlReader.executeUpdate(strQuery,1000);
			retStatus=1;
		}catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->dropTable() : "+ e, e);
			retStatus = -1;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->dropTable() : "+ e, e);
			retStatus = -1;
		} finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
	
	public static String unixToDate(String udt){
		int retStatus = -1;
		SqlReader sqlReader = new SqlReader(false);
		String strQuery=null;
		strQuery = "select from_unixtime('"+udt+"') as dt;";
		ResultSetWrapper rsw=null;
		try {
			rsw=sqlReader.getInstanceResultSetWrapper(strQuery);    		    		
    		
			while(rsw.next()){
				return rsw.getString("dt");
	    	}
			
		}catch (SQLException e) {
			CyberoamLogger.appLog.error("Sqlexception->dropTable() : "+ e, e);
			retStatus = -1;
		} catch (Exception e) {
			CyberoamLogger.appLog.error("Exception->dropTable() : "+ e, e);
			retStatus = -1;
		} finally {
			try {
				sqlReader.close();
			} catch (Exception e) {
			}
		}
		return udt;
	}
	
	/**
	 * Returns string representation of {@link FileHandlerBean}.
	 */
	public String toString(){
		return "FileId="+fileID+
			"\n\t filename="+fileName+
			"\n\t filecreationtimestamp="+filecreationtimestamp+
			"\n\t fileeventtimestamp="+fileeventtimestamp+
			"\n\t fileSize="+fileSize+
			"\n\t isLoaded="+isLoaded+
			"\n\t appID="+appID+
			"\n\t lastAccessTimeStamp="+lastAccessTimeStamp;
	}
}
