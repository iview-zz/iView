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
package org.cyberoam.iview.beans;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeMap;

import org.cyberoam.iview.audit.CyberoamLogger;
import org.cyberoam.iviewdb.utility.ResultSetWrapper;
import org.cyberoam.iviewdb.utility.SqlReader;




/**
 * This class represents report and report group relation entity.
 * @author Narendra Shah
 *
 */
public class ReportGroupRelationBean {

	
	/**
	 * Properties of Bean
	 */
	private int reportGroupId;
	private int reportId;
	private int rowOrder;
	
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap reportGroupRelationBeanMap = null ;
	
	static{
		loadAll();
	}
	/**
	 * Returns report group Id.
	 * @return the reportGroupId
	 */
	public int getReportGroupId() {
		return reportGroupId;
	}

	/**
	 * Sets report group Id.
	 * @param reportGroupId the reportGroupId to set
	 */
	public void setReportGroupId(int reportGroupId) {
		this.reportGroupId = reportGroupId;
	}

	/**
	 * Returns report Id.
	 * @return the reportId
	 */
	public int getReportId() {
		return reportId;
	}

	/**
	 * Sets report Id.
	 * @param reportId the reportId to set
	 */
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	/**
	 * Returns row order to be used to display report.Here NM(N for row number and M for column number) is used as row order.
	 * <br>For e.g. 12 states 1st row and 2nd column.
	 * @return the rowOrder
	 */
	public int getRowOrder() {
		return rowOrder;
	}

	/**
	 * Sets row order to be used to display report.Here NM(N for row number and M for column number) is used as row order.
	 * <br>For e.g. 12 states 1st row and 2nd column.
	 * @param rowOrder the rowOrder to set
	 */
	public void setRowOrder(int rowOrder) {
		this.rowOrder = rowOrder;
	}

	/**
	 * Loads all instances of report and report group relation entity into {@link TreeMap}. 
	 * @return
	 */
	public static boolean loadAll(){
    	if(reportGroupRelationBeanMap != null){
    		return true;
    	}
    	boolean status=false;
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ArrayList reportIdList = null;
		ReportGroupRelationBean reportGroupRelationBean=null;
		int reportGroupId=-1;
    	try{
    		sqlReader = new SqlReader(false);
    		reportGroupRelationBeanMap = new TreeMap();
    		strQuery="select reportgroupid,reportid,roworder from tblreportgrouprel order by reportgroupid,roworder,reportid ";
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		if(rsw.next())
    		{
    			reportGroupRelationBean=ReportGroupRelationBean.getBeanByResultSetWrapper(rsw);
    			reportGroupId=reportGroupRelationBean.getReportGroupId();
    			reportIdList = new ArrayList();
	    		while(rsw.next()){
	    			reportIdList.add(reportGroupRelationBean);
	    			reportGroupRelationBean=ReportGroupRelationBean.getBeanByResultSetWrapper(rsw);
	    			if(reportGroupRelationBean.getReportGroupId() != reportGroupId){
	    				reportGroupRelationBeanMap.put(new Integer(reportGroupId),reportIdList);
	    				reportGroupId=reportGroupRelationBean.getReportGroupId();
	        			reportIdList = new ArrayList();
	    			}
	    		}
	    		reportIdList.add(reportGroupRelationBean);
	    		reportGroupRelationBeanMap.put(new Integer(reportGroupId),reportIdList);
    		}
    	}catch(SQLException e){
    		CyberoamLogger.repLog.error("Exception in loadAll():ReportGroupRelationBean :"+e,e);
    	}catch(Exception e){
    		CyberoamLogger.repLog.error("Exception in loadAll():ReportGroupRelationBean :"+e,e);
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	  }catch(Exception e){}
	    }	 	 
    	return status;
    }
	
	/**
	 * Obtains instance of report group relation entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static ReportGroupRelationBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		ReportGroupRelationBean  reportGroupRelationBean = new ReportGroupRelationBean();
    	try {
    		reportGroupRelationBean.setReportGroupId(rsw.getInt("reportgroupid"));
    		reportGroupRelationBean.setReportId(rsw.getInt("reportid"));
    		reportGroupRelationBean.setRowOrder(rsw.getInt("roworder"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->ReportGroupRelationBean: " + e,e);
    	}
    	return reportGroupRelationBean;
    }
	
	/**
	 * Returns {@link TreeMap} containing all instances of report group relation.
	 * @return
	 */
    public static TreeMap getReportGroupRelationBeanMap(){
    	try{
    		if(reportGroupRelationBeanMap == null){
    			loadAll();
    		}
    	}catch (Exception e) {
			CyberoamLogger.repLog.error("Exception :getReportGroupRelationBeanMap() :ReportGroupRelationBean"+e,e); 
		}
    	return reportGroupRelationBeanMap;
    }
    
    /**
     * Returns {@link Iterator} containing all instances of report group relation.
     * @return
     */
    public static Iterator getReportGroupRelationBeanIterator(){
    	Iterator iterator=null;
		try{
			iterator = getReportGroupRelationBeanMap().values().iterator();
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getReportGroupRelationBeanIterator()->ReportGroupRelationBean :"+e,e);
		}
		return iterator;
    }
    
    /**
     * Inserts SQL Record into database table.
     * @return
     */
    public int insertRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="insert into tblreportgrouprel(reportgroupid,reportid,roworder) values("+getReportGroupId()+","+getReportId()+","+getRowOrder()+")";
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->insertRecord()->ReportGroupRelationBean: " + e);
			return -1;
		}finally{
			try {
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
    
	/**
	 * Deletes SQL Record from database table.
	 * @return
	 */
    public int deleteRecord(){
		lastAccessed = System.currentTimeMillis();
        String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblreportgrouprel where reportgroupid = " + getReportGroupId();
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			if(retStatus >= 0){
				reportGroupRelationBeanMap.remove(new Integer(getReportGroupId()));
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->ReportGroupRelationBean: " + e);
			return -1;
		}finally{
			try {
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}

    /**
     * Deletes multiple SQL Records from database table.
     * Here multiple comma separated report group Ids can be given as argument.
     * @param strReportGList
     * @return
     */
	public static int deleteAllRecord(String strReportGList){
		lastAccessed = System.currentTimeMillis();
	    String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblreportgrouprel where reportgroupid in (" + strReportGList + ")";
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			
			if (retStatus >= 0) {
				String profileList[] = strReportGList.split(",");
				for(int i=0;i<profileList.length;i++){
					reportGroupRelationBeanMap.remove(new Integer(profileList[i]));
				}
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->ReportGroupRelationBean: " + e);
			return -1;
		}finally{
			try {
				sqlReader.close();				
			} catch (Exception e) {
			}
		}
		return retStatus;
	}
}
