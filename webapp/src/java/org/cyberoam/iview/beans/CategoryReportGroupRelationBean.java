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
 * This class represents category and report group relation entity.
 * @author Shikha Shah
 *
 */
public class CategoryReportGroupRelationBean {

	
	/**
	 * Properties of Bean
	 */
	private int reportGroupId;
	private int categoryId;
	
	private static long lastAccessed = System.currentTimeMillis();
	private static TreeMap<Integer,ArrayList<Integer>> categoryReportGroupRelationBeanMap = null ;
	
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
	 * Returns category Id.
	 * @return the categoryId
	 */
	public int getCategoryId() {
		return categoryId;
	}

	/**
	 * Sets category Id.
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	/**
	 * Loads all instances of category and report group relation entity into {@link TreeMap}. 
	 * @return
	 */
	
	public static boolean loadAll(){
    	if(categoryReportGroupRelationBeanMap != null){
    		return true;
    	}
    	boolean status=false;
    	ResultSetWrapper rsw=null;
		SqlReader sqlReader = null;
		String strQuery=null;
		ArrayList reportGroupIdList = null;
		CategoryReportGroupRelationBean categoryReportGroupRelationBean=null;
		int categoryId=-1;
    	try{
    		sqlReader = new SqlReader(false);
    		categoryReportGroupRelationBeanMap = new TreeMap();
    		strQuery="select reportgroupid,categoryid from tblreportgroup_category order by categoryid,reportgroupid";
    		rsw=sqlReader.getInstanceResultSetWrapper(strQuery);
    		while(rsw.next()){
    			categoryReportGroupRelationBean=CategoryReportGroupRelationBean.getBeanByResultSetWrapper(rsw);
    			if(categoryReportGroupRelationBean.getCategoryId() != categoryId ){
    				if(categoryId != -1) {
    					categoryReportGroupRelationBeanMap.put(categoryId,reportGroupIdList);
    				}
    				reportGroupIdList = new ArrayList();
    				categoryId=categoryReportGroupRelationBean.getCategoryId();
    			}
    			reportGroupIdList.add(categoryReportGroupRelationBean.getReportGroupId());
    		}   
    		if(reportGroupIdList != null) {
    			categoryReportGroupRelationBeanMap.put(categoryId,reportGroupIdList);
    		}
    	}catch(SQLException e){
    		CyberoamLogger.repLog.error("Exception in loadAll():CategoryReportGroupRelationBean :"+e,e);
    	}catch(Exception e){
    		CyberoamLogger.repLog.error("Exception in loadAll():CategoryReportGroupRelationBean :"+e,e);
    	}finally{
		 	   try{
			 	    sqlReader.close();
			 	    rsw.close();
			 	  }catch(Exception e){}
	    }	 	 
    	return status;
    }
	
	/**
	 * Obtains instance of category report group relation entity by {@link ResultSetWrapper}.
	 * @param rsw
	 * @return
	 */
	public static CategoryReportGroupRelationBean getBeanByResultSetWrapper(ResultSetWrapper rsw) {
		CategoryReportGroupRelationBean  categoryReportGroupRelationBean = new CategoryReportGroupRelationBean();
    	try {
    		categoryReportGroupRelationBean.setReportGroupId(rsw.getInt("reportgroupid"));
    		categoryReportGroupRelationBean.setCategoryId(rsw.getInt("categoryid"));
    	}catch(Exception e) {
    		CyberoamLogger.repLog.error("Exception->getBeanByResultSetWrapper()->CategoryReportGroupRelationBean: " + e,e);
    	}
    	return categoryReportGroupRelationBean;
    }
	
	/**
	 * Returns {@link TreeMap} containing all instances of category report group relation.
	 * @return
	 */
    public static TreeMap getCategoryReportGroupRelationBeanMap(){
    	try{
    		if(categoryReportGroupRelationBeanMap == null){
    			loadAll();
    		}
    		CyberoamLogger.repLog.error("getCategoryReportGroupRelationBean() :CategoryReportGroupRelationBean Ends");
    	}catch (Exception e) {
			CyberoamLogger.repLog.error("Exception :getCategoryReportGroupRelationBean() :CategoryReportGroupRelationBean"+e,e); 
		}
    	return categoryReportGroupRelationBeanMap;
    }
    
    /**
     * Returns {@link Iterator} containing all instances of category report group relation.
     * @return
     */
    public static Iterator getCategoryReportGroupRelationBeanIterator(){
    	Iterator iterator=null;
		try{
			iterator = getCategoryReportGroupRelationBeanMap().values().iterator();
		}catch(Exception e){
			CyberoamLogger.repLog.error("Exception->getCategoryReportGroupRelationBeanIterator()->CategoryReportGroupRelationBean :"+e,e);
		}
		return iterator;
    }
    /**
     * 
     */
    public static ArrayList<Integer> getReportgroupListByCategory(int categoryID){
    	return categoryReportGroupRelationBeanMap.get(categoryID);
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
			sqlQuery="insert into tblreportgroup_category(reportgroupid,categoryid) values("+getReportGroupId()+","+getCategoryId()+")";
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			
			if(retStatus > 0 ) {
				ArrayList<Integer> rgList=CategoryReportGroupRelationBean.getReportgroupListByCategory(getCategoryId());
				rgList.add(getReportGroupId());
				categoryReportGroupRelationBeanMap.put(getCategoryId(), rgList);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->insertRecord()->CategoryReportGroupRelationBean: " + e);
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
			sqlQuery="delete from tblreportgroup_category where categoryid = " + getCategoryId();
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			if(retStatus >= 0){
				ArrayList rgList=CategoryReportGroupRelationBean.getReportgroupListByCategory(getCategoryId());
				rgList.remove(new Integer(getReportGroupId()));				
				categoryReportGroupRelationBeanMap.put(getCategoryId(), rgList);
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->CategoryReportGroupRelationBean: " + e);
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
     * Here multiple comma separated category Ids can be given as argument.
     * @param strCategoryGList
     * @return
     */
	public static int deleteAllRecord(String strCategoryGList){
		lastAccessed = System.currentTimeMillis();
	    String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblreportgroup_category where categoryid in (" + strCategoryGList + ")";
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			
			if (retStatus >= 0) {
				String profileList[] = strCategoryGList.split(",");
				ArrayList<Integer> rgList=null;
				ReportGroupBean reportGroupBean=null;
				for(int i=0;i<profileList.length;i++){
					//categoryReportGroupRelationBeanMap.remove(new Integer(profileList[i]));
					reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(profileList[i]));				
					rgList=CategoryReportGroupRelationBean.getReportgroupListByCategory(reportGroupBean.getCategoryId());
					rgList.remove(new Integer(reportGroupBean.getReportGroupId()));
					categoryReportGroupRelationBeanMap.put(reportGroupBean.getCategoryId(), rgList);
				}
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->CategoryReportGroupRelationBean: " + e);
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
     * Here multiple comma separated category Ids can be given as argument.
     * @param strReportGroupGList
     * @return
     */
	public static int deleteAllRecordByReportGroupId(String strReportGroupGList){
		lastAccessed = System.currentTimeMillis();
	    String sqlQuery = null;		
		int retStatus = -1;	
		SqlReader sqlReader = null;
		try{
			sqlReader=new SqlReader(false);
			sqlQuery="delete from tblreportgroup_category where reportgroupid in (" + strReportGroupGList + ")";
			retStatus = sqlReader.executeUpdate(sqlQuery,5);
			
			if (retStatus >= 0) {
				ArrayList<Integer> rgList=null;
				ReportGroupBean reportGroupBean=null;
				String profileList[] = strReportGroupGList.split(",");
				for(int i=0;i<profileList.length;i++){
					reportGroupBean = ReportGroupBean.getRecordbyPrimarykey(Integer.parseInt(profileList[i]));				
					rgList=CategoryReportGroupRelationBean.getReportgroupListByCategory(reportGroupBean.getCategoryId());
					rgList.remove(new Integer(reportGroupBean.getReportGroupId()));
					categoryReportGroupRelationBeanMap.put(reportGroupBean.getCategoryId(), rgList);
				}
				retStatus=1;
			}
		}catch(Exception e){
			CyberoamLogger.appLog.error("Exception->deleteRecord()->CategoryReportGroupRelationBean: " + e);
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
