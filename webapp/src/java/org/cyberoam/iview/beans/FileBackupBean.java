package org.cyberoam.iview.beans;

import java.sql.SQLException;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iview.utility.StringMaker;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;

/**
 * This Bean is used to store backupfile name and retrieve startdate and enddate for the specified period. 
 * @author Jenit Shah
 *
 */

public class FileBackupBean {
	private String startdate;
	private String enddate;
	private String filenames;
	
	public FileBackupBean(String startdate,String enddate){
		this.startdate=startdate;
		this.enddate=enddate;
	}	
	public String getStartDate(){
		return startdate;
	}
	public void setStartDate(String startdate){
		this.startdate=startdate;
	}
	public String getEnddate(){
		return enddate;
	}
	public void setEndDate(String endate){
		this.startdate=enddate;
	}
	public void setFileNames(String filenames){
		this.filenames=filenames;
	}
	public String getFileNames(){
		return filenames;
	}
	
	public int insertRecord(){
		String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="insert into tblbackupfile (startdate,enddate) values (" + 
				StringMaker.makeString(getStartDate())+ "," +
				StringMaker.makeString(getEnddate())+")";  
			retStatus =  sqlReader.executeUpdate(sqlQuery,5);
		}catch(SQLException e){
			retStatus=-1;
		}finally{
			try {
				sqlReader.close();							
			}catch (Exception e) {				
			}
		}
		return retStatus;
	}
	
	public int getsqlrecordsforfilenames(){
		int retStatus=-1;
		String filenames=null;
		String sqlquery=null;
		SqlReader sqlReader = new SqlReader(false);
		ResultSetWrapper rsw = null;
		try{
		sqlquery=" select startdate,enddate from tblbackupfile where (startdate >= "+StringMaker.makeString(getStartDate())+
		" and startdate <= "+StringMaker.makeString(getEnddate())+" ) or (enddate <= "+StringMaker.makeString(getEnddate())+" and enddate >= "+StringMaker.makeString(getStartDate())+" )";
		
		rsw = sqlReader.getInstanceResultSetWrapper(sqlquery);
		while(rsw.next()){
			if(rsw.isFirst())
				filenames = rsw.getString("startdate")+"-"+rsw.getString("enddate")+".zip"+",";
			else
			filenames = filenames + rsw.getString("startdate")+"-"+rsw.getString("enddate")+".zip"+",";				
		}
		
		setFileNames(filenames);
		retStatus=1;
		}catch(SQLException e){
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->RoleBean : "+ e, e);
			retStatus = -1;
		}catch(Exception e){
			CyberoamLogger.repLog.error("Sqlexception->loadAll()->RoleBean : "+ e, e);
			retStatus = -1;
		}finally{
			try{
			rsw.close();			
			sqlReader.close();
			}catch(Exception e){
			}		
		}				
		return retStatus;
	}
	
}
